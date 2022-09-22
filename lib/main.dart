// ignore_for_file: prefer_const_constructors, unused_import, unused_local_variable, await_only_futures, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sstm/utils/notificationservices.dart';
import 'package:sstm/utils/theme.dart';
import 'package:sstm/utils/themeservice.dart';
import 'HomePage.dart';
import 'database/dbHelper.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'utils/themeservice.dart';

Future<void> main() async {
  tz.initializeTimeZones();
  WidgetsFlutterBinding.ensureInitialized();

  await DbHelper.initDb();
  await GetStorage.init;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool toggle = false;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeChange.lightTheme,
      darkTheme: ThemeChange.darkTheme,
      themeMode: ThemeService().theme,
      home: HomePage(),
    );
  }
}
