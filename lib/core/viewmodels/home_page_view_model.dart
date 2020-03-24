
import 'package:flutter/material.dart';
import 'package:flutter_playground/core/models/task.dart';
import 'package:flutter_playground/core/providers/dark_theme_provider.dart';
import 'package:flutter_playground/core/repository/task_repository.dart';
import 'package:flutter_playground/locator.dart';
import 'package:provider/provider.dart';

class HomePageViewModel with ChangeNotifier{
  final _taskRepository = locator<TaskRepository>();
  List<Task> _taskList = [];
  List<Task> get taskList => _taskList;
  
  Future<void> init() async {
    final tlist = await _taskRepository.getAllTask();
    _taskList = tlist.toList();
    notifyListeners();
  }

  void onAddTask(Task task) {
    _taskList.add(task);
    notifyListeners();
    _taskRepository.addOrUpdateTask(task);
  }

  void onEditTask(Task task){
    int idx = _taskList.indexWhere((element) => element.id == task.id);
    _taskList.removeAt(idx);
    _taskList.insert(idx, task);
    notifyListeners();
    _taskRepository.addOrUpdateTask(task);
  }

  void onToggleCheck(String id){
    int idx = _taskList.indexWhere((element) => element.id == id);
    _taskList[idx].isDone = !_taskList[idx].isDone;
    notifyListeners();
    _taskRepository.addOrUpdateTask(_taskList[idx]);
    
  }

  void onDelete(String id){
    _taskRepository.deleteTask(id);
    _taskList.removeWhere((element) => element.id==id);
    notifyListeners();
  }

  void toggleTheme(BuildContext context) {
      final themeChange = Provider.of<DarkThemeProvider>(context, listen: false);
      themeChange.darkTheme = !themeChange.darkTheme;
  }
}