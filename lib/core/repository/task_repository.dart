import 'package:flutter_playground/core/models/task.dart';

abstract class TaskRepository{
  Future<List<Task>> getAllTask();
  void deleteTask(String id);
  void addOrUpdateTask(Task task);
}