import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/supabase_service.dart';

class AuthProvider extends ChangeNotifier {
  AppUser? _currentUser;
  bool _isLoading = false;
  String? _error;

  AppUser? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _currentUser != null;

  void setUser(AppUser? user) {
    _currentUser = user;
    notifyListeners();
  }

  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  Future<void> signIn(String email, String password) async {
    setLoading(true);
    setError(null);

    try {
      final response = await SupabaseService.signIn(email, password);
      
      if (response.user != null) {
        final user = AppUser(
          id: response.user!.id,
          email: response.user!.email ?? email,
          fullName: response.user!.userMetadata?['full_name'] as String?,
          createdAt: DateTime.parse(response.user!.createdAt),
        );
        setUser(user);
      }
    } catch (e) {
      setError('Login failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> signUp(String email, String password, String fullName) async {
    setLoading(true);
    setError(null);

    try {
      final response = await SupabaseService.signUp(email, password);
      
      if (response.user != null) {
        final user = AppUser(
          id: response.user!.id,
          email: response.user!.email ?? email,
          fullName: fullName,
          createdAt: DateTime.parse(response.user!.createdAt),
        );
        setUser(user);
      }
    } catch (e) {
      setError('Sign up failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> signOut() async {
    setLoading(true);
    
    try {
      await SupabaseService.signOut();
      setUser(null);
    } catch (e) {
      setError('Sign out failed: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  // Initialize user from current session
  void initializeUser() {
    final currentUser = SupabaseService.currentUser;
    if (currentUser != null) {
      final user = AppUser(
        id: currentUser.id,
        email: currentUser.email ?? '',
        fullName: currentUser.userMetadata?['full_name'] as String?,
        createdAt: DateTime.parse(currentUser.createdAt),
      );
      setUser(user);
    }
  }
}