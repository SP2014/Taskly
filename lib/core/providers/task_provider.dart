import 'package:flutter/material.dart';
import 'package:flutter_playground/core/models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _toDoList = [];
  List<Task> get itemsList => _toDoList;

  Task getById(String id) => _toDoList.firstWhere((task) => task.id == id);

  void createNewTask(Task task) {
    final newTask = Task(
      id: task.id,
      description: task.description,
      dueDate: task.dueDate,
      dueTime: task.dueTime,
    );
    _toDoList.add(newTask);
    notifyListeners();
  }

  void editTask(Task task) {
    removeTask(task.id);
    createNewTask(task);
  }

  void removeTask(String id) {
    _toDoList.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void changeStatus(String id){
    int idx = _toDoList.indexWhere((task) => task.id == id);
    _toDoList[idx].isDone = !_toDoList[idx].isDone;
    notifyListeners();
  }
}
