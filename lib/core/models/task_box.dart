import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'task.dart';

part 'task_box.g.dart';

@HiveType(typeId: 0)
class TaskBox{
  @HiveField(0)
  final String id;
  @HiveField(1)
  String description;
  @HiveField(2)
  String dueDate;
  @HiveField(3)
  String dueTime;
  @HiveField(4)
  bool isDone;

  TaskBox({@required this.id, this.description, this.dueDate, this.dueTime, this.isDone=false});

  factory TaskBox.fromTask(Task task){
    return TaskBox(id: task.id, description: task.description, dueDate: task.dueDate.toIso8601String(), dueTime: task.dueTime, isDone: task.isDone);
  }

  Map<String, dynamic> toMap(){
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['description'] = description;
    map['dueDate'] = dueDate;
    map['dueTime'] = dueTime;
    map['isDone'] = isDone;
    return map;
  }
}