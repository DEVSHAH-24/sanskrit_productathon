import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sanskrit_project/models/dataModel.dart';
import 'package:sanskrit_project/models/firebaseModel.dart';
import 'package:sanskrit_project/pages/profile.dart';

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
      body: Center(
        child: Container(
          child: Text('Hello'),
        ),
      ),
    );
  }

  void _navigationCondition() async {
    try {
      await firebaseModel.initializeFirebase();
      _conditionVerification();
    } catch (e) {
      _conditionVerification();
    }
  }

  void _conditionVerification() async {
    User user = FirebaseAuth.instance.currentUser;
    try {
      FirebaseModel firebaseModel = FirebaseModel();
      DataModel dataModel = await firebaseModel.getUserDataFromUser(user);
      print(dataModel.name);
      print(dataModel.email);
      _navigateToHome();
    } catch (e) {
      _navigateToLogin();
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
          builder: (context) => ProfileScreen(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _navigationCondition();
  }
}
