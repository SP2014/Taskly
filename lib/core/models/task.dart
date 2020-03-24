import 'package:flutter/material.dart';

class Task {
  final String id;
  String description;
  DateTime dueDate;
  String dueTime;
  bool isDone;

  Task(
      {@required this.id,
      this.description,
      this.dueDate,
      this.dueTime,
      this.isDone = false});

  set changeStatus(bool val) => this.isDone = val;    

  factory Task.fromMap(Map<String, dynamic> task){
    return new Task(id: task['id'], description: task['description'], dueDate: DateTime.parse(task['dueDate']), dueTime:task['dueTime'], isDone: task['isDone']);
  }    

}
