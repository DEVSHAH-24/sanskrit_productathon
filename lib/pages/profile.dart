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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[200],
        title: Text(
          'Sanskritive',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: _user != null
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 22, bottom: 18),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: FadeInImage(
                          fit: BoxFit.cover,
                          width: 125,
                          height: 125,
                          image: NetworkImage(_user.photoURL),
                          placeholder: AssetImage('assets/images.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${_user.displayName}',
                      style: TextStyle(
                        // decoration: TextDecoration.none,
                        fontWeight: FontWeight.w300,
                        fontSize: 27,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                          autofocus: true,
                          focusColor: Colors.green,
                          textColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.greenAccent),
                              borderRadius: BorderRadius.circular(15)),
                          // color: Colors.green,
                          child: Text(
                            'Beginner',
                            style: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.greenAccent[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'This is an example of bio.This is an example of bio.This is an example of bio.This is an example of bio.This is an example of bio.This is an example of bio.',
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RoundButton(
                      onPressed: () {
                        _auth.signOut().then((value) =>
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login())));
                      },
                      title: 'Log out',
                      color1: Colors.black,
                      color2: Colors.black,
                    ),
                  ],
                ),
              ),
            )
          : SpinKitDoubleBounce(
              color: Colors.black,
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
