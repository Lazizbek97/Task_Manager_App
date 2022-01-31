import 'package:flutter/material.dart';
import 'package:task_manager/models/task_model.dart';

class DrawerHome extends StatefulWidget {
  DrawerHome({
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerHome> createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  int _tileIconIndex = 0;
  final List<Icon> _tileIcons = const [
    Icon(
      Icons.keyboard_arrow_down_rounded,
      color: Colors.white,
    ),
    Icon(
      Icons.keyboard_arrow_up,
      color: Colors.white,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1.2)),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(3, 50, 3, 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 7),
              trailing: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.black,
                child: _tileIcons[_tileIconIndex],
              ),
              onExpansionChanged: (value) {
                value ? _tileIconIndex = 1 : _tileIconIndex = 0;
                setState(() {});
              },
              leading: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage("https://source.unsplash.com/random"),
                  ),
                ),
              ),
              title: const Text("Lazizbek Fayziev"),
              subtitle: const Text("laziz.fayziev@mail.ru"),
              children: [
                TextFormField(
                  initialValue: "Lazizbek Fayziev",
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 0)),
                ),
                TextFormField(
                  initialValue: "laziz.fayziev@mail.ru",
                ),
              ],
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              expandedAlignment: Alignment.centerLeft,
              childrenPadding: const EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
          const Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ),
              title: Text("My Daily"),
            ),
          ),
          const Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.white,
                ),
              ),
              title: Text("Calendar & Planned"),
            ),
          ),
          const Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.people,
                  color: Colors.white,
                ),
              ),
              title: Text("Connect with Me"),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: Text(
              "My List Task",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                  color: Colors.white),
            ),
          ),
          const Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.list_alt_outlined,
                  color: Colors.white,
                ),
              ),
              title: Text("Money Saver"),
            ),
          ),
          const Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.attach_money,
                  color: Colors.white,
                ),
              ),
              title: Text("Monthly Expenditure"),
            ),
          ),
        ],
      ),
    );
  }
}
