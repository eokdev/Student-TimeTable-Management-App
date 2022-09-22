// ignore_for_file: prefer_collection_literals, unused_local_variable, unnecessary_this, unused_import

import 'package:flutter/material.dart';

class Tasks {
  int? id;
  String? title;
  String? note;
  int? isCompleted;
  String? date;
  String? starTime;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;

  Tasks(
      {this.id,
      this.title,
      this.note,
      this.isCompleted,
      this.date,
      this.starTime,
      this.color,
      this.remind,
      this.repeat,
      this.endTime,
      
      });
  Tasks.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    note = json["note"];
    isCompleted = json["isCompleted"];
    date = json["date"];
    starTime = json["starTime"];
    color = json["color"];
    remind = json["remind"];
    repeat = json["repeat"];
    endTime = json["endTime"];
  
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["id"] = this.id;
    data["title"] = this.title;
    data["note"] = this.note;
    data["isCompleted"] = this.isCompleted;
    data["date"] = this.date;
    data["starTime"] = this.starTime;
    data["color"] = this.color;
    data["remind"] = this.remind;
    data["repeat"] = this.repeat;
    data["endTime"] = this.endTime;
 
    return data;
  }
}
