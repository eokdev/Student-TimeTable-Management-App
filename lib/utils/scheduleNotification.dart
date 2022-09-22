// ignore_for_file: file_names, unused_import, depend_on_referenced_packages, prefer_const_constructors, unnecessary_import, unused_local_variable, avoid_print, unused_element
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/standalone.dart' as tz;
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../models/tasks.dart';
import 'notificationservices.dart';

class NotificationSchedule {
  static final notification = FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    configureLocalTIme();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await FlutterLocalNotificationsPlugin().initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
          'your channel id', 'your channel name',
          channelDescription: "our channel description",
          icon: "@mipmap/ic_launcher",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          color: Colors.white,
          sound: RawResourceAndroidNotificationSound("notify")),
      iOS: IOSNotificationDetails(),
    );
  }

  showNotification({
    String? title,
    String? body,
  }) async =>
      notification.show(0, title, body, await notificationDetails(),
          payload: "Custome");
  showSchedule({
    required Tasks tasks,
    required int? hour,
    required int? minutes,
    required String? year,
    required String? month,
    required String? day,
    required List<int> days,
    //  required List<int> dayss,
  }) async {
    notification.zonedSchedule(
        tasks.id!,
        tasks.title,
        tasks.note,
        convertTimendDay(
          hour!,
          minutes!,
          year!,
          month!,
          day!,
          days: days,
        ),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        payload: "CUSTOME");
  }

  showScheduleNotification({
    required Tasks tasks,
    required int? hour,
    required int? minutes,
    required String? year,
    required String? month,
    required String? day,
  }) async {
    notification.zonedSchedule(
        tasks.id!,
        tasks.title,
        tasks.note,
        convertTime(hour!, minutes!, year!, month!, day!),
        await notificationDetails(),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "CUSTOME");
  }

  tz.TZDateTime convertTime(
      int hour, int minutes, String year, String month, String day) {
    configureLocalTIme();

    var detroit = tz.getLocation('Africa/Lagos');
    final tz.TZDateTime now = tz.TZDateTime.now(detroit);
    tz.TZDateTime scheduleTime = tz.TZDateTime(
      detroit,
      int.parse(year),
      int.parse(month),
      now.day,
      hour,
      minutes,
    );
    final String timeZone;
    if (scheduleTime.isBefore(now)) {
      scheduleTime = scheduleTime.add(
        Duration(days: 1),
      );
    }
    print(year);

    print(month);
    //  print(now);
    //   print(scheduleTime);
    return scheduleTime;
  }

  Future<void> configureLocalTIme() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(
      tz.getLocation(timeZone),
    );
    print(timeZone);
  }
// Future<void> setup() async {

//   await tz.initializeTimeZone();
//   var detroit = tz.getLocation('Africa/Lagos');
//   var now = tz.TZDateTime.now(detroit);
//   tz.setLocalLocation(tz.getLocation(now));
// }
  Future onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    Get.dialog(Text("Welcome to flutter"));
    // display a dialog with the notification details, tap ok to go to another page
    // showDialog(
    //   //context: context,
    //   builder: (BuildContext context) => CupertinoAlertDialog(
    //     title: Text(title),
    //     content: Text(body),
    //     actions: [
    //       CupertinoDialogAction(
    //         isDefaultAction: true,
    //         child: Text('Ok'),
    //         onPressed: () async {
    //           Navigator.of(context, rootNavigator: true).pop();
    //           await Navigator.push(
    //             context,
    //             MaterialPageRoute(
    //               builder: (context) => SecondScreen(payload),
    //             ),
    //           );
    //         },
    //       )
    //     ],
    //   ),
    // );
  }

  cancelNotificationId(Tasks tasks) async {
    await FlutterLocalNotificationsPlugin().cancel(tasks.id!.toInt());
  }

  cancelAllNotification(Tasks tasks) async {
    await FlutterLocalNotificationsPlugin().cancelAll();
  }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    Get.to(() => Container(
          color: Colors.white,
        ));
  }

  tz.TZDateTime convertTimendDay(
      int hour, int minutes, String year, String month, String day,
      {required List<int> days}) {
    tz.TZDateTime scheduleDate = convertTime(hour, minutes, year, month, day);

    while (!days.contains(scheduleDate.weekday)) {
      scheduleDate = scheduleDate.add(Duration(days: 1));
    }

    print(scheduleDate);
    return scheduleDate;
  }
}
