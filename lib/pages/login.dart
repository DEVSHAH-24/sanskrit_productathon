import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/firebaseModel.dart';
import '../models/signInModel.dart';
import '../pages/splash.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _displayAlert() {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text('ERROR'),
              content: Text('Unable To Login'),
              elevation: 40,
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  color: Theme.of(context).primaryColor,
                  child: Text('Ok'),
                )
              ],
            );
          });
    }

    SignInModel _signInModel = SignInModel();
    FirebaseModel _firebaseModel = FirebaseModel();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            padding: const EdgeInsets.all(10),
            shape: StadiumBorder(
              side: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/google_logo.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Login with Google',
                ),
              ],
            ),
            onPressed: () async {
              try {
                User user = await _signInModel.signInGoogle();
                await _firebaseModel.uploadUserData(user);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Splash(),
                  ),
                );
              } catch (e) {
                _displayAlert();
              }
            },
          ),
          MaterialButton(
            padding: const EdgeInsets.all(10),
            shape: StadiumBorder(
              side: BorderSide(
                color: Colors.grey,
                width: 2,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/facebook_logo.jpg',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Login with Facebook',
                ),
              ],
            ),
            onPressed: () async {
              try {
                User user = await _signInModel.signInFacebook();
                await _firebaseModel.uploadUserData(user);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Splash(),
                  ),
                );
              } catch (e) {
                _displayAlert();
              }
            },
          ),
        ],
      ),
    );
  }
}
