import 'package:MyMedice/src/common_widgets/form/form_header_widget.dart';
import 'package:MyMedice/src/constants/colors.dart';
import 'package:MyMedice/src/constants/image_strings.dart';
import 'package:MyMedice/src/constants/sizes.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/authentication/controllers/foget_password_email_controller.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  ForgetPasswordMailScreen({Key? key}) : super(key: key);
  final controller = Get.put(ForgetPasswordEmailController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                const SizedBox(height: tDefaultSize * 4),
                FormHeaderWidget(
                  image: tForgetPasswordImage,
                  title: tForgetPassword.toUpperCase(),
                  subTitle: tForgetPasswordSubTitle,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  heightBetween: 30.0,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: tFormHeight),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            email != null && EmailValidator.validate(email)
                                ? null
                                : 'Enter a valid Email',
                        cursorColor: tSecondaryColor,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller.email,
                        decoration: const InputDecoration(
                            label: Text(tEmail),
                            hintText: tEmail,
                            prefixIcon: Icon(Icons.mail_outline_rounded)),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                //* passwordResetEmail avec php
                                }
                              },
                              child: const Text(tNext))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
