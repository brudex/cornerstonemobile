import 'package:cornerstone/list/list_page.dart';
import 'package:cornerstone/ui/main_screens/donations/donation_history.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/appointment.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/contact_us.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/event_2.dart';
import 'package:cornerstone/access_pages/onboardingScreen.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/privacy.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/terms.dart';
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
  var image;
  var imageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future fetchUserDetails() async {
     await getUserProfilePic();
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
    if (this.mounted) {
      setState(() {
        email = responseJson['data']["email"];
        firstName = responseJson['data']["firstName"];
        lastName = responseJson['data']["lastName"];

        if (image != null) {
          image.resolve(ImageConfiguration()).addListener(
            ImageStreamListener(
              (info, call) {
                print('Networkimage is fully loaded and saved');
                setState(() {
                  ready = true;
                });
                // do something
              },
            ),
          );
        } else{
          ready = true;
        }
      });
    }
  }

  Future getUserProfilePic() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/users/getprofilepicture";
    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);

    print(responseJson['data']);

    if (responseJson['data'] != null) {
      setState(() {
        image = NetworkImage(responseJson['data']);

        imageUrl = responseJson['data'];
      });
    }
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
                  width: 200,
                  height: 200,
                  child: image == null
                      ? CircleAvatar(
                          backgroundColor: Color.fromRGBO(242, 245, 247, 1),
                          radius: 30,
                          child: Icon(Icons.person, size: 50),
                        )
                      : CircleAvatar(
                          backgroundImage: image,
                          backgroundColor: Colors.white,
                          radius: 30,
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
                              fname: '$firstName',
                              lname: '$lastName',
                              image: '$imageUrl',
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Privacy(),
                      ),
                    );
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
