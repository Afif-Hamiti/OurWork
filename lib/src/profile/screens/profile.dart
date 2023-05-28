import 'package:MyMedice/src/authentication/screens/Welcome/welcome_screen.dart';
import 'package:MyMedice/src/constants/colors.dart';
import 'package:MyMedice/src/constants/image_strings.dart';
import 'package:MyMedice/src/constants/sizes.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/core/screens/Drawer/settings.dart';
import 'package:MyMedice/src/profile/models/profile_menu.dart';
import 'package:MyMedice/src/profile/screens/uptade_profile_screen.dart';
import 'package:MyMedice/src/repository/authentication_repository/authentification_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Profile extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String selectedImagePath = '';

  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage(tProfileImagePlaceHolder))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: tPrimaryColor),
                        child: IconButton(
                          icon: const Icon(
                            LineAwesomeIcons.alternate_pencil,
                            color: Colors.black,
                            size: 20,
                          ),
                          onPressed: () =>
                              Get.to(() => const UpdateProfileScreen()),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(tProfileHeading,
                  style: Theme.of(context).textTheme.headline4),
              Text(user!.email.toString(),
                  style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(height: 20),

              /// -- BUTTON
              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const UpdateProfileScreen()),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tPrimaryColor,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text(tEditProfile,
                      style: TextStyle(color: tDarkColor)),
                ),
              ),
              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Settings",
                  icon: LineAwesomeIcons.cog,
                  onPress: () {
                    Get.to(() => Settings());
                  }),
              ProfileMenuWidget(
                  title: "Notes",
                  icon: LineAwesomeIcons.medical_notes,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "User Management",
                  icon: LineAwesomeIcons.user_check,
                  onPress: () {}),
              const Divider(),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Information",
                  icon: LineAwesomeIcons.info,
                  onPress: () {}),
              ProfileMenuWidget(
                  title: "Logout",
                  icon: LineAwesomeIcons.alternate_sign_out,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    Get.defaultDialog(
                      backgroundColor: isDark
                          ? Colors.white.withOpacity(0.2)
                          : Colors.black.withOpacity(0.2),
                      title: "LOGOUT",
                      titleStyle: const TextStyle(fontSize: 20),
                      content: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 9.0),
                        child: Text("Are you sure, you want to Logout?"),
                      ),
                      confirm: TextButton(
                        onPressed: () {
                          //* logout (avec php)
                          Get.off(const WelcomeScreen());
                          Fluttertoast.showToast(
                              msg: 'Logout',
                              timeInSecForIosWeb: 5,
                              backgroundColor: Colors.black.withOpacity(0.1));
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.green,
                            side: BorderSide.none),
                        child: const Text("Yes"),
                      ),
                      cancel: TextButton(
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              side: BorderSide.none),
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            "No",
                          )),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
