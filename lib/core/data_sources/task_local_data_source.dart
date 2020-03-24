
import 'package:flutter_playground/core/models/task.dart';
import 'package:flutter_playground/core/models/task_box.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../locator.dart';


abstract class TaskLocalDataSource{
  Future<void> init();
  Future<List<Task>> getAllTasks();
  void addOrUpdateTask(Task task);
  void deleteTask(String id);
}

class TaskLocalDataSourceImpl implements TaskLocalDataSource{

  final _hiveService = locator<HiveInterface>();
  bool get _isBoxOpen => _hiveService.isBoxOpen("task");
  Box<TaskBox> get _taskBox => _hiveService.box<TaskBox>("task");

  @override
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _hiveService.init(directory.path);
    _hiveService.registerAdapter<TaskBox>(TaskBoxAdapter());

    if(!_isBoxOpen) await _hiveService.openBox<TaskBox>("task");
  }

  @override
  Future<List<Task>> getAllTasks() async {
    if(_taskBox.isEmpty) return [];
    return _taskBox.values.map<Task>((task) => Task.fromMap(task.toMap())).toList();
  }

  @override
  void addOrUpdateTask(Task task){
    _taskBox.put(task.id, TaskBox.fromTask(task));
  }

  @override
  void deleteTask(String id){
    _taskBox.delete(id);
  }

  
  
}