import 'package:cornerstone/contact_us.dart';
import 'package:cornerstone/event_2.dart';
import 'package:cornerstone/onboardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'account_settings.dart';
import 'bible.dart';
import 'donations/donation_history.dart';
import 'edit_profile.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  Future logout() async {
    CircularProgressIndicator();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingScreen(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        leading: Center(
          child: Text(
            'More',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 8),
            child: FlatButton(
              onPressed: () {
                logout();
              },
              child: Text(
                'Log Out',
                style: TextStyle(fontSize: 17, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Color.fromRGBO(242, 245, 247, 1),
      body: ListView(
        children: [
          SizedBox(
            height: 25,
            child: Container(
              color: Colors.white,
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Container(
                width: 90,
                height: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/profile.png'),
                      fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'doe.jonathan@mail.com',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            color: Colors.white,
            child: Center(
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  );
                },
                child: Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.inbox,
              color: Colors.blue,
            ),
            onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EventSuccess(),
                ),
              );
            },
            title: Text('Events'),
          ),
          ListTile(
            leading: Icon(
              Icons.person_outline_sharp,
              color: Colors.blue,
            ),  onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountSettings(),
                ),
              );
            },
            title: Text('Account Settings'),
          ),
          ListTile(
            leading: Icon(
              Icons.contact_phone_outlined,
              color: Colors.blue,
            ),
              onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactUs(),
                ),
              );
            },
            title: Text('Contact us'),
          ),
          ListTile(
            leading: Icon(
              Icons.menu_book_sharp,
              color: Colors.blue,
            ),  onTap: (){
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Bible(),
                ),
              );
            },
            title: Text('The Bible'),
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              color: Colors.blue,
            ),
            title: Text('Donation History'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DonationHistory(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.calendar_today_outlined,
              color: Colors.blue,
            ),
            title: Text('Book Appointment'),
          ),
          ListTile(
            title: Text(
              'Terms & Condition',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            title: Text(
              'Privacy & Policy',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
