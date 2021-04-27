import 'dart:io';
import 'dart:async';
import 'package:cornerstone/video.dart';
import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

//import 'package:shimmer/shimmer.dart';

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
 
  @override
  void initState() {
    super.initState();
    fetchDevotion();
  }
var devotionalQuote;
bool ready = false;
  Future fetchDevotion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/churchcontent/dailydevotional";
    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {
      HttpHeaders.authorizationHeader:
            "Bearer $token"
      },
      
    );
    final responseJson = jsonDecode(response.body);
    print('$responseJson'+ 'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre');

    var message = jsonDecode(response.body);
    print(message['data']);
    var value = message['data'];
    print(value['id']);
    setState(() {
      devotionalQuote = message['data']['devotionalContent'];
    ready = true;
    });
    
   //var value = jsonDecode(message['data']);
   //print(value);
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Row(
                children: [
                  Text(
                    "Today's Devotion",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.only(left: 25.0, right: 25, top: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child:  ready == false?Text(
                 "Zara of Thamar; and Phares begat Esrom; and Esrom begat Aram;\nAnd Aram begat Aminadab and aminadab begat Naasson; and",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ): Text(
               "$devotionalQuote",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ) 
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Video Sermons",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "View More",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                // YouTubeDemoApp(),

                  VideoTile(
                    link:
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                    width: 270,
                  ),
                  VideoTile(
                    link:
                        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
                    width: 270,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Audio Sermons",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    "View More",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: VideoTile(
                  link:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
            )
          ],
        ),
      ),
    );
  }
}
