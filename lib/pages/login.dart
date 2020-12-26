import 'package:flutter/material.dart';
import 'package:sanskrit_project/pages/profile.dart';

import '../models/signInModel.dart';
import '../pages/splash.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SignInModel _signInModel = SignInModel();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              child: Text(
                'Login with Google',
              ),
              onPressed: () async {
                SignInModel _signInModel = SignInModel();
                await _signInModel.signInGoogle();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            MaterialButton(
              child: Text(
                'Login with Facebook',
              ),
              onPressed: () async {
                await _signInModel.signInFacebook();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Splash(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
