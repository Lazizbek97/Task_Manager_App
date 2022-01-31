import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/add_task_page/adding_task.dart';
import 'package:task_manager/screens/editing_page.dart/edit_page.dart';
import 'package:task_manager/screens/home_page/home_page.dart';

class RouterGenerate {
  static generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case '/add_task':
        return MaterialPageRoute(
          builder: (context) => AddingTaskPage(),
        );

      case '/edit_task':
        return MaterialPageRoute(
          builder: (context) => EditingPage(
            task: args as TaskModel,
          ),
        );
    }
  }
}
