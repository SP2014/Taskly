import 'package:flutter/material.dart';
import 'package:flutter_playground/core/models/task.dart';
import 'package:intl/intl.dart';


class AddNewTask extends StatefulWidget {
  final String id;
  final bool isEditMode;
  final Task task;

  AddNewTask({
    this.id,
    @required this.isEditMode,
    this.task,
  }): assert(isEditMode!=null);

  @override
  _AddNewTaskState createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  String _selectedTime;
  DateTime _selectedDate;
  String _inputDescription;
  final _formKey = GlobalKey<FormState>();

  void _pickUserDueDate() {
    showDatePicker(
            context: context,
            initialDate: widget.isEditMode ? _selectedDate : DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((date) {
      if (date == null) {
        return;
      }
      date = date;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  void _pickUserDueTime() {
    var hour;
    var minute;
    if(widget.isEditMode){
      var vv = _selectedTime.split(" ");
      var vv2 = vv[0].split(":");
      hour = int.parse(vv2[0]);
      minute = int.parse(vv2[1]);
    }
    showTimePicker(
      context: context,
      initialTime: widget.isEditMode ?  TimeOfDay(hour: hour, minute: minute)  : TimeOfDay.now(),
    ).then((time) {
      if (time == null) {
        return;
      }
      setState(() {
        _selectedTime = time.format(context);
      });
    });
  }

  void _validateForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var uTask;
      if (_selectedDate == null && _selectedTime != null) {
        _selectedDate = DateTime.now();
      }
      if (!widget.isEditMode) {
        uTask = Task(
          id: DateTime.now().toString(),
          description: _inputDescription,
          dueDate: _selectedDate,
          dueTime: _selectedTime,
        );
      } else {
        uTask = Task(
            id: widget.id,
            description: _inputDescription,
            dueDate: _selectedDate,
            dueTime: _selectedTime,
          );
      }
      Navigator.of(context).pop(uTask);
    }
  }

  @override
  void initState() {
    if (widget.isEditMode) {
      _selectedDate = widget.task.dueDate;
      _selectedTime = widget.task.dueTime;
      _inputDescription = widget.task.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Title', style: Theme.of(context).textTheme.subtitle),
            TextFormField(
              initialValue:
                  _inputDescription == null ? null : _inputDescription,
              decoration: InputDecoration(
                hintText: 'Describe your task',
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (value) {
                _inputDescription = value;
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text('Due date', style: Theme.of(context).textTheme.subtitle),
            TextFormField(
              onTap: () {
                _pickUserDueDate();
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: _selectedDate == null
                    ? 'Provide your due date'
                    : DateFormat.yMMMd().format(_selectedDate).toString(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Due time', style: Theme.of(context).textTheme.subtitle),
            TextFormField(
              onTap: () {
                _pickUserDueTime();
              },
              readOnly: true,
              decoration: InputDecoration(
                hintText: _selectedTime == null
                    ? 'Provide your due time'
                    : _selectedTime,
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                child: Text(
                  !widget.isEditMode ? 'ADD TASK' : 'EDIT TASK',
                  style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _validateForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
