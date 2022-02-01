import 'package:flutter/material.dart';
import 'package:roundcheckbox/roundcheckbox.dart';
import 'package:task_manager/core/hive_boxes.dart';
import 'package:task_manager/core/notifications/notificartion.dart';
import 'package:task_manager/core/size_config.dart';
import 'package:task_manager/models/done_tasks.dart';
import 'package:task_manager/models/task_model.dart';

class UpcomingEvents extends StatefulWidget {
  UpcomingEvents({Key? key, required this.tasks, required this.index})
      : super(key: key);
  List<TaskModel> tasks;
  int index;

  @override
  State<UpcomingEvents> createState() => _UpcomingEventsState();
}

class _UpcomingEventsState extends State<UpcomingEvents> {
  bool shouldDelete = true;
  List<Color> popUpMenuColors = [
    Colors.greenAccent.shade400,
    Colors.orange.shade600,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: getHeight(180),
      width: getWidth(600),
      decoration: BoxDecoration(
        color: popUpMenuColors[widget.tasks[widget.index].color],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: getHeight(30),
                width: getWidth(270),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.tasks[widget.index].criterias.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: Text(widget.tasks[widget.index].criterias[index]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                    );
                  },
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/edit_task",
                      arguments: widget.tasks[widget.index]);
                },
                icon: const Icon(Icons.mode_edit_outline_outlined),
              ),
            ],
          ),
          Text(
            widget.tasks[widget.index].title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        widget.tasks[widget.index].dedlineDate,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: getHeight(10),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time_outlined,
                        size: 16,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${widget.tasks[widget.index].dedlineTime} (Remind at ${widget.tasks[widget.index].reminer})",
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
              RoundCheckBox(
                size: 50,
                uncheckedColor: Colors.white,
                animationDuration: const Duration(milliseconds: 1000),
                onTap: (selected) {
                  shouldDelete = false;

                  showSnackBar(context, selected);
                  Future.delayed(const Duration(seconds: 2)).then((value) {
                    if (!shouldDelete) {
                      TaskModel task = widget.tasks[widget.index];
                      final box = Boxes.addDones();
                      final new_done_task = DoneTasks()
                        ..title = task.title
                        ..dedlineDate = task.dedlineDate
                        ..dedlineTime = task.dedlineTime
                        ..place = task.place
                        ..reminer = task.reminer
                        ..taskType = task.taskType
                        ..criterias = task.criterias
                        ..color = task.color;
                      if (selected!) {
                        box.containsKey(new_done_task.key)
                            ? new_done_task.save()
                            : box.add(new_done_task);
                        Notifications.cancelNotification(task.key);

                        task.delete();
                      }
                    }
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  showSnackBar(context, selected) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          onVisible: () {},
          action: SnackBarAction(
              label: "Undo",
              textColor: Colors.white,
              onPressed: () {
                shouldDelete = true;
                setState(() {});
              }),
          backgroundColor: Colors.grey,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Do you want to delete this task?"),
              Container(
                height: 30,
                width: 2,
                color: Colors.white,
                margin: const EdgeInsets.symmetric(horizontal: 10),
              ),
            ],
          ),
        ),
      );
}
