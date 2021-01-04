import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sanskrit_project/models/firebaseModel.dart';
import 'package:sanskrit_project/models/signInModel.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/data.dart';
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
  SignInModel _signInModel = SignInModel();
  FirebaseModel _firebaseModel = FirebaseModel();

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
    User fetchUser = _signInModel.getCurrentUser();
    userData = await _firebaseModel.getUserDataFromCloud(fetchUser.uid);
    setState(() {
      userData = userData;
    });
    if (userData.label == 'Beginner')
      selectedItem = users[0];
    else if (userData.label == 'Expert')
      selectedItem = users[2];
    else
      selectedItem = users[1];
  }

  Item selectedItem;

  @override
  Widget build(BuildContext context) {
    return userData.name != null
        ? Container(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        width: 150,
                        height: 150,
                        image: NetworkImage(
                          userData.photoUrl,
                        ),
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
                    hint: Text(
                      "Select level of proficiency",
                    ),
                    value: selectedItem,
                    onChanged: (Item value) {
                      setState(() {
                        selectedItem = value;
                      });
                      if (selectedItem.name != userData.label) {
                        _firebaseModel.updateUserLabel(selectedItem.name);
                      }
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
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'I am a member of Sanskritive community :)',
                        ),
                        initialValue: userData.bio,
                        onFieldSubmitted: (newValue) {
                          _firebaseModel.updateUserBio(newValue);
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      //   Navigator.pop(context);
                      Scaffold.of(context).showBottomSheet((context) =>
                          Consumer<Data>(
                            builder: (context, data, child) {
                              print('rebuild');
                              List<String> connectedUsers =
                                  data.connectedUserIds;
                              print(connectedUsers.length);
                              List<DataModel> connectedUsersData =
                                  data.usersData;
                              connectedUsersData.removeWhere((dataModel) =>
                                  !connectedUsers.contains(dataModel.userId));
                              print(connectedUsersData.length);
                              return ListView.builder(
                                  itemCount: connectedUsersData.length,
                                  itemBuilder: (context, index) {
                                    DataModel dataModel =
                                        connectedUsersData[index];
                                    return Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.rectangle),
                                      child: ListTile(
                                        onLongPress: () {},
                                        tileColor: Colors.blue[100],
                                        title: Text(
                                          dataModel.name,
                                        ),
                                        subtitle: Text(
                                          dataModel.email,
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(
                                            Icons.mail_outline,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            final Uri _emailLaunchUri = Uri(
                                              scheme: 'mailto',
                                              path: dataModel.email,
                                            );
                                            launch(_emailLaunchUri.toString());
                                          },
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ));
                    },
                    subtitle: Text('Tap to see all your connections'),
                    title: Text('Connections'),
                    trailing: Consumer<Data>(
                      builder: (context, data, child) => Text(
                        data.connectedUserIds.length.toString(),
                      ),
                    ),
                  ),
                  RoundButton(
                    onPressed: () async {
                      _signInModel.signOutGoogle();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(),
                          ),
                          (route) => false);
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
