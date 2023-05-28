import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailVerificationScreen extends StatefulWidget {
  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;
    _user.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Text('A verification email has been sent to ${_user.email}. Please check your inbox and follow the instructions to verify your email.'),
      ),
    );
  }
}