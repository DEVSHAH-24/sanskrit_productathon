import 'package:flutter/material.dart';

import './pages/home.dart';
import './pages/learn.dart';
import './pages/login.dart';
import './pages/profile.dart';
import 'models/signInModel.dart';

class BottomPanel extends StatefulWidget {
  @override
  _BottomPanelState createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  int _selectedPageIndex = 0;
  Map<String, Widget> _pages = {
    'Home': Home(),
    'Learn': LearnPage(),
    'Profile': ProfileScreen()
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
            ),
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
          )
        ],
        title: Text(
          _pages.keys.elementAt(_selectedPageIndex),
        ),
      ),
      body: IndexedStack(
        children: _pages.values.toList(),
        index: _selectedPageIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        onTap: (index) {
          setState(() {
            _selectedPageIndex = index;
          });
        },
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.tealAccent[700],
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.connect_without_contact_sharp,
              ),
              label: 'Connect'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
