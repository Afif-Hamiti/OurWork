import 'package:MyMedice/src/authentication/models/user_model.dart';
import 'package:MyMedice/src/repository/authentication_repository/authentification_repository.dart';
import 'package:MyMedice/src/repository/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();
}
