// ignore_for_file: unused_field, non_constant_identifier_names, unused_import

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sstm/utils/theme.dart';
import 'package:get/get.dart';

class ThemeService {
  final box = GetStorage();
  final _key = "isdarkmode";
  savetobox(bool boolvalue) {
    box.write(_key, boolvalue);
  }

  bool trycheck() {
    return box.read(_key) ?? false;
  }

  ThemeMode get theme => trycheck() ? ThemeMode.dark : ThemeMode.light;
  void switchTheme() {
    Get.changeThemeMode(trycheck() ? ThemeMode.light : ThemeMode.dark);
    savetobox(!trycheck());
  }
}
