import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sanskrit_project/models/bottomPanelModel.dart';

import './pages/home.dart';
import './pages/learn.dart';
import './pages/login.dart';
import './pages/profile.dart';
import 'models/signInModel.dart';

Map<String, Widget> _pages = {
  'Home': Home(),
  'Learn': LearnPage(),
  'Profile': ProfileScreen()
};

class BottomPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int _selectedPageIndex = Provider.of<BottomPanelModel>(context).ind;

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
          ),
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
          Provider.of<BottomPanelModel>(context, listen: false).setInd(index);
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
