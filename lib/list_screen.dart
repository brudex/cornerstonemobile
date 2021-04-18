

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'list/list_page.dart';

class ListScreen extends StatefulWidget {
  ListScreen({Key key}) : super(key: key);

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
   ListPage(),
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
