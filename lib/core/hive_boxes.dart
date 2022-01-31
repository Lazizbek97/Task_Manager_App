import 'package:hive/hive.dart';
import 'package:task_manager/models/done_tasks.dart';
import 'package:task_manager/models/task_model.dart';

class Boxes {
  static Box<TaskModel> getTask() => Hive.box<TaskModel>("all_tasks");
  static Box<DoneTasks> addDones() => Hive.box<DoneTasks>("tasks_done");
}
