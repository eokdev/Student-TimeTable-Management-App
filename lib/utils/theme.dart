// ignore_for_file: prefer_const_constructors, unnecessary_import, unused_import

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blueclr = Color(0xff4e5ae8);
const Color yellowclr = Color(0xffff8746);
const Color pinkclr = Color(0xffff4667);
const Color white = Colors.white;
const Color darkgreyclr = Color(0xff121212);
const Color darkgreyheadclr = Color(0xff424242);

class ThemeChange {
  static final lightTheme = ThemeData(
    backgroundColor: white,
    primaryColor: white,
    brightness: Brightness.light,
  );
  static final darkTheme = ThemeData(
    backgroundColor: darkgreyclr,
    primaryColor: darkgreyheadclr,
    brightness: Brightness.dark,
  );
}

TextStyle get subheadstyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w800));
}
TextStyle get subtitletyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800));
}
TextStyle get hinttext {
  return GoogleFonts.lato(
      textStyle: TextStyle(fontSize: 12, color: Colors.grey));
}