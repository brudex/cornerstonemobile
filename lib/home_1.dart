import 'package:cornerstone/home/homepage_1.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart';

class Home1 extends StatefulWidget {
  Home1({Key key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage1(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Blah',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text(
          'Christ Embassy',
          style: TextStyle(color: Colors.black),
        ),
        leading: Image.asset(
          'images/CE_logo.png',
          scale: 2,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 8),
            child: Icon(
              Icons.bookmark_border_sharp,
              color: Colors.black,
            ),
          ),
          
          PopupMenuButton(
            icon:  Badge(
              badgeContent: Text(
                '2',
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Colors.blue,
              child: Icon(
                Icons.notifications_none_sharp,
                color: Colors.black,
              ),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                    child: InkWell(
                        splashColor: Colors.grey, // splash color
                        child: Text('• Payment of GHc 2,000.00 was successful'),),),
                PopupMenuItem(
                    child: InkWell(
                        splashColor: Colors.grey, // splash color
                        child: Text('• Password has been changed successfully'))),
              
              ];
            },
          ),
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: SvgPicture.asset(
              "images/home.svg",
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: SvgPicture.asset(
              "images/search.svg",
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: SvgPicture.asset(
              "images/deposit.svg",
            ),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.blue,
            icon: SvgPicture.asset(
              "images/grid_view.svg",
            ),
            label: 'App',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
