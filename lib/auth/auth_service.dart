import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';
import '../models/user.dart';

class AuthService {
  static Future<AuthResponse> signUp(String email, String password) async {
    return await SupabaseService.signUp(email, password);
  }

  static Future<AuthResponse> signIn(String email, String password) async {
    return await SupabaseService.signIn(email, password);
  }

  static Future<void> signOut() async {
    return await SupabaseService.signOut();
  }

  static User? get currentUser => SupabaseService.currentUser;
  
  static Session? get currentSession => SupabaseService.currentSession;
  
  static bool get isSignedIn => currentUser != null;

  static AppUser? getCurrentAppUser() {
    final user = currentUser;
    if (user == null) return null;
    
    return AppUser(
      id: user.id,
      email: user.email ?? '',
      fullName: user.userMetadata?['full_name'] as String?,
      avatarUrl: user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.parse(user.createdAt),
    );
  }
}