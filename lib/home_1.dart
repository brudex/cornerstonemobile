import 'package:cornerstone/home/homepage_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home1 extends StatefulWidget {
  Home1({Key key}) : super(key: key);

  @override
  _Home1State createState() => _Home1State();
}

class _Home1State extends State<Home1> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
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
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.bookmark_border_sharp,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_none_sharp,
              color: Colors.black,
            ),
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
              ), label: 'School',
          ),
          BottomNavigationBarItem(
               backgroundColor: Colors.blue,
            icon:  SvgPicture.asset(
                "images/search.svg",
              ), label: 'School',
          ),
          BottomNavigationBarItem(
               backgroundColor: Colors.blue,
            icon: SvgPicture.asset(
                "images/deposit.svg",
              ),
            label: 'School',
          ),
             BottomNavigationBarItem(
                  backgroundColor: Colors.blue,
            icon:  SvgPicture.asset(
                "images/grid_view.svg",
              ),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
       
        onTap: _onItemTapped,
      ),
    );
  }
}
