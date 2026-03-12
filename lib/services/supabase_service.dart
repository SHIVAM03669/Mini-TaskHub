import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/task.dart';

class SupabaseService {
  static SupabaseClient get instance => Supabase.instance.client;
  
  static User? get currentUser => instance.auth.currentUser;
  
  static Session? get currentSession => instance.auth.currentSession;
  
  // Auth methods
  static Future<AuthResponse> signUp(String email, String password) async {
    try {
      return await instance.auth.signUp(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }
  
  static Future<AuthResponse> signIn(String email, String password) async {
    try {
      return await instance.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }
  
  static Future<void> signOut() async {
    try {
      await instance.auth.signOut();
    } catch (e) {
      throw Exception('Sign out failed: ${e.toString()}');
    }
  }
  
  // Task methods with real Supabase integration
  static Future<List<Task>> getTasks() async {
    final userId = currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');
    
    try {
      final response = await instance
          .from('tasks')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);
      
      return (response as List).map((task) => Task.fromJson(task)).toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks: ${e.toString()}');
    }
  }
  
  static Future<Task> createTask(String title, {String? description}) async {
    final userId = currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');
    
    try {
      final response = await instance
          .from('tasks')
          .insert({
            'user_id': userId,
            'title': title,
            'description': description,
            'is_completed': false,
          })
          .select()
          .single();
      
      return Task.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create task: ${e.toString()}');
    }
  }
  
  static Future<void> updateTask(String taskId, {String? title, String? description, bool? isCompleted}) async {
    try {
      final updateData = <String, dynamic>{};
      if (title != null) updateData['title'] = title;
      if (description != null) updateData['description'] = description;
      if (isCompleted != null) updateData['is_completed'] = isCompleted;
      
      await instance
          .from('tasks')
          .update(updateData)
          .eq('id', taskId);
    } catch (e) {
      throw Exception('Failed to update task: ${e.toString()}');
    }
  }
  
  static Future<void> deleteTask(String taskId) async {
    try {
      await instance
          .from('tasks')
          .delete()
          .eq('id', taskId);
    } catch (e) {
      throw Exception('Failed to delete task: ${e.toString()}');
    }
  }

  // Real-time subscription for tasks
  static Stream<List<Task>> getTasksStream() {
    final userId = currentUser?.id;
    if (userId == null) throw Exception('User not authenticated');
    
    return instance
        .from('tasks')
        .stream(primaryKey: ['id'])
        .eq('user_id', userId)
        .order('created_at', ascending: false)
        .map((data) => data.map((task) => Task.fromJson(task)).toList());
  }
}