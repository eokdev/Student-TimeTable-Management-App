// ignore_for_file: file_names, unused_import, prefer_const_declarations, prefer_interpolation_to_compose_strings, unused_local_variable, empty_catches, avoid_print, unused_label, depend_on_referenced_packages, prefer_typing_uninitialized_variables
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:args/args.dart';
import 'package:path/path.dart';
import '../models/tasks.dart';

class DbHelper {
  static Database? db;
  static final int version = 1;
  static final String tableName = "tasks";
  static var path;
  static Future<void> initDb() async {
    if (db != null) {
      return;
    }
    try {
      path = await getDatabasesPath() + "demo.db";

      db = await openDatabase(path, version: version,
          onCreate: (db, version) async {
        print("creating new one");
        await db.execute('''
            CREATE TABLE $tableName(
              id INTEGER PRIMARY KEY AUTOINCREMENT, 
              title STRING, note TEXT, 
              isCompleted INTEGER, 
              date STRING, 
              starTime STRING, 
              endTime STRING, 
              color INTEGER, 
              remind INTEGER, 
              repeat STRING )''');
      });
    } on DatabaseException catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Tasks? task) async {
    print("insert method called");
    return await db?.insert(tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print("query method is called");
    return await db!.query(tableName);
  }

  static delete(Tasks tasks) async {
    await db!.delete(tableName, where: "id=?", whereArgs: [tasks.id]);
  }

  static update(int id) {
    db!.rawUpdate('''
UPDATE $tableName
SET isCompleted=?
WHERE id=?
''', [1, id]);
  }

  static deleteDb() async {
   await deleteDatabase(path);
  }
}























  // static Future<void> initdb() async {
  //   if (db != null) {
  //     return;
  //   }
  //   try {
  //     var path = await getDatabasesPath() + "Tasks.db";
  //     db = await openDatabase(path, version: version,
  //         onCreate: (db, int version) async {
  //       print("creating new one");
  //       await db.execute(
  //           'CREATE TABLE $tableName (id INTEGER PRIMARY KEY, title STRING, isCompleted INTEGER, note TEXT,endTime STRING, starTime STRING,color INTEGER, repeat STRING,date STRING, remind STRING )');
  //     });
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // static Future<int> insert(Tasks task) async {
  //   print("insert function called");
  //   return await db?.insert(tableName, task.toJson())??1;
  // }