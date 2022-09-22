// ignore_for_file: prefer_const_constructors, file_names, unused_local_variable, unused_import, annotate_overrides, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_field, prefer_final_fields, avoid_print, prefer_typing_uninitialized_variables, unnecessary_import, sized_box_for_whitespace, prefer_is_empty, unrelated_type_equality_checks, unnecessary_string_interpolations, deprecated_member_use, unused_element
// import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sstm/controllers/taskController.dart';
import 'package:sstm/main.dart';
import 'package:sstm/taskselect.dart';
import 'package:sstm/utils/notificationservices.dart';
import 'package:sstm/utils/theme.dart';
import 'package:sstm/utils/themeservice.dart';
import 'package:intl/intl.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'models/tasks.dart';
import 'taskselect.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'utils/scheduleNotification.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _taskController = Get.put(TaskController());

  // bool toggle = false;
  var notifyHelper;
  DateTime _selectedvalue = DateTime.now();
  @override
  void initState() {
    super.initState();
    _taskController.getData();
    NotificationSchedule().initializeNotification();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: blueclr,
          child: Icon(Icons.delete, color: white),
          onPressed: () {
            Get.defaultDialog(
              backgroundColor: Get.isDarkMode ? Colors.grey : white,
              title: "Are you sure you want to delete all tasks?",
              titleStyle: GoogleFonts.lato(
                  color: Colors.black, fontWeight: FontWeight.bold),
              radius: 20,
              middleText: "Note: All Tasks will be delected after App restarts",
              middleTextStyle:
                  GoogleFonts.lato(color: Colors.black, fontSize: 18),
              confirm: FlatButton(
                  onPressed: () {
                    NotificationSchedule().cancelAllNotification(Tasks());
                    //  _taskController.tasklist.clear();
                    Navigator.pop(context);
                    _taskController.deleteDb();
                  },
                  child: Text(
                    "Delete",
                    style: GoogleFonts.lato(color: Colors.red, fontSize: 18),
                  )),
              cancel: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: GoogleFonts.lato(color: Colors.blue, fontSize: 18),
                  )),
            );
          }),
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
        backgroundColor: context.theme.backgroundColor,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: blueclr,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: white,
                child: Image(
                  image: ExactAssetImage("images/appicons.png"),
                  height: 30,
                ),
              ),
            ),
          )
        ],
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            setState(
              () {
                ThemeService().switchTheme();
              },
            );

            // Get.snackbar(
            //   "App Theme Changed",
            //   Get.isDarkMode ? "Light Mode Activated" : "Dark Mode Activated",
            //   snackPosition: SnackPosition.BOTTOM,
            //   backgroundColor: darkgreyheadclr,
            //   colorText: Colors.grey,
            //   icon: RotatedBox(
            //     quarterTurns: Get.isDarkMode ? 6 : 4,
            //     child: Icon(
            //       Icons.mode_night_outlined,
            //       color: Colors.grey,
            //     ),
            //   ),
            // );
            // setState(() {
            //   ThemeService().switchTheme();
            //   NotifyHelper().displayNotification(
            //       title: "Theme Changed",
            //       body: Get.isDarkMode
            //           ? "Activated light theme"
            //           : "Activated dark theme");
            // });
          },
          icon: RotatedBox(
            quarterTurns: Get.isDarkMode ? 6 : 4,
            child: Icon(
              Get.isDarkMode
                  ? Icons.nightlight_round_outlined
                  : Icons.nightlight_round_outlined,
              size: 27,
              color: Get.isDarkMode ? Colors.grey : Colors.black,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMMd().format(
                          DateTime.now(),
                        ),
                        style: subheadstyle.copyWith(
                            color: Get.isDarkMode
                                ? Colors.grey[400]
                                : Colors.black),
                      ),
                      Text(
                        "Today",
                        style: subheadstyle,
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => TaskScreen(),
                      ),
                    );
                  },
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: blueclr,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "+ Add Task",
                        style: GoogleFonts.lato(
                            fontSize: 12,
                            color:
                                Get.isDarkMode ? Colors.white : Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            DatePicker(
              DateTime.now(),
              height: 80,
              width: 60,
              selectionColor: blueclr,
              dateTextStyle: GoogleFonts.lato(color: Colors.grey),
              dayTextStyle: GoogleFonts.lato(color: Colors.grey),
              monthTextStyle: GoogleFonts.lato(color: Colors.grey),
              onDateChange: (date) {
                setState(() {
                  _selectedvalue = date;
                });
              },
            ),
            SizedBox(
              height: 10,
            ),
            showTask(context)
          ],
        ),
      ),
    );
  }

  showTask(BuildContext okay) {
    return Expanded(
      child: Obx(
        () {
          return AnimationLimiter(
            child: ListView.builder(
              itemCount: _taskController.tasklist.length,
              itemBuilder: (context, index) {
                Tasks tasks = _taskController.tasklist[index];
                DateTime date =
                    DateFormat.jm().parse(tasks.starTime.toString());

                var time = DateFormat("HH:mm").format(date);
                var month = tasks.date!.split("/")[0];
                var day = tasks.date!.split("/")[1];
                int hh = int.parse(time.split(":")[0]);
                int mm = int.parse(time.split(":")[1]);
                String spliteDate = tasks.date.toString();

                NotificationSchedule().showSchedule(
                    tasks: tasks,
                    hour: int.parse(time.split(":")[0]),
                    minutes: int.parse(time.split(":")[1]),
                    day: spliteDate.split("/")[1],
                    month: spliteDate.split("/")[0],
                    year: spliteDate.split("/")[2],
                    days: [
                      tasks.remind == 1
                          ? DateTime.monday
                          : tasks.remind == 2
                              ? DateTime.tuesday
                              : tasks.remind == 3
                                  ? DateTime.wednesday
                                  : tasks.remind == 4
                                      ? DateTime.thursday
                                      : tasks.remind == 5
                                          ? DateTime.friday
                                          : tasks.remind == 6
                                              ? DateTime.saturday
                                              : DateTime.sunday
                    ]);

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: ScaleAnimation(
                      curve: Curves.decelerate,
                      child: InkWell(
                        onLongPress: () {
                          NotificationSchedule().cancelNotificationId(tasks);
                        },
                        onTap: () {
                          Get.bottomSheet(
                            enableDrag: true,
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              padding: EdgeInsets.only(
                                top: 45,
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  color: context.theme.backgroundColor),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: _taskController
                                                .tasklist[index].isCompleted ==
                                            1
                                        ? Container()
                                        : resuableContainer(
                                            label: "Task Completed",
                                            color: blueclr,
                                            iscolor: true,
                                            function: () {
                                              _taskController.updates(
                                                  _taskController
                                                      .tasklist[index].id!);
                                              Get.back();
                                            }),
                                  ),
                                  SizedBox(
                                    height: 6,
                                  ),
                                  Expanded(
                                    child: resuableContainer(
                                        function: () {
                                          _taskController.delete(
                                              _taskController.tasklist[index]);
                                           NotificationSchedule()
                                              .cancelNotificationId(tasks);
                                          _taskController.getData();
                                          Get.back();
                                        },
                                        label: "Delete Task",
                                        color: Colors.red,
                                        iscolor: true),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: resuableContainer(
                                        label: "Close",
                                        iscolor: false,
                                        function: () {
                                          Get.back();
                                        }),
                                  ))
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          height: 120,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _taskController.tasklist[index].color == 0
                                ? blueclr
                                : _taskController.tasklist[index].color == 1
                                    ? pinkclr
                                    : yellowclr,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _taskController.tasklist[index].title
                                            .toString(),
                                        style: GoogleFonts.lato(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_rounded,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "${_taskController.tasklist[index].starTime.toString()}  -->",
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.white),
                                          ),
                                          SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            "${_taskController.tasklist[index].endTime.toString()}",
                                            style: GoogleFonts.lato(
                                                fontSize: 14,
                                                color: Colors.white),
                                          )
                                        ],
                                      ),
                                      Text(
                                        _taskController.tasklist[index].note
                                            .toString(),
                                        style: GoogleFonts.lato(
                                            fontSize: 14, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 60,
                                width: 0.6,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              RotatedBox(
                                quarterTurns: 3,
                                child: Text(
                                  _taskController.tasklist[index].isCompleted ==
                                          1
                                      ? "COMPLETED"
                                      : "TODO",
                                  style: subtitletyle.copyWith(
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget resuableContainer(
      {String? label, bool? iscolor, Color? color, Function()? function}) {
    return InkWell(
      onTap: function,
      child: Container(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            border: iscolor == true
                ? Border.all(
                    color: context.theme.backgroundColor,
                  )
                : Border.all(
                    color: Get.isDarkMode ? white : Colors.black, width: 1)),
        child: Center(
          child: Text(
            label!,
            style: GoogleFonts.lato(
                fontSize: 15,
                color: iscolor == false && Get.isDarkMode
                    ? white
                    : !Get.isDarkMode && iscolor == false
                        ? Colors.black
                        : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void callback() {
    print("hello");
  }
}
