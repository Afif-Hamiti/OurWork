import 'package:MyMedice/src/constants/image_strings.dart';
import 'package:MyMedice/src/constants/sizes.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/authentication/screens/SignUp/signup_screen.dart';
import 'package:MyMedice/src/authentication/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(tWelcomeScreenIcon, height: height * 0.66),
                Column(
                  children: [
                    Text(tWelcomeTitle,
                        style: Theme.of(context).textTheme.headline3),
                    Text(tWelcomeSubTitle,
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.to(() => const LoginScreen()),
                        child: Text(tLogin.toUpperCase()),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.to(() => const SingnUpScreen()),
                        child: Text(tSignup.toUpperCase()),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
