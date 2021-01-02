import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:sanskrit_project/models/firebaseModel.dart';
import 'package:sanskrit_project/models/signInModel.dart';

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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 2,
                    ),
                    child: TextFormField(
                      onFieldSubmitted: (value) =>
                          _firebaseModel.updateUserName(value),
                      initialValue: '${userData.name}'.toUpperCase(),
                      textCapitalization: TextCapitalization.characters,
                      autocorrect: false,
                      decoration: InputDecoration(
                        hintText: 'Enter your name here',
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.w900,
                        fontSize: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Text(
                  //   '${userData.name}'.toUpperCase(),
                  //   style: TextStyle(
                  //     decoration: TextDecoration.none,
                  //     fontWeight: FontWeight.w900,
                  //     fontSize: 25,
                  //     color: Colors.black,
                  //   ),
                  // ),
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
                          hintText: 'Enter your bio here',
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
                      Scaffold.of(context).showBottomSheet((context) =>
                          Consumer<Data>(
                            builder: (context, data, child) {
                              print('rebuild');
                              List<String> connectedUsers =
                                  data.connectedUserIds;
                              print(connectedUsers.length);
                              List<DataModel> connectedUsersData = data.usersData;
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
                                          connectedUsersData[index].name,
                                        ),
                                        subtitle: Text(
                                          connectedUsersData[index].email,
                                        ),
                                        trailing: FlatButton(
                                          child: Text(
                                            'Connected',
                                          ),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    title: Text('ERROR'),
                                                    content: Text(
                                                      'Are You Sure?',
                                                    ),
                                                    elevation: 40,
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        onPressed: () async {
                                                          await Navigator
                                                                  .maybePop(
                                                                      context)
                                                              .then((value) => Provider.of<
                                                                          Data>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .removeConnect(
                                                                      dataModel
                                                                          .userId));
                                                        },
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        child: Text(
                                                          'Yes',
                                                        ),
                                                      ),
                                                      FlatButton(
                                                        onPressed: () async {
                                                          await Navigator
                                                              .maybePop(
                                                                  context);
                                                        },
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        child: Text(
                                                          'No',
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                });
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
