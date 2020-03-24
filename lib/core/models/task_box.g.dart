// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskBoxAdapter extends TypeAdapter<TaskBox> {
  @override
  final typeId = 0;

  @override
  TaskBox read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskBox(
      id: fields[0] as String,
      description: fields[1] as String,
      dueDate: fields[2] as String,
      dueTime: fields[3] as String,
      isDone: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TaskBox obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.dueDate)
      ..writeByte(3)
      ..write(obj.dueTime)
      ..writeByte(4)
      ..write(obj.isDone);
  }
}
