class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    
    return null;
  }

  static String? taskTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Task title is required';
    }
    
    if (value.trim().isEmpty) {
      return 'Task title cannot be empty';
    }
    
    if (value.length > 100) {
      return 'Task title must be less than 100 characters';
    }
    
    return null;
  }
}