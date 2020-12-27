import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanskrit_project/pages/login.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;

  @override
  void initState() {
    fetchCurrentUser();
    // TODO: implement initState
    super.initState();
  }

  fetchCurrentUser() async {
    User fetchUser = _auth.currentUser;
    setState(() {
      _user = fetchUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(left: 15, right: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: _user != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                      image: NetworkImage(_user.photoURL),
                      placeholder: AssetImage('assets/images.png'),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    '${_user.displayName}'.toUpperCase(),
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.greenAccent,
                    child: Text(
                      'Beginner',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.green[700],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  RoundButton(
                    onPressed: () {
                      _auth.signOut().then((value) => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login())));
                    },
                    title: 'Log out',
                    color1: Colors.black,
                    color2: Colors.black,
                  ),
                ],
              )
            : SpinKitDoubleBounce(
                color: Colors.black,
              ),
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  RoundButton({this.title, this.color1, this.color2, @required this.onPressed});
  final String title;
  final Color color1;
  final Function onPressed;
  final Color color2;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        shadowColor: Colors.white,
        elevation: 15.0,
        // color: color,

        borderRadius: BorderRadius.circular(40.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              gradient: LinearGradient(
                colors: [color1, color2],
              )),
          child: MaterialButton(
            //padding: EdgeInsets.only(left: 15,right: 15),
            onPressed: onPressed,
            minWidth: 200,
            height: 42.0,
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
