import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  void initState() {
    super.initState();
    fetchDetails();
  }

  bool ready = false;

  var phone; 
  var email;
  var website;
  var fbHandle;
  var igHandle;
  var twitterHandle;


  Future fetchDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/church";
    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

        print(responseJson['phone']);
    print(responseJson['findus']);
    if (this.mounted) {
      setState(() {
        ready = true;
        phone =  responseJson['phone'];
        email = responseJson['email'];
        website = responseJson['website'];
        fbHandle = responseJson['fbHandle'];
        igHandle = responseJson['IGHandle'];
        twitterHandle = responseJson['twitterHandle'];
      });
    }

    //var value = jsonDecode(message['data']);
    //print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text(
          'Contact us',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: ready == false
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                ListTile(
                  subtitle: Text(
                    "$phone",
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  title: new Text(
                    'Phone number',
                    style: new TextStyle(fontSize: 14.0, color: Colors.black),
                  ),
                ),
                ListTile(
                  subtitle: Text(
                    'Mon- Sat',
                    style: new TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  title: new Text(
                    'Working hours',
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  trailing: Text('8:00 am - 8:00 pm'),
                ),
                ListTile(
                  title: new Text(
                    'Sundays',
                    style:
                        new TextStyle(fontSize: 20.0, color: Colors.grey[600]),
                  ),
                  trailing: Text('6:00 am - 8:00 pm'),
                ),
                ListTile(
                  subtitle: Text('$email'),
                  title: new Text(
                    'Email',
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                ListTile(
                  subtitle: Text('$website'),
                  title: new Text(
                    'Website',
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                ListTile(
                  subtitle: Text('Levites Avenue'),
                  title: new Text(
                    'Find us',
                    style: new TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        'Social Media',
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "images/facebook_logo.png",
                    ),
                    Image.asset(
                      "images/instagram_logo.png",
                    ),
                    Image.asset(
                      "images/twitter_logo.png",
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
