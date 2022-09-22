// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unused_import, unnecessary_import, avoid_print, depend_on_referenced_packages, unused_local_variable, await_only_futures

import 'dart:math';

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

class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    setup();
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initializationSettingsIOS,
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  } // void reqeuestAndroidPermission(){
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.re;
  // }

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

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }
  // void reqeuestAndroidPermission(){
  //   flutterLocalNotificationsPlugin
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.re;
  // }

  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        channelDescription: "our channel description",
        icon: "@mipmap/ic_launcher",
        importance: Importance.max,
        priority: Priority.high);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics
        );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'custom_sound',
    );
  }

  scheduledNotification(int hour, int munites, Tasks tasks) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      tasks.id!,
      tasks.title,
      tasks.note,
      tz.TZDateTime.now(tz.local).add(Duration(seconds: 5)),
      NotificationDetails(
          android: AndroidNotificationDetails(
              'your channel id', 'your channel name',
              channelDescription: 'your channel description')),
      androidAllowWhileIdle: true,
      payload: "${tasks.title} | ${tasks.note}",
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  tz.TZDateTime convertTime(int hour, int munites) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      munites,
    );
    if (scheduleTime.isBefore(now)) {
      scheduleTime = scheduleTime.add(
        Duration(days: 1),
      );
    }
    print(scheduleTime);
    return scheduleTime;
  }

  Future<void> setup() async {
  tz.initializeTimeZones();
    final String locate = await FlutterNativeTimezone.getLocalTimezone();
     tz.setLocalLocation(tz.getLocation(locate));
  }
}


//  NotificationSchedule().showScheduleNotification(
//                     schedule: DateTime.now().add(Duration(hours: int.parse(time.toString().split(":"[0])), seconds: 1)),
//                     body: "ojay",
//                     title: "hede",
//                     id: 0);