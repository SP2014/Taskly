import 'package:flutter/material.dart';
import 'package:flutter_playground/core/models/task.dart';

import 'list_item.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final void Function(String) onDelete;
  final void Function(Task) onEdit;
  final void Function(String) onToggle;

  const TaskList({@required this.tasks, @required this.onDelete, this.onEdit, @required this.onToggle})
      : assert(tasks != null),
        assert(onDelete != null),
        assert(onEdit != null),
        assert(onToggle != null);

  @override
  Widget build(BuildContext context) {
    return tasks.length > 0
        ? ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) => ListItem(
                  task: tasks[index],
                  onDelete: onDelete,
                  onToggle: onToggle,
                  onEdit: onEdit,
                ))
        : LayoutBuilder(
            builder: (context, constraints) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: constraints.maxHeight * 0.5,
                        child: Image.asset('assets/images/waiting.png',
                            fit: BoxFit.cover),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'No tasks added yet...',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ],
                  ),
                ));
  }
}
