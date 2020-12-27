import 'package:flutter/material.dart';

import '../models/signInModel.dart';
import 'login.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Connect',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
            onPressed: () async {
              SignInModel _signInModel = SignInModel();
              bool isGoogleSigned = await _signInModel.isGoogleSignedIn();
              if (isGoogleSigned)
                _signInModel.signOutGoogle();
              else
                _signInModel.signOutFacebook();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          )
        ],
      ),
      body: Text(
        'Hello World',
      ),
    );
  }
}
