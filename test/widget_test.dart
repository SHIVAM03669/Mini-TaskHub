// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:mini_taskhub/providers/theme_provider.dart';
import 'package:mini_taskhub/providers/auth_provider.dart';
import 'package:mini_taskhub/providers/task_provider.dart';
import 'package:mini_taskhub/app/theme.dart';

void main() {
  testWidgets('App theme loads correctly', (WidgetTester tester) async {
    // Build a simple test widget with providers
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => TaskProvider()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp(
              title: 'Mini TaskHub Test',
              theme: themeProvider.isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
              home: const Scaffold(
                body: Center(
                  child: Text('Test App'),
                ),
              ),
            );
          },
        ),
      ),
    );

    // Verify that the app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.text('Test App'), findsOneWidget);
  });
}
