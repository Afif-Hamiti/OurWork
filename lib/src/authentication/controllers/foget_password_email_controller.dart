import 'package:MyMedice/src/repository/authentication_repository/authentification_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordEmailController extends GetxController {
  static ForgetPasswordEmailController get instance => Get.find();
//TextField Controllers to get data from TextFields
  final email = TextEditingController();

//Get email from user (Screen) and pass it to Auth Repository for Firebase Authentication
 void emailAuthentication(String email) {
    AuthenticationRepository.instance.emailAuthentication(email);
  }

}
