import 'package:MyMedice/src/constants/colors.dart';
import 'package:MyMedice/src/constants/sizes.dart';
import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  // * light theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        foregroundColor: tWhiteColor,
                        backgroundColor: tSecondaryColor,
                        side:  const BorderSide(color: tSecondaryColor),
                        padding: const EdgeInsets.symmetric(vertical: tButtonHigth)),
  );


  // * darck theme
  static final darckElevatedButtonTheme = ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
                        shape:  RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                        elevation: 0,
                        foregroundColor: tSecondaryColor,
                        backgroundColor: tWhiteColor,
                        side: const BorderSide(color: tSecondaryColor),
                        padding: const EdgeInsets.symmetric(vertical: tButtonHigth)),
  );
}
