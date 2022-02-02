import 'package:flutter/material.dart';
import 'package:task_manager/core/size_config.dart';
import 'package:task_manager/models/done_tasks.dart';

class TasksDone extends StatefulWidget {
  TasksDone(
      {Key? key,
      required this.tasks,
      required this.index,
      required this.update})
      : super(key: key);
  List<DoneTasks> tasks;
  int index;
  final update;

  @override
  State<TasksDone> createState() => _TasksDoneState();
}

class _TasksDoneState extends State<TasksDone> {
  bool shouldDelete = true;
  List<Color> popUpMenuColors = [
    Colors.greenAccent.shade400,
    Colors.orange.shade600,
    Colors.red,
  ];
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.white,
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: const Alignment(0.7, 0),
        child: const Icon(
          Icons.delete_forever_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        widget.tasks[widget.index].delete();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: getHeight(120),
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
                        child:
                            Text(widget.tasks[widget.index].criterias[index]),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 1),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              widget.tasks[widget.index].title,
              style:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // showSnackBar(context, selected) => ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         action: SnackBarAction(
  //             label: "Undo",
  //             textColor: Colors.white,
  //             onPressed: () {
  //               shouldDelete = true;
  //               setState(() {});
  //             }),
  //         backgroundColor: Colors.grey,
  //         content: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
  //           children: [
  //             const Text("Do you want to delete this task?"),
  //             Container(
  //               height: 30,
  //               width: 2,
  //               color: Colors.white,
  //               margin: const EdgeInsets.symmetric(horizontal: 10),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );

}
