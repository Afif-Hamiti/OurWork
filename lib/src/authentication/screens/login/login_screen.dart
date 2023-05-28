import 'package:MyMedice/src/authentication/screens/Welcome/welcome_screen.dart';
import 'package:MyMedice/src/common_widgets/form/form_header_widget.dart';
import 'package:MyMedice/src/constants/icon_string.dart';
import 'package:MyMedice/src/constants/image_strings.dart';
import 'package:MyMedice/src/constants/sizes.dart';
import 'package:MyMedice/src/constants/text_strings.dart';
import 'package:MyMedice/src/authentication/controllers/login_controller.dart';
import 'package:MyMedice/src/authentication/screens/SignUp/signup_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MyMedice/src/constants/colors.dart';
import 'package:MyMedice/src/authentication/screens/forget_password/forget_password_options/forget_password_modele_bottom_sheet.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FormHeaderWidget(
                  image: tWelcomeScreenImage,
                  title: tLoginTitle,
                  subTitle: tLoginSubTitle,
                ),
                LoginForm(),
                LoginFooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//* Form
class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult _connectivityResult;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectivityResult = result;
    });
  }

  bool _obscureText = true;
  final controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.email.addListener(() => setState(() {}));
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && EmailValidator.validate(email)
                        ? null
                        : 'Enter a valid Email',
                cursorColor: tSecondaryColor,
                keyboardType: TextInputType.emailAddress,
                controller: controller.email,
                decoration: InputDecoration(
                    suffixIcon: controller.email.text.isEmpty
                        ? Container(
                            width: 0,
                          )
                        : IconButton(
                            onPressed: () => controller.email.clear(),
                            icon: Icon(
                              Icons.close,
                              color: isDark ? tAccentColor : tDarkColor,
                            )),
                    prefixIcon: Icon(
                      Icons.person_outline_outlined,
                      color: isDark ? tAccentColor : tDarkColor,
                    ),
                    labelText: tEmail,
                    hintText: tEmail,
                    border: const OutlineInputBorder()),
              ),
              const SizedBox(
                height: tFormHeight,
              ),
              TextFormField(
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length < 6
                          ? "password can't to be less than 6 letter "
                          : null,
                  cursorColor: tSecondaryColor,
                  keyboardType: TextInputType.name,
                  obscureText: _obscureText,
                  controller: controller.password,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: isDark ? tAccentColor : tDarkColor,
                    ),
                    labelText: tPassWord,
                    hintText: tPassWord,
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: isDark ? tAccentColor : tDarkColor,
                      ),
                    ),
                  )),
              const SizedBox(
                height: tFormHeight,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {
                        ForgetPasswordScreen.buildShowModalBottomSheet(context);
                      },
                      child: const Text(
                        tForgetPassWord,
                      ))),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_connectivityResult.name == 'none') {
                      Get.defaultDialog(
                        backgroundColor: isDark
                            ? Colors.white.withOpacity(0.2)
                            : Colors.black.withOpacity(0.2),
                        title: "Vous êtes hors connexion",
                        titleStyle: const TextStyle(fontSize: 20),
                        content: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 9.0),
                          child: Text("Veuillez vérifier votre connexion"),
                        ),
                        confirm: TextButton(
                          onPressed: () {
                            Get.back();
                            Get.off(const WelcomeScreen());
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: tAccentColor,
                              side: BorderSide.none),
                          child: const Text("ok"),
                        ),
                      );
                    } else if (_formKey.currentState!.validate()) {
                      //* login with php
                    }
                  },
                  child: Text(tLogin.toUpperCase()),
                ),
              ),
            ],
          ),
        ));
  }
}

//* Footer

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('OR'),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
                icon: const Image(
                  image: AssetImage(tGoogleLogoImage),
                  width: 20.0,
                ),
                onPressed: () {
                  // Login with google (avec le php)
                },
                label: const Text(tSignInWithGoogle))),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        TextButton(
            onPressed: () {
              Get.back();
              Get.to(() => const SingnUpScreen());
            },
            child: Text.rich(TextSpan(
                text: tDontHaveAnAccount,
                style: Theme.of(context).textTheme.bodyText1,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const TextSpan(
                      text: tSignup, style: TextStyle(color: tPrimaryColor))
                ])))
      ],
    );
  }
}
