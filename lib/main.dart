import 'package:flutter/material.dart';
import 'package:task_manager/models/done_tasks.dart';
import 'package:task_manager/routes.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  Hive.registerAdapter(TaskModelAdapter());
  await Hive.openBox<TaskModel>("all_tasks");

  Hive.registerAdapter(DoneTasksAdapter());
  await Hive.openBox<DoneTasks>("tasks_done");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

@override
void initState() {}

@override
void dispose() {
  Hive.close();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) => RouterGenerate.generateRoute(settings),
    );
  }
}
