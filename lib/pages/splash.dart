import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../bottomNavigation.dart';
import '../models/dataModel.dart';
import '../models/firebaseModel.dart';
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
      print(user.uid);
      firebaseModel.initializeCollection(user.uid);
      DataModel dataModel = await firebaseModel.getUserDataFromUser(user);
      // firebaseModel.fetchUsers(context);
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
          builder: (context) => BottomPanel(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _navigationCondition();
  }
}
