import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/hive_boxes.dart';
import 'package:task_manager/models/task_model.dart';

import '../home_page.dart';

class PopUpMenuNotificaions extends StatefulWidget {
  PopUpMenuNotificaions({
    Key? key,
  }) : super(key: key);

  @override
  _PopUpMenuNotificaionsState createState() => _PopUpMenuNotificaionsState();
}

class _PopUpMenuNotificaionsState extends State<PopUpMenuNotificaions> {
  List switchItems = [false, false, false];
  List notifications = [];
  String date = DateFormat('MM/dd/yyyy').format(DateTime.now()).toString();
  List<TaskModel> boxList = Boxes.getTask().values.toList();

  @override
  void initState() {
    boxList.forEach(
      (element) {
        if (element.dedlineDate == date) {
          print("object");
          notifications.add(element.title);
        }
      },
    );
    try {
      notifications = notifications.sublist(0, 3);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      child: const Icon(
        Icons.notifications_none_outlined,
        size: 30,
      ),
      onSelected: (value) {
        setState(() {});
      },
      itemBuilder: (context) {
        return List.generate(
          notifications.length,
          (index) => PopupMenuItem(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    notifications[index],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return Switch.adaptive(
                      value: switchItems[index],
                      onChanged: (v) {
                        setState(() => switchItems[index] = v);
                      },
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
