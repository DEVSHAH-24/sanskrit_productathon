import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sanskrit_project/models/firebaseModel.dart';
import 'package:sanskrit_project/models/signInModel.dart';

import '../models/dataModel.dart';
import '../pages/login.dart';
import '../pages/widgets/roundedButton.dart';

class Item {
  const Item(this.name, this.color);
  final String name;
  final Color color;
}

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DataModel userData = DataModel();
  SignInModel signInModel = SignInModel();

  List<Item> users = <Item>[
    const Item('Beginner', Colors.green),
    const Item('Intermediate', Colors.yellow),
    const Item('Expert', Colors.red),
  ];
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

  Item selectedItem;
  @override
  Widget build(BuildContext context) {
    return userData.name != null
        ? Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 15),
              child: Column(
                // padding: EdgeInsets.all(15.0),

                // scrollDirection: Axis.vertical,

                // shrinkWrap: true,
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
                      fontWeight: FontWeight.w900,
                      fontSize: 25,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButton<Item>(
                    hint: Text("Select level of proficiency"),
                    value: selectedItem,
                    onChanged: (Item value) {
                      setState(() {
                        selectedItem = value;
                      });
                    },
                    items: users.map((Item user) {
                      return DropdownMenuItem<Item>(
                        value: user,
                        child: Row(
                          children: <Widget>[
                            Text(
                              user.name,
                              style: TextStyle(color: user.color),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.grey[200])]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'BIO',
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(color: Colors.grey[200])]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'This is a bio. This is a bio. This is a bio. This is a bio. This is a bio. This is a bio. This is a bio. This is a bio. This is a bio.',
                        style: TextStyle(
                            color: Colors.lightBlue[900], fontSize: 15),
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Scaffold.of(context)
                          .showBottomSheet((context) => ListView.builder(
                              itemCount: 15,
                              itemBuilder: (context, index) => Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle),
                                    child: ListTile(
                                      onLongPress: () {},
                                      tileColor: Colors.blue[100],
                                      title: Text('Pavan Kalyan Addepalli'),
                                      subtitle: Text('email@email.com'),
                                      trailing: Icon(Icons.email),
                                    ),
                                  )));
                    },
                    subtitle: Text('Tap to see all your connections'),
                    title: Text('Connections'),
                    trailing: Text('24'),
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
            ),
          )
        : SpinKitDoubleBounce(
            color: Colors.black,
          );
  }
}
// DropdownMenuItem(
// value: 'beginner',
// child: Text(
// 'Beginner',
// style: TextStyle(
// decoration: TextDecoration.none,
// fontWeight: FontWeight.w700,
// fontSize: 20,
// color: Colors.black,
// ),
// ),
// ),
