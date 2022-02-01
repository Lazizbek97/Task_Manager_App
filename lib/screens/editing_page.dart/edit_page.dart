import 'package:flutter/material.dart';
import 'package:task_manager/core/notifications/notificartion.dart';
import 'package:task_manager/core/size_config.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:task_manager/models/task_model.dart';
import 'package:task_manager/screens/editing_page.dart/widgets/type_task_buttons.dart';

class EditingPage extends StatefulWidget {
  EditingPage({
    Key? key,
    required this.task,
  }) : super(key: key);
  TaskModel task;
  static int taskType = 0;

  @override
  _EditingPageState createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  final _groupButtonsController = GroupButtonController();

  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  late String _hour, _minute, _time;

  String initTime = DateFormat('kk:mm').format(DateTime.now());
  String initDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  // ?Form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // ? All Input Controllers
  late TextEditingController _taskTitleController;
  late TextEditingController _dateController;
  late TextEditingController _timeController;
  late TextEditingController _placeController;
  late TextEditingController _reminderController;
  @override
  void initState() {
    // ? Initial Value of PopUpMenu
    EditingPage.taskType = widget.task.color;

    // ?Initialize All Controllers Default Values
    _taskTitleController = TextEditingController(text: widget.task.title);
    _dateController = TextEditingController(text: widget.task.dedlineDate);
    _timeController = TextEditingController(text: widget.task.dedlineTime);
    _placeController = TextEditingController(text: widget.task.place);
    _reminderController = TextEditingController(text: widget.task.reminer);
  }

  final List<String> _buttonsList = [
    "School",
    "Work",
    "Home",
    "Sport",
    "LifeStyle",
    "EveryDay",
    "EveryMonth",
    "EveryWeek",
    "Activity",
    "SelfStudy",
  ];
  final List<String> _typeButtons = ["Basic", "Urgent", "Important"];
  void _update() {
    setState(() {});
  }

  List<Color> popUpMenuColors = [
    Colors.greenAccent.shade400,
    Colors.orange.shade600,
    Colors.red,
  ];

  int popUpMenuIndex = EditingPage.taskType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const Text("Editing Task"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _taskTitleController,
                        decoration: InputDecoration(
                          labelText: "My New Task",
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                          suffixIcon: PopupMenuButton(
                              initialValue: popUpMenuIndex,
                              onSelected: (value) {
                                setState(() {
                                  EditingPage.taskType = value as int;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    popUpMenuColors[EditingPage.taskType],
                              ),
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 0,
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      color: popUpMenuColors[0],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      color: popUpMenuColors[1],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 2,
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      color: popUpMenuColors[2],
                                    ),
                                  ),
                                ];
                              }),
                          suffixIconColor: Colors.yellow,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please fill";
                          }
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                labelText: "Dedline date",
                                hintText: "initDate",
                                labelStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _selectDate(context);
                                  },
                                  icon: const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please fill";
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _timeController,
                              decoration: InputDecoration(
                                labelText: "Dedline time",
                                hintText: initTime,
                                labelStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 18),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _selectTime(context, _timeController);
                                  },
                                  icon: const Icon(
                                    Icons.access_time_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Please fill";
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: _placeController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelText: "Place",
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                          suffixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.text_fields_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please fill";
                          }
                        },
                      ),
                      TextFormField(
                        controller: _reminderController,
                        decoration: InputDecoration(
                          labelText: "Remind me",
                          labelStyle:
                              const TextStyle(color: Colors.grey, fontSize: 18),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _selectTime(context, _reminderController);
                            },
                            icon: const Icon(
                              Icons.alarm,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please fill";
                          }
                        },
                      ),
                    ],
                  )),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Task Type",
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: [
                  TypeEditButtons(
                    text: "Basic",
                    isSelected: 0,
                    update: _update,
                  ),
                  TypeEditButtons(
                    text: "Urgent",
                    isSelected: 1,
                    update: _update,
                  ),
                  TypeEditButtons(
                    text: "Important",
                    isSelected: 2,
                    update: _update,
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              ExpansionTile(
                title: const Text("Categories"),
                children: [
                  GroupButton(
                    controller: _groupButtonsController,
                    isRadio: false,
                    borderRadius: BorderRadius.circular(15),
                    unselectedBorderColor: Colors.grey,
                    buttons: _buttonsList,
                    onSelected: (index, isSeleced) {},
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // print(_groupButtonsController.selectedIndexes.toList()[0]);
                  },
                  icon: const Icon(
                    Icons.file_present_outlined,
                    color: Colors.black,
                  ),
                  label: const Text(
                    "Attach File",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.yellow,
                      padding: EdgeInsets.symmetric(
                          horizontal: getWidth(130), vertical: getHeight(15)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: getWidth(370),
        height: getHeight(60),
        margin: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.black87,
          onPressed: () {
            String title = _taskTitleController.text;
            String date = _dateController.text;
            String time = _timeController.text;
            String details = _placeController.text;
            String reminder = _reminderController.text;

            String taskType = _typeButtons[EditingPage.taskType];
            List creteriaNames = [];
            List creteriaIndexs =
                _groupButtonsController.selectedIndexes.toList();
            creteriaIndexs.forEach((element) {
              creteriaNames.add(_buttonsList[element]);
            });

            if (_formKey.currentState!.validate()) {
              creteriaNames.isEmpty ? creteriaNames.add("No Category") : null;
              saveTask(
                title: title,
                dedlineData: date,
                dedlineTime: time,
                place: details,
                reminder: reminder,
                taksType: taskType,
                criterias: creteriaNames,
                color: EditingPage.taskType,
              );

              setNotifications(
                title: title,
                body: details,
                payload: date,
              );
              Navigator.pop(context);
            }
          },
          label: const Text(
            "Save Changes",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  // ? Set notifications
  setNotifications({
    required String title,
    required String body,
    required String payload,
  }) {
    final today = DateTime.now();
    if (selectedDate.month == today.month && selectedDate.day == today.day) {
      DateTime newNotification = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      Notifications.showNotificationScheduledDailyBasis(
        title: title,
        body: body,
        payload: payload,
        scheduledDate: newNotification,
      );
    }
  }

  // ?  Saving edited task to HiveDataBase
  Future saveTask({
    required String title,
    required String dedlineData,
    required String dedlineTime,
    required String place,
    required String reminder,
    required String taksType,
    required List criterias,
    required int color,
  }) {
    TaskModel curTask = widget.task;
    curTask.title = title;
    curTask.dedlineDate = dedlineData;
    curTask.dedlineTime = dedlineTime;
    curTask.place = place;
    curTask.reminer = reminder;
    curTask.taskType = taksType;
    curTask.criterias = criterias;
    curTask.color = color;

    curTask.save();

    return Future.value();
  }

// ? time picker
  Future<void> _selectTime(BuildContext context, controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(
        () {
          selectedTime = picked;
          _hour = selectedTime.hour.toString();
          _minute = selectedTime.minute.toString();
          _time = _hour + ' : ' + '${_minute == "0" ? "00" : _minute}';
          controller.text = _time;
        },
      );
    }
  }

// ? Date time picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat("MM/dd/yyyy").format(selectedDate);
      });
    }
  }
}
