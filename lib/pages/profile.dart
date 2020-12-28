import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanskrit_project/models/firebaseModel.dart';
import 'package:sanskrit_project/models/signInModel.dart';

import '../models/dataModel.dart';
import '../pages/login.dart';
import '../pages/widgets/roundedButton.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DataModel userData = DataModel();
  SignInModel signInModel = SignInModel();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  fetchUserData() async {
    User fetchUser = signInModel.getCurrentUser();
    FirebaseModel firebaseModel = FirebaseModel();
    userData = await firebaseModel.getUserDataFromUser(fetchUser);
    setState(() {
      userData = userData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return userData.name != null
        ? Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                      image: NetworkImage(userData.photoUrl),
                      placeholder: AssetImage(
                        'assets/images.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${userData.name}'.toUpperCase(),
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w200,
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () {},
                  autofocus: true,
                  focusColor: Colors.green,
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.greenAccent),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // color: Colors.green,
                  child: Text(
                    'Beginner',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RoundButton(
                  onPressed: () async {
                    SignInModel _signInModel = SignInModel();
                    _signInModel.signOutGoogle();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  title: 'Log out',
                  color1: Colors.black,
                  color2: Colors.black,
                ),
              ],
            ),
          )
        : SpinKitDoubleBounce(
            color: Colors.black,
          );
  }
}
