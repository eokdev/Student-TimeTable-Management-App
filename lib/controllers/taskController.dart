// ignore_for_file: file_names, unnecessary_overrides, unused_import, unused_local_variable, avoid_print, avoid_renaming_method_parameters, annotate_overrides
import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:sstm/database/dbHelper.dart';
import 'package:sstm/models/tasks.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  var tasklist = <Tasks>[].obs;

  Future<int> addTask(Tasks task) async {
    return await DbHelper.insert(task);
  
  }

  void getData() async {
    print("getData method is called");
   
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    tasklist.assignAll(
      tasks
          .map(
            (data) => Tasks.fromJson(data),
          )
          .toList(),
    );
    print(tasks);
  }


  void delete(Tasks tasks) {
    DbHelper.delete(tasks);
  
  }

 void updates(int id){
 DbHelper.update(id);
 getData();
 
  }

void deleteDb(){
  DbHelper.deleteDb();
}
}
