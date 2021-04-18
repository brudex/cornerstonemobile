import 'package:cornerstone/home/homepage_1.dart';
import 'package:cornerstone/home/homepage_2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart';

import 'list/list_empty_page.dart';

class ListEmptyScreen extends StatefulWidget {
  ListEmptyScreen({Key key}) : super(key: key);

  @override
  _ListEmptyScreenState createState() => _ListEmptyScreenState();
}

class _ListEmptyScreenState extends State<ListEmptyScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
   ListEmptyPage(),
   Text( 'Index 2: School',
      style: optionStyle,),
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
