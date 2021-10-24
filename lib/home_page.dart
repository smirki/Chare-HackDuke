import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:autodonate/placeholderwidget.dart';
import 'package:autodonate/map.dart';
import 'package:autodonate/account.dart';
import 'package:autodonate/donations.dart';
import 'package:autodonate/state_management.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  int _currentIndex = 0;
  final List _children = [Donations(), Map(), Account()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    final stateManager = HomePageManager();
    stateManager.getDonation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CHARE'),
      ),
      body: _children[_currentIndex],
      // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Donations'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.map),
            title: Text('Map'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Account'))
        ],
      ),
    );
  }
}
