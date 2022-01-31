import 'package:flutter/material.dart';
import 'package:task_manager/screens/editing_page.dart/edit_page.dart';

class TypeEditButtons extends StatelessWidget {
  TypeEditButtons(
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
        EditingPage.taskType = isSelected;
        update();
      },
      child: Text(
        text,
        style: TextStyle(
            color: EditingPage.taskType == isSelected
                ? Colors.white
                : Colors.black),
      ),
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        primary: EditingPage.taskType == isSelected
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
