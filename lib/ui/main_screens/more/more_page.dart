import 'package:cornerstone/list/list_page.dart';
import 'package:cornerstone/ui/main_screens/donations/donation_history.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/appointment.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/contact_us.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/event_2.dart';
import 'package:cornerstone/access_pages/onboardingScreen.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/terms.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'more_pages/account_settings.dart';
import 'more_pages/bible.dart';
import 'more_pages/edit_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  bool ready = false;
  var email;
  var firstName;
  var lastName;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future test() async {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
    _firebaseMessaging.configure(
      // ignore: missing_return
      onLaunch: (Map<String, dynamic> message) {
        print('onLaunch called');
      },
      // ignore: missing_return
      onResume: (Map<String, dynamic> message) {
        print('onResume called');
      },
      // ignore: missing_return
      onMessage: (Map<String, dynamic> message) {
        print('onMessage called');
      },
    );
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('Hello');
    });
    _firebaseMessaging.getToken().then((token) {
      print(token); // Print the Token in Console
    });
  }

  Future fetchUserDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/users/getdetails";
    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');
    setState(() {
    email = responseJson['data']["email"];
    firstName = responseJson['data']["firstName"];
    lastName = responseJson['data']["lastName"];
    ready = true;
    });
  }

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
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 8),
            // ignore: deprecated_member_use
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
      body: ready == false
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: CircularProgressIndicator()),
            )
          : ListView(
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
                     /*  decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/profile.png'),
                            fit: BoxFit.cover),
                      ), */

                      child: Icon(Icons.person, size: 100),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        '$email',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  color: Colors.white,
                  child: Center(
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfile(
                              email: '$email',
                              fname: '$firstName $lastName',

                            ),
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
                  onTap: () {
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
                  ),
                  onTap: () {
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
                  onTap: () {
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
                  ),
                  onTap: () {
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Appointment(),
                      ),
                    );
                  },
                  title: Text('Book Appointment'),
                ),
                  ListTile(
                  leading: Icon(
                    Icons.list_outlined,
                    color: Colors.blue,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListPage(),
                      ),
                    );
                  },
                  title: Text('My List'),
                ),
                ListTile(
                  title: Text(
                    'Terms & Condition',
                    style: TextStyle(color: Colors.grey),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Terms(),
                      ),
                    );
                  },
                ),
                ListTile(
                  onTap: () {
                    test();
                    /*   Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SermonDetail(),
                ),
              ); */
                  },
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
