import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/theme.dart';
import 'auth/login_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // TODO: Replace with your actual Supabase credentials
  const supabaseUrl = 'https://your-project-id.supabase.co';
  const supabaseAnonKey = 'your-anon-key-here';
  
  // Check if credentials are configured
  if (supabaseUrl == 'YOUR_SUPABASE_URL' || supabaseAnonKey == 'YOUR_SUPABASE_ANON_KEY') {
    print('⚠️  SETUP REQUIRED: Please configure your Supabase credentials in lib/main.dart');
    print('📖 See README.md for setup instructions');
  }
  
  try {
    // Initialize Supabase
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  } catch (e) {
    print('❌ Supabase initialization failed: $e');
    print('📖 Please check your credentials and network connection');
  }
  
  runApp(const DayTaskApp());
}

class DayTaskApp extends StatelessWidget {
  const DayTaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Mini TaskHub',
            theme: themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
            initialRoute: '/',
            routes: {
              '/': (context) => const AuthWrapper(),
              '/login': (context) => const LoginScreen(),
              '/dashboard': (context) => const DashboardScreen(),
            },
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Check if Supabase is properly configured
    try {
      return StreamBuilder<AuthState>(
        stream: Supabase.instance.client.auth.onAuthStateChange,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          
          final session = snapshot.data?.session;
          if (session != null) {
            // Initialize user in auth provider
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<AuthProvider>().initializeUser();
              context.read<TaskProvider>().loadTasks();
              context.read<TaskProvider>().startRealtimeUpdates();
            });
            return const DashboardScreen();
          } else {
            return const LoginScreen();
          }
        },
      );
    } catch (e) {
      // Show setup instructions if Supabase is not configured
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.settings,
                  size: 64,
                  color: Colors.orange,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Setup Required',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Please configure your Supabase credentials to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 24),
                const Text(
                  '1. Create a Supabase project at supabase.com\n'
                  '2. Get your project URL and anon key\n'
                  '3. Update lib/main.dart with your credentials\n'
                  '4. Set up the database schema (see README.md)',
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Restart the app (in development)
                    // In production, user would need to restart manually
                  },
                  child: const Text('Restart App'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
