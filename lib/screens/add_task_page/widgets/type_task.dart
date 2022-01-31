import 'package:flutter/material.dart';
import 'package:task_manager/screens/add_task_page/adding_task.dart';
import 'package:task_manager/screens/editing_page.dart/edit_page.dart';

class TypeTaskButton extends StatelessWidget {
  TypeTaskButton(
      {Key? key,
      required this.text,
      required this.isSelected,
      required this.update})
      : super(key: key);
  String text;
  int isSelected;
  final update;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AddingTaskPage.taskType = isSelected;
        EditingPage.taskType = isSelected;
        update();
      },
      child: Text(
        text,
        style: TextStyle(
            color: AddingTaskPage.taskType == isSelected
                ? Colors.white
                : Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        primary: AddingTaskPage.taskType == isSelected
            ? Colors.black
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
