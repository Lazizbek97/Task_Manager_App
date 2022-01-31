// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  final int typeId = 0;

  @override
  TaskModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel()
      ..title = fields[0] as String
      ..dedlineDate = fields[1] as String
      ..dedlineTime = fields[2] as String
      ..place = fields[3] as String
      ..reminer = fields[4] as String
      ..taskType = fields[5] as String
      ..criterias = (fields[6] as List).cast<dynamic>()
      ..color = fields[7] as int;
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.dedlineDate)
      ..writeByte(2)
      ..write(obj.dedlineTime)
      ..writeByte(3)
      ..write(obj.place)
      ..writeByte(4)
      ..write(obj.reminer)
      ..writeByte(5)
      ..write(obj.taskType)
      ..writeByte(6)
      ..write(obj.criterias)
      ..writeByte(7)
      ..write(obj.color);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
