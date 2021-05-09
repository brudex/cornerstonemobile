import 'package:cornerstone/ui/main_screens/home/homepage_1.dart';
import 'package:cornerstone/ui/main_screens/search/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'donations/donation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'more/more_page.dart';

class Home1 extends StatefulWidget {

  @override
  _Home1State createState() => _Home1State();
}

int let;

class _Home1State extends State<Home1> {
  
  @override
  void initState() {
    super.initState();

    setState(() {
      getAlert();
    });
  }

  Future getAlert() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      let = prefs.getInt('alert');
      print(let);
    });
  }

  int _selectedIndex = 0;
  // ignore: unused_field
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static List<Widget> _widgetOptions = <Widget>[
    HomePage1(),
    SearchPage(),
    Donation(),
    MorePage(),
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
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
