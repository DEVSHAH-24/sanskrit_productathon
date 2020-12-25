import 'package:flutter/material.dart';

import '../models/signInModel.dart';
import '../pages/splash.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          child: Text(
            'Login with Google',
          ),
          onPressed: () async {
            SignInModel _signInModel = SignInModel();
            await _signInModel.signInGoogle();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Splash(),
              ),
            );
          },
        ),
      ),
    );
  }
}
