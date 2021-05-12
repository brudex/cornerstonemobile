import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoder/geocoder.dart';
// ignore: unused_import

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
  var address;
  var findUs;

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
    address = responseJson['address'];
    print(responseJson['phone']);
    /* List<Placemark> placemarks = await placemarkFromCoordinates(
      address[0],address[1]);
    print(placemarks[0].street); */

    print(responseJson['address']);

    if (this.mounted) {
      setState(() {
        ready = true;
        phone = responseJson['phone'];
        email = responseJson['email'];
        website = responseJson['website'];
        fbHandle = responseJson['fbHandle'];
        igHandle = responseJson['IGHandle'];
        twitterHandle = responseJson['twitterHandle'];
        //findUs = placemarks[0].street;
      });
    }

    // From coordinates
final coordinates = new Coordinates(1.10, 45.50);
var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);

print(addresses);
/* var first = addresses.first;
print("${first.featureName} : ${first.addressLine}"); */

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
                  subtitle: Text('$findUs'),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        child: InkWell(
                          onTap: () {
                            launch(fbHandle);
                          },
                          child: Image.asset(
                            "images/facebook.png",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        child: InkWell(
                          onTap: () {
                            launch(igHandle);
                          },
                          child: Image.asset(
                            "images/instagram.png",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 70,
                        width: 70,
                        child: InkWell(
                          onTap: () {
                            launch(twitterHandle);
                          },
                          child: Image.asset(
                            "images/twitter.png",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
