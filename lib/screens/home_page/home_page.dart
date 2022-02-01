import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/core/hive_boxes.dart';
import 'package:task_manager/core/notifications/notificartion.dart';
import 'package:task_manager/core/size_config.dart';
import 'package:task_manager/models/done_tasks.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/drawer_page/home_drawer.dart';
import 'package:task_manager/screens/home_page/top_part.dart';
import 'package:task_manager/screens/home_page/widgets/fade_color.dart';
import 'package:task_manager/screens/home_page/widgets/my_task.dart';
import 'package:task_manager/screens/home_page/widgets/tasks_done.dart';
import 'package:task_manager/screens/home_page/widgets/upcoming.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static int tabBarIndex = 0;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void _update() {
    setState(() {});
  }

  @override
  void initState() {
    Notifications.init(initScheduled: true);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerHome(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: TopPart(
                sKey: _scaffoldKey,
                update: _update,
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: getWidth(20), vertical: 10),
                child: CustomPaint(
                  foregroundPainter: FadingEffect(),
                  child: ValueListenableBuilder<Box>(
                    valueListenable: Boxes.getTask().listenable(),
                    builder: (context, box, _) {
                      String date = DateFormat('MM/dd/yyyy')
                          .format(DateTime.now())
                          .toString();

                      // ! to show Datas
                      List<TaskModel> tasks = [];
                      // ! takes only todays tasks
                      List<TaskModel> todays_tasks = [];
                      // ! takes all other taskes
                      List<TaskModel> upcoming_tasks = [];

                      // ! Extract tosays tasks from DataBase
                      final tasksBox = box.values.toList().cast<TaskModel>();

                      // PopUpMenuNotificaions.tasksBoxList = tasksBox;

                      tasksBox.forEach((element) {
                        element.dedlineDate == date
                            ? todays_tasks.add(element)
                            : null;
                      });
                      // ! Extracts all other tasks from DataBase
                      tasksBox.forEach((element) {
                        element.dedlineDate != date
                            ? upcoming_tasks.add(element)
                            : null;
                      });

                      // ! Sorting dates from first coming to last

                      upcoming_tasks.sort((a, b) => DateFormat("MM/dd/yyyy")
                          .parse(a.dedlineDate)
                          .compareTo(
                              DateFormat("MM/dd/yyyy").parse(b.dedlineDate)));

                      if (HomePage.tabBarIndex == 0) {
                        tasks = todays_tasks;
                      } else if (HomePage.tabBarIndex == 1) {
                        tasks = upcoming_tasks;
                      }

                      // ! Opening Done Taskes Box
                      List<DoneTasks> doneList =
                          Boxes.addDones().values.toList().cast<DoneTasks>();
                      // print(doneList);
                      // -----------------------//
                      return (HomePage.tabBarIndex == 2
                              ? Boxes.addDones().isEmpty
                              : Boxes.getTask().isEmpty)
                          ? const Center(
                              child: Text("No Tasks Found"),
                            )
                          : ListView.builder(
                              itemCount: HomePage.tabBarIndex == 2
                                  ? doneList.length
                                  : tasks.length,
                              itemBuilder: (context, index) {
                                List _pages = [
                                  MyTask(tasks: tasks, index: index),
                                  UpcomingEvents(tasks: tasks, index: index),
                                  TasksDone(
                                    tasks: doneList,
                                    index: index,
                                    update: _update,
                                  ),
                                ];

                                return _pages[HomePage.tabBarIndex];
                              },
                            );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, "/add_task");
        },
        elevation: 0,
        icon: const Icon(
          Icons.add_box_rounded,
          color: Colors.white,
        ),
        label: const Text(
          "Add Task",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
