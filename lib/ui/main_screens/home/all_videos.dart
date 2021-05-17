import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:badges/badges.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/account_settings/notifications.dart';
import 'package:cornerstone/ui/widgets/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AllVideos extends StatefulWidget {
  @override
  _AllVideosState createState() => _AllVideosState();
}

class _AllVideosState extends State<AllVideos> {
  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  var _videoLinks;
  bool ready = false;

  Future fetchVideos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = "${prefs.getString('token')}";
    var videoUrls =
        "http://157.230.150.194:3000/api/churchcontent/video?limit=0&offset=0";

    final getVideoUrls = await http.get(
      Uri.parse(videoUrls),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    var message2 = jsonDecode(getVideoUrls.body);
    print('$message2' + 'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 2 video');

    List videoLinks = [];
    List audioLinks = [];

    for (var item in message2['data']) {
      videoLinks.add(item['contentData']);
    }

    if (this.mounted) {
      setState(() {
        _videoLinks = videoLinks;
      });
      setState(() {
        ready = true;
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
          'Videos',
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
          ? Center(child: CircularProgressIndicator())
          : _videoLinks.length == 0
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    height: 200,
                    width: double.infinity,
                    child: Card(
                      semanticContainer: true,
                      // color: Colors.grey,
                      elevation: 5.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.error_outline_sharp,
                            size: 50,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'No Video\'s Available',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : SingleChildScrollView(
                 // scrollDirection: Axis.horizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (var i = 0; i < _videoLinks.length; i++)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: VideoTile(
                            link: '${_videoLinks[i]}',
                            height: 200,
                            width: 250,
                          ),
                        ),
                    ],
                  ),
                ),
    );
  }
}
