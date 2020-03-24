import 'package:flutter_playground/core/data_sources/task_local_data_source.dart';
import 'package:flutter_playground/core/models/task.dart';
import 'package:flutter_playground/core/repository/task_repository.dart';
import 'package:flutter_playground/locator.dart';

class TaskRepositoryImpl implements TaskRepository {

  final taskLocalDataSource = locator<TaskLocalDataSource>();
  @override
  void addOrUpdateTask(Task task) {
       taskLocalDataSource.addOrUpdateTask(task);
    }
  
    @override
    void deleteTask(String id) {
      taskLocalDataSource.deleteTask(id);
    }
  
    @override
    Future<List<Task>> getAllTask() async {
      final tasks = await taskLocalDataSource.getAllTasks();
      return tasks;
    }
  
}