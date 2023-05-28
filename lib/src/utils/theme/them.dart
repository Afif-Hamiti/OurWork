import 'package:MyMedice/src/utils/theme/wigetes_themes/drawer_theme.dart';
import 'package:MyMedice/src/utils/theme/wigetes_themes/elevated_button_theme.dart';
import 'package:MyMedice/src/utils/theme/wigetes_themes/outlined_button_theme.dart';
import 'package:MyMedice/src/utils/theme/wigetes_themes/text_field_theme.dart';
import 'package:MyMedice/src/utils/theme/wigetes_themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'wigetes_themes/appbar_theme.dart';

class TAppTheme {
  TAppTheme._(); // mack consractor privte

  static ThemeData lightTheme = ThemeData(
    
      brightness: Brightness.light,
      drawerTheme: TDrawerTheme.lightDrawerTheme,
      textTheme: TTextTheme.lightTextTheme,
      appBarTheme: TAppBarTheme.lightAppBarTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(),
      elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.lightInputDecorationTheme);

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      drawerTheme: TDrawerTheme.darkDrawerTheme,
      textTheme: TTextTheme.darkTextTheme,
      appBarTheme: TAppBarTheme.darkAppBarTheme,
      floatingActionButtonTheme: const FloatingActionButtonThemeData(),
      elevatedButtonTheme: TElevatedButtonTheme.darckElevatedButtonTheme,
      outlinedButtonTheme: TOutlinedButtonTheme.darckOutlinedButtonTheme,
      inputDecorationTheme: TTextFormFieldTheme.darkInputDecorationTheme);
}


// hadi file ta3 globle Theme