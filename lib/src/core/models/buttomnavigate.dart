import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class TBottomNavigationBar extends StatelessWidget {
  TBottomNavigationBar(
      {super.key, required this.onChanged, required this.index});

  void Function(int)? onChanged;
  int index;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return GNav(
        selectedIndex: index,
        onTabChange: onChanged,
        backgroundColor: isDark ? Colors.black : Colors.white,
        tabBackgroundColor: Colors.grey.shade800,
        color: isDark ? Colors.white : Colors.black,
        activeColor: isDark ? Colors.white : Colors.black,
        padding: const EdgeInsets.all(12),
        tabs: [
          GButton(
            backgroundColor: isDark
                ? Colors.black.withOpacity(0.1)
                : Colors.white.withOpacity(0.1),
            gap: 8,
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
              gap: 8,
              backgroundColor: isDark
                  ? Colors.black.withOpacity(0.1)
                  : Colors.white.withOpacity(0.1),
              icon: Icons.location_on_outlined,
              text: 'Location'),
          GButton(
            gap: 8,
            icon: Icons.search,
            text: 'Search',
            backgroundColor: isDark
                ? Colors.black.withOpacity(0.1)
                : Colors.white.withOpacity(0.1),
          ),
          GButton(
            gap: 8,
            icon: Icons.person,
            text: 'Profile',
            backgroundColor: isDark
                ? Colors.black.withOpacity(0.1)
                : Colors.white.withOpacity(0.1),
          )
        ]);
  }
}


/**
 * setState(() {
                    index = i;
                  });
 */