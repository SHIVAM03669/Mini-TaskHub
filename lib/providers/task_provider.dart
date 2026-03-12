import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/supabase_service.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _error;

  List<Task> get tasks => _tasks;
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();
  List<Task> get ongoingTasks => _tasks.where((task) => !task.isCompleted).toList();
  bool get isLoading => _isLoading;
  String? get error => _error;

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

  Future<void> loadTasks() async {
    setLoading(true);
    setError(null);

    try {
      _tasks = await SupabaseService.getTasks();
      notifyListeners();
    } catch (e) {
      setError('Failed to load tasks: ${e.toString()}');
    } finally {
      setLoading(false);
    }
  }

  Future<void> addTask({required String title, String? description}) async {
    try {
      final newTask = await SupabaseService.createTask(title, description: description);
      _tasks.insert(0, newTask);
      notifyListeners();
    } catch (e) {
      setError('Failed to add task: ${e.toString()}');
    }
  }

  Future<void> toggleTaskCompletion(Task task) async {
    try {
      await SupabaseService.updateTask(
        task.id,
        isCompleted: !task.isCompleted,
      );
      
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task.copyWith(isCompleted: !task.isCompleted);
        notifyListeners();
      }
    } catch (e) {
      setError('Failed to update task: ${e.toString()}');
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await SupabaseService.deleteTask(task.id);
      _tasks.removeWhere((t) => t.id == task.id);
      notifyListeners();
    } catch (e) {
      setError('Failed to delete task: ${e.toString()}');
    }
  }

  Future<void> updateTask(Task updatedTask) async {
    try {
      await SupabaseService.updateTask(
        updatedTask.id,
        title: updatedTask.title,
        description: updatedTask.description,
        isCompleted: updatedTask.isCompleted,
      );
      
      final index = _tasks.indexWhere((t) => t.id == updatedTask.id);
      if (index != -1) {
        _tasks[index] = updatedTask;
        notifyListeners();
      }
    } catch (e) {
      setError('Failed to update task: ${e.toString()}');
    }
  }

  // Real-time updates
  void startRealtimeUpdates() {
    try {
      SupabaseService.getTasksStream().listen(
        (tasks) {
          _tasks = tasks;
          notifyListeners();
        },
        onError: (error) {
          setError('Real-time update failed: ${error.toString()}');
        },
      );
    } catch (e) {
      setError('Failed to start real-time updates: ${e.toString()}');
    }
  }
}