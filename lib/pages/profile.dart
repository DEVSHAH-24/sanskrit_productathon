import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        padding: EdgeInsets.only(left: 15, right: 15),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.grey, Colors.white12, Colors.black12]),
        ),
        child: _user != null
            ? Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: FadeInImage(
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                      image: NetworkImage(_user.photoURL),
                      placeholder: AssetImage('assets/placeholder.jpg'),
                    ),
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
