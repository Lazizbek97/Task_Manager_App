import 'package:flutter/material.dart';
import 'package:task_manager/core/size_config.dart';
import 'package:task_manager/screens/home_page/home_page.dart';
import 'package:task_manager/screens/home_page/widgets/pop_up_menu.dart';
import 'package:task_manager/screens/search_page/search_page.dart';

class TopPart extends StatefulWidget {
  TopPart({Key? key, required this.update, required this.sKey})
      : super(key: key);

  final update;
  GlobalKey<ScaffoldState> sKey;

  @override
  State<TopPart> createState() => _TopPartState();
}

class _TopPartState extends State<TopPart> with TickerProviderStateMixin {
  late final TabController _tabController;
  int initValue = 0;
  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: getWidth(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    widget.sKey.currentState!.openDrawer();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.menu_sharp,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Text(
                  "Task Manager",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                PopUpMenuNotificaions(),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: getWidth(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome Back!",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Here's Update Today.",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    showSearch(context: context, delegate: SearchPage());
                  },
                  child: const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.search),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            indicatorColor: Colors.transparent,
            onTap: (value) {
              initValue = value;
              HomePage.tabBarIndex = value;
              widget.update();
              setState(() {});
            },
            tabs: [
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(30),
                    vertical: getHeight(10),
                  ),
                  child: Text(
                    "Today",
                    style: TextStyle(
                        color: initValue == 0 ? Colors.white : Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: initValue == 0 ? Colors.black87 : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(16), vertical: getHeight(10)),
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                        color: initValue == 1 ? Colors.white : Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: initValue == 1 ? Colors.black87 : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getWidth(16), vertical: getHeight(10)),
                  child: Text(
                    "Task Done",
                    style: TextStyle(
                        color: initValue == 2 ? Colors.white : Colors.black),
                  ),
                  decoration: BoxDecoration(
                    color: initValue == 2 ? Colors.black87 : Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
