import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class Notifications {
  static final _notification = FlutterLocalNotificationsPlugin();
  // ! Notifications on pressed
  static final onNotifications = BehaviorSubject<String?>();

// ! Initializing new Notification here
  static Future init({bool initScheduled = false}) async {
    // ? For Android
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    // ? For IOS
    IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings();
    // ? Initializing Settings for Platforms
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    FlutterLocalNotificationsPlugin().initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );

// ! App ishga tushganda vaqtni u turgan time zone locationga qarab oladi
    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
  }

// ! Which platform, How get notifications? settings
  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channelId",
        "channelName",
        channelDescription: "channel description",
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

// ! What user see on Notification are all here
// ? Notification When user pressed a button
  static showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notification.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

// ? Notification when user set a time in the future

  static showNotificationScheduled({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notification.zonedSchedule(
        // * Argumentlarinig positsiyasi MUHIM!
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.getLocation('America/Detroit')),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

// ? Notifacations Daily Basis

  static showNotificationScheduledDailyBasis({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notification.zonedSchedule(
        // * Argumentlarinig positsiyasi MUHIM!
        id,
        title,
        body,
        // * dailyNotifications
        await _scheduleDaily(
          Time(scheduledDate.hour, scheduledDate.minute),
        ),
        // ),
        // * weeklyNOtifications
        // await _weeklySchedule(Time(11),
        // days: [DateTime.monday, DateTime.tuesday]),

        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // * DailySchedule
        // matchDateTimeComponents: DateTimeComponents.time,
        // * WeeklySchedule
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );

  // ?-----------------------------------------
  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day,
        time.hour, time.minute, time.second);
    return scheduledDate.isBefore(now)
        ? scheduledDate.add(
            Duration(seconds: 15),
          )
        : scheduledDate;
  }

  static tz.TZDateTime _weeklySchedule(Time time, {required List<int> days}) {
    tz.TZDateTime scheduledDate = _scheduleDaily(time);

    while (!days.contains(scheduledDate.weekday)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
