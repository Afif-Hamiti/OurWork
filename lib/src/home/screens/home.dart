import 'package:MyMedice/src/constants/image_strings.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/home/models/tabs_model.dart';
import 'package:MyMedice/src/home/screens/home_tabs/tab_drops.dart';
import 'package:MyMedice/src/home/screens/home_tabs/tab_injection.dart';
import 'package:MyMedice/src/home/screens/home_tabs/tab_pomade.dart';
import 'package:MyMedice/src/home/screens/home_tabs/tab_suyro.dart';
import 'package:MyMedice/src/home/screens/home_tabs/tab_tablets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({
    Key? key,
  });

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> myTabs = const [
    TabsModel(
      icon: tSuyro,
    ),
    TabsModel(
      icon: tTablets,
    ),
    TabsModel(
      icon: tInjection,
    ),
    TabsModel(
      icon: tDrops,
    ),
    TabsModel(
      icon: tPomad,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 36.0, vertical: 18),
                child: Row(
                  children: [
                    Text(
                      tHomeHeadline,
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                    const Text(
                      tMedical,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // tab bar
              TabBar(
                indicatorWeight: 1,
                indicatorColor: isDark ? Colors.white : Colors.black,
                tabs: myTabs,
                mouseCursor: MouseCursor.defer,
              ),
              // tab bar view
              Expanded(
                child: TabBarView(
                  children: [
                    SuyroTab(),
                    TabletsTab(),
                    InjectionTab(),
                    DropsTab(),
                    PomadTab(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//
