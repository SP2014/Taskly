import 'package:flutter/material.dart';
import 'package:flutter_playground/core/models/task.dart';

import 'add_new_task.dart';
import 'item_text.dart';

class ListItem extends StatelessWidget {
  final Task task;
  final void Function(String) onDelete;
  final void Function(String) onToggle;
  final void Function(Task) onEdit;
  const ListItem(
      {@required this.task, @required this.onDelete, @required this.onToggle, @required this.onEdit})
      : assert(task != null),
        assert(onDelete != null),
        assert(onToggle != null),
        assert(onEdit != null);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: ValueKey(task.id),
        direction: DismissDirection.endToStart,
        onDismissed: (_) => onDelete(task.id),
        background: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'DELETE',
                style: TextStyle(
                  color: Theme.of(context).errorColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(width: 5),
              Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
                size: 28,
              ),
            ],
          ),
        ),
        child: GestureDetector(
            onTap: () => onToggle(task.id),
            child: Container(
              height: 65,
              child: Card(
                elevation: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: task.isDone,
                          onChanged: (_) => onToggle(task.id),
                        ),
                        ItemText(
                          task.isDone,
                          task.description,
                          task.dueDate,
                          task.dueTime,
                        ),
                      ],
                    ),
                    if (!task.isDone)
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          final nt = await showModalBottomSheet(
                            context: context,
                            builder: (_) => AddNewTask(
                              id: task.id,
                              isEditMode: true,
                              task: task,
                            ),
                          );
                          if(nt!= null) onEdit(nt);
                        },
                      ),
                  ],
                ),
              ),
            )));
  }
}

// class ListItem extends StatefulWidget {
//   final Task task;
//   final void Function(String) onDelete;
//   ListItem({@required this.task, @required this.onDelete});
//   _ListItemState createState() => _ListItemState();
// }

// class _ListItemState extends State<ListItem> {
//   final taskRepository = locator<TaskRepository>();
//   @override
//   Widget build(BuildContext context) {
//     return Dismissible(
//         key: ValueKey(widget.task.id),
//         direction: DismissDirection.endToStart,
//         onDismissed: (_) {
//           Provider.of<TaskProvider>(context, listen: false)
//               .removeTask(widget.task.id);
//           taskRepository.deleteTask(widget.task.id);
//         },
//         background: Container(
//           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'DELETE',
//                 style: TextStyle(
//                   color: Theme.of(context).errorColor,
//                   fontSize: 16,
//                 ),
//               ),
//               SizedBox(width: 5),
//               Icon(
//                 Icons.delete,
//                 color: Theme.of(context).errorColor,
//                 size: 28,
//               ),
//             ],
//           ),
//         ),
//         child: GestureDetector(
//             onTap: _checkItem,
//             child: Container(
//               height: 65,
//               child: Card(
//                 elevation: 10,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Checkbox(
//                           value: widget.task.isDone,
//                           onChanged: (_) => _checkItem(),
//                         ),
//                         ItemText(
//                           widget.task.isDone,
//                           widget.task.description,
//                           widget.task.dueDate,
//                           widget.task.dueTime,
//                         ),
//                       ],
//                     ),
//                     if (!widget.task.isDone)
//                       IconButton(
//                         icon: Icon(Icons.edit),
//                         onPressed: () {
//                           showModalBottomSheet(
//                             context: context,
//                             builder: (_) => AddNewTask(
//                               id: widget.task.id,
//                               isEditMode: true,
//                             ),
//                           );
//                         },
//                       ),
//                   ],
//                 ),
//               ),
//             )));
//   }

//   void _checkItem() {
//     widget.task.changeStatus = !widget.task.isDone;
//     taskRepository.addOrUpdateTask(widget.task);
//     print(widget.task.isDone);
//     Provider.of<TaskProvider>(context, listen: false)
//         .changeStatus(widget.task.id);
//   }
// }
