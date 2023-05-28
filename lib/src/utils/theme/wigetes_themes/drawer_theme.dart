import 'package:MyMedice/src/constants/colors.dart';
import 'package:flutter/material.dart';

class TDrawerTheme {
  TDrawerTheme._();


  // * light theme
  static final lightDrawerTheme = DrawerThemeData(backgroundColor:tWhiteColor,elevation: 8);

  static final darkDrawerTheme = DrawerThemeData(backgroundColor: tDarkColor,elevation: 8);
}
