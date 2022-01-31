import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String dedlineDate;
  @HiveField(2)
  late String dedlineTime;
  @HiveField(3)
  late String place;
  @HiveField(4)
  late String reminer;
  @HiveField(5)
  late String taskType;
  @HiveField(6)
  late List criterias;
  @HiveField(7)
  late int color;
}
