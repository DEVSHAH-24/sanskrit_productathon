import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sanskrit_project/models/firebaseModel.dart';

import 'home.dart';
import 'login.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseModel firebaseModel = FirebaseModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  void _navigationCondition() async {
    try {
      firebaseModel
          .initializeFirebase()
          .then((value) => _conditionVerification());
    } catch (e) {
      _conditionVerification();
    }
  }

  void _conditionVerification() {
    if (Firebase.apps.isNotEmpty) {
      try {
        User user = FirebaseAuth.instance.currentUser;
        _navigateToHome();
      } catch (e) {
        _navigateToLogin();
      }
    } else {
      _navigationCondition();
    }
  }

  _navigateToLogin() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
        (route) => false);
  }

  _navigateToHome() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _navigationCondition();
  }
}
