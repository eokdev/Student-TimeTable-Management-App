// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, prefer_typing_uninitialized_variables, avoid_print, no_leading_underscores_for_local_identifiers, unused_import, unnecessary_import, unused_element, unnecessary_string_interpolations

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sstm/HomePage.dart';
import 'package:sstm/controllers/taskController.dart';
import 'package:sstm/models/tasks.dart';
import 'package:sstm/utils/inputField.dart';
import 'package:sstm/utils/theme.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

DateTime date = DateTime.now();
String starTime = DateFormat("HH:mm a").format(DateTime.now()).toString();
String first = starTime.split(":")[0];
var duration = Duration();
String endtime = "9:00 PM";
int reminder = 5;
List<int> reminderitems = [5, 10, 15, 20];
String repeat = "None";
List<String> repeatitems = [
  "None",
  "Daily",
  "Weekly",
  "Monthly",
];
int day = 1;
List<int> days = [
  DateTime.monday,
  DateTime.tuesday,
  DateTime.wednesday,
  DateTime.thursday,
  DateTime.friday,
  DateTime.saturday,
  DateTime.sunday,
];
int selected = 0;
TextEditingController titleController = TextEditingController();
TextEditingController noteController = TextEditingController();
TaskController _taskController = Get.put(TaskController());

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    _taskController.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: AppBar(
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
        leading: IconButton(
          onPressed: () {
            print(first);
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Get.isDarkMode ? Colors.grey : Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: context.theme.backgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Add Task",
                style: subheadstyle,
              ),
              SizedBox(
                height: 15,
              ),
              InputField(
                title: "Title",
                hint: "Enter your title",
                textEditingController: titleController,
              ),
              InputField(
                title: "Note",
                hint: "Enter note here",
                textEditingController: noteController,
              ),
              InputField(
                  title: "Date",
                  hint: DateFormat.yMd().format(date),
                  widget: IconButton(
                      onPressed: () {
                        getdatefrompicker(context);
                      },
                      icon: Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                      ))),
              Row(
                children: <Widget>[
                  Expanded(
                    child: InputField(
                      title: "Start Time",
                      hint: starTime,
                      widget: IconButton(
                        onPressed: () {
                          gettimepicker(context, true);
                        },
                        icon: Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: InputField(
                        title: "End Time",
                        hint: endtime,
                        widget: IconButton(
                            onPressed: () {
                              gettimepicker(context, false);
                            },
                            icon: Icon(
                              Icons.access_time_rounded,
                              color: Colors.grey,
                            ))),
                  ),
                ],
              ),
              InputField(
                title: "Days",
                // ignore: unrelated_type_equality_checks
                hint:
                    // ignore: unrelated_type_equality_checks
                    "${day == 1 ? "Monday" : day == 2 ? "Tuesday" : day == 3 ? "Wednesday" : day == 4 ? "Thursday" : day == 5 ? "Friday" : day == 6 ? "Saturday" : day == 7 ? "Sunday" : "Select A Day"}",
                widget: DropdownButton(
                    onChanged: (String? newValue) {
                      setState(() {
                        day = int.parse(newValue!);
                      });
                    },
                    underline: Container(
                      height: 0,
                    ),
                    elevation: 4,
                    iconSize: 32,
                    dropdownColor: Colors.grey,
                    items: days.map<DropdownMenuItem<String>>((int value) {
                      return DropdownMenuItem<String>(
                          value: value.toString(),
                          child: Text(value.toString()));
                    }).toList()),
              ),
              InputField(
                title: "Repeat",
                hint: repeat,
                widget: DropdownButton(
                    underline: Container(
                      height: 0,
                    ),
                    elevation: 4,
                    iconSize: 32,
                    dropdownColor: Colors.grey,
                    items: repeatitems
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (change) {
                      setState(() {
                        repeat = change.toString();
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Color",
                        style: subtitletyle,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        spacing: 4,
                        children: List.generate(
                          3,
                          (index) => InkWell(
                            onTap: () {
                              setState(() {
                                selected = index;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: index == 0
                                  ? blueclr
                                  : index == 1
                                      ? pinkclr
                                      : yellowclr,
                              radius: 14,
                              child: selected == index
                                  ? Icon(Icons.done,
                                      color: Colors.white, size: 16)
                                  : Container(),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      if (titleController.text.isNotEmpty &&
                          noteController.text.isNotEmpty) {
                        addTasktodatabase();
                        _taskController.getData();
                        Get.back();
                      } else {
                        validator();
                      }
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
                          "Create Task",
                          style: GoogleFonts.lato(
                              fontSize: 12,
                              color:
                                  Get.isDarkMode ? Colors.white : Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  addTasktodatabase() async {
    TaskController taskcontroller = Get.put(TaskController());
    var value = await taskcontroller.addTask(Tasks(
      color: selected,
      isCompleted: 0,
      note: noteController.text,
      repeat: repeat,
      remind: day,
      title: titleController.text,
      starTime: starTime,
      endTime: endtime,
      date: DateFormat.yMd().format(date),
    ));
    print("my value is id $value");
  }

  validator() {
    if (titleController.text.isEmpty && noteController.text.isEmpty) {
      Get.snackbar(
          "Warning", "Title and Note field is empty, Pls input a text!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: darkgreyheadclr,
          colorText: Colors.red,
          icon: Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
    } else if (titleController.text.isEmpty && noteController.text.isNotEmpty) {
      Get.snackbar("Warning", "Title field is empty!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: darkgreyheadclr,
          colorText: Colors.red,
          icon: Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
    } else if (titleController.text.isNotEmpty & noteController.text.isEmpty) {
      Get.snackbar("Warning", "Note field is empty!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: darkgreyheadclr,
          colorText: Colors.red,
          icon: Icon(
            Icons.warning_amber,
            color: Colors.red,
          ));
    }
  }

  getdatefrompicker(BuildContext context) async {
    DateTime? picker = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015),
        lastDate: DateTime(2121));
    if (picker != null) {
      setState(() {
        date = picker;
      });
    }
  }

  gettimepicker(BuildContext context, bool isStartime) async {
    TimeOfDay? timepicker = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(DateTime.now().hour.toString()),
        minute: int.parse(DateTime.now().minute.toString()),
      ),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
    if (timepicker == null) {
      print("error");
    } else if (isStartime == true) {
      setState(() {
        var _pickedTime = timepicker.format(context);
        starTime = _pickedTime;
      });
    } else if (isStartime == false) {
      setState(() {
        var _pickedTime = timepicker.format(context);
        endtime = _pickedTime;
      });
    }
  }
}
