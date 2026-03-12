import 'package:flutter_test/flutter_test.dart';
import 'package:mini_taskhub/models/task.dart';

void main() {
  group('Task Model Tests', () {
    test('should create Task from JSON correctly', () {
      // Arrange
      final json = {
        'id': '123e4567-e89b-12d3-a456-426614174000',
        'user_id': '987fcdeb-51a2-43d1-9c4f-123456789abc',
        'title': 'Test Task',
        'description': 'Test Description',
        'is_completed': false,
        'created_at': '2024-01-01T10:00:00.000Z',
        'updated_at': '2024-01-01T11:00:00.000Z',
        'due_date': null,
      };

      // Act
      final task = Task.fromJson(json);

      // Assert
      expect(task.id, '123e4567-e89b-12d3-a456-426614174000');
      expect(task.userId, '987fcdeb-51a2-43d1-9c4f-123456789abc');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, false);
      expect(task.createdAt, DateTime.parse('2024-01-01T10:00:00.000Z'));
      expect(task.updatedAt, DateTime.parse('2024-01-01T11:00:00.000Z'));
      expect(task.dueDate, null);
      expect(task.progress, 0.0);
    });

    test('should convert Task to JSON correctly', () {
      // Arrange
      final task = Task(
        id: '123e4567-e89b-12d3-a456-426614174000',
        userId: '987fcdeb-51a2-43d1-9c4f-123456789abc',
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: true,
        createdAt: DateTime.parse('2024-01-01T10:00:00.000Z'),
        updatedAt: DateTime.parse('2024-01-01T11:00:00.000Z'),
      );

      // Act
      final json = task.toJson();

      // Assert
      expect(json['id'], '123e4567-e89b-12d3-a456-426614174000');
      expect(json['user_id'], '987fcdeb-51a2-43d1-9c4f-123456789abc');
      expect(json['title'], 'Test Task');
      expect(json['description'], 'Test Description');
      expect(json['is_completed'], true);
      expect(json['created_at'], '2024-01-01T10:00:00.000Z');
      expect(json['updated_at'], '2024-01-01T11:00:00.000Z');
      expect(task.progress, 1.0);
    });

    test('should create copy with updated values', () {
      // Arrange
      final originalTask = Task(
        id: '123e4567-e89b-12d3-a456-426614174000',
        userId: '987fcdeb-51a2-43d1-9c4f-123456789abc',
        title: 'Original Task',
        description: 'Original Description',
        isCompleted: false,
        createdAt: DateTime.parse('2024-01-01T10:00:00.000Z'),
      );

      // Act
      final updatedTask = originalTask.copyWith(
        title: 'Updated Task',
        isCompleted: true,
        description: 'Updated Description',
      );

      // Assert
      expect(updatedTask.id, originalTask.id);
      expect(updatedTask.userId, originalTask.userId);
      expect(updatedTask.title, 'Updated Task');
      expect(updatedTask.description, 'Updated Description');
      expect(updatedTask.isCompleted, true);
      expect(updatedTask.createdAt, originalTask.createdAt);
      expect(updatedTask.progress, 1.0);
    });

    test('should handle JSON serialization round trip', () {
      // Arrange
      final originalTask = Task(
        id: '123e4567-e89b-12d3-a456-426614174000',
        userId: '987fcdeb-51a2-43d1-9c4f-123456789abc',
        title: 'Round Trip Task',
        description: 'Round Trip Description',
        isCompleted: false,
        createdAt: DateTime.parse('2024-01-01T10:00:00.000Z'),
        updatedAt: DateTime.parse('2024-01-01T11:00:00.000Z'),
      );

      // Act
      final json = originalTask.toJson();
      final reconstructedTask = Task.fromJson(json);

      // Assert
      expect(reconstructedTask.id, originalTask.id);
      expect(reconstructedTask.userId, originalTask.userId);
      expect(reconstructedTask.title, originalTask.title);
      expect(reconstructedTask.description, originalTask.description);
      expect(reconstructedTask.isCompleted, originalTask.isCompleted);
      expect(reconstructedTask.createdAt, originalTask.createdAt);
      expect(reconstructedTask.updatedAt, originalTask.updatedAt);
    });

    test('should handle null values correctly', () {
      // Arrange
      final json = {
        'id': '123e4567-e89b-12d3-a456-426614174000',
        'user_id': '987fcdeb-51a2-43d1-9c4f-123456789abc',
        'title': 'Test Task',
        'description': null,
        'is_completed': null,
        'created_at': '2024-01-01T10:00:00.000Z',
        'updated_at': null,
        'due_date': null,
      };

      // Act
      final task = Task.fromJson(json);

      // Assert
      expect(task.description, null);
      expect(task.isCompleted, false); // Should default to false
      expect(task.updatedAt, null);
      expect(task.dueDate, null);
      expect(task.progress, 0.0);
    });
  });
}