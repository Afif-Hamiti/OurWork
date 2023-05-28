import 'package:MyMedice/src/constants/sizes.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/authentication/controllers/otp_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var otpcontroller = Get.put(OTPController());
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    var otp;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tOtpTitle,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 80.0),
            ),
            Text(tOtpSubTitle.toUpperCase(),
                style: Theme.of(context).textTheme.headline6),
            const SizedBox(height: 40.0),
            const Text("$tOtpMessage user!.email.toString()",
                textAlign: TextAlign.center),
            const SizedBox(height: 20.0),
            OtpTextField(
                mainAxisAlignment: MainAxisAlignment.center,
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                onSubmit: (code) {
                  otp = code;
                  //* verify OTP (avec php)
                }),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    //* verify OTP (avec php)
                  },
                  child: const Text(tNext)),
            ),
          ],
        ),
      ),
    );
  }
}
