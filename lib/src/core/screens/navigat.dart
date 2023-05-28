import 'package:MyMedice/src/authentication/screens/Welcome/welcome_screen.dart';
import 'package:MyMedice/src/core/models/buttomnavigate.dart';
import 'package:MyMedice/src/repository/authentication_repository/authentification_repository.dart';
import 'package:MyMedice/src/constants/icon_string.dart';
import 'package:MyMedice/src/constants/image_strings.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/home/screens/home.dart';
import 'package:MyMedice/src/map/screens/map.dart';
import 'package:MyMedice/src/profile/screens/profile.dart';
import 'package:MyMedice/src/search/screens/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class Dachboard extends StatefulWidget {
  const Dachboard({super.key});

  @override
  State<Dachboard> createState() => _DachboardState();
}

class _DachboardState extends State<Dachboard> {
  int i = 0;
  User? user = FirebaseAuth.instance.currentUser;

  void pageSwaping(int index) {
    setState(() {
      i = index;
    });
  }

  //* Pages
  List<Widget> pages = [Home(), TMap(), SearchPage(), Profile()];
  final List<String> titles = [
    tHome,
    tLocation,
    tSearch,
    tProfile,
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme txtTheme = Theme.of(context).textTheme;
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 90,
                width: 90,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                      image: AssetImage(tProfileImagePlaceHolder),
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(user!.email.toString()),
              ),
              Divider(
                thickness: 2,
                color: isDark ? Colors.white : Colors.black,
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: isDark ? Colors.white : Colors.black,
                ),
                title: const Text(tHome, style: TextStyle(fontSize: 18)),
                onTap: () {
                  setState(() {
                    i = 0;
                  });
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.account_box,
                  color: isDark ? Colors.white : Colors.black,
                ),
                title: const Text(tProfile, style: TextStyle(fontSize: 18)),
                onTap: () {
                  setState(() {
                    i = 3;
                  });
                  Get.back();
                },
              ),
              ListTile(
                  leading: Icon(
                    Icons.notifications_active,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  title: const Text(tNotifications,
                      style: TextStyle(fontSize: 18)),
                  onTap: () {}),
              ListTile(
                leading: Icon(
                  Icons.search,
                  color: isDark ? Colors.white : Colors.black,
                ),
                title: const Text(tSearch, style: TextStyle(fontSize: 18)),
                onTap: () {
                  setState(() {
                    i = 2;
                  });
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: isDark ? Colors.white : Colors.black,
                ),
                title: const Text(tLocation, style: TextStyle(fontSize: 18)),
                onTap: () {
                  setState(() {
                    i = 1;
                  });
                  Get.back();
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: isDark ? Colors.white : Colors.black,
                ),
                title: const Text(tSettings, style: TextStyle(fontSize: 18)),
                onTap: () {},
              ),
              const SizedBox(
                height: 27,
              ),
              ListTile(
                leading: Icon(
                  LineAwesomeIcons.alternate_sign_out,
                  color: isDark ? Colors.white : Colors.black,
                ),
                title: const Text(tLogout, style: TextStyle(fontSize: 18)),
                onTap: () {
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
                          foregroundColor: Colors.green, side: BorderSide.none),
                      child: const Text("Yes"),
                    ),
                    cancel: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.red, side: BorderSide.none),
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "No",
                        )),
                  );
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => TextButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              child: Image.asset(
                tDrawer,
                color: isDark ? Colors.white : Colors.black,
                height: 25,
                width: 25,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            titles.elementAt(i),
            style: txtTheme.headline2,
          ),
        ),
        bottomNavigationBar: TBottomNavigationBar(
          onChanged: (index) {
            setState(() {
              pageSwaping(index);
            });
          },
          index: i,
        ),
        body: SafeArea(
          child: pages.elementAt(i),
        ),
      ),
    );
  }
}
