import 'package:flutter/material.dart';

class TabsModel extends StatelessWidget {
  final String icon;

  const TabsModel({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Tab(
      height: 100,
      child: Image.asset(
        icon,
        height: 28,
        width: 28,
        color: isDark ? Colors.white : Colors.black,
      ),
    );
  }
}
