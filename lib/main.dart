import 'package:MyMedice/src/authentication/screens/on_boarding/on_boarding_screen.dart';
import 'package:MyMedice/src/utils/theme/them.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'src/core/screens/navigat.dart';

bool isLogin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  var user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    isLogin = false;
  } else {
    isLogin = true;
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      defaultTransition: Transition.leftToRightWithFade,
      transitionDuration: const Duration(milliseconds: 500),
      home: isLogin ? const Dachboard() : const OnBoardingScreen(),
    );
  }
}
