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

class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

int fcmAlerts;

class _HomePage1State extends State<HomePage1> {
  FirebaseMessaging messaging;

  Future<void> _askedToLead() async {
    switch (await showDialog<HomePage1>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.all(10),
            title: const Text('Today\'s Devotion'),
            children: <Widget>[
              SimpleDialogOption(
                // onPressed: () { Navigator.pop(context, Department.treasury); },
                child: Text(
                  '$devotionalQuote',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        })) {
      case null:
        // dialog dismissed
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchDevotion();

    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("messaging");
    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      print("message recieved");
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (this.mounted) {
        setState(() {
          fcmAlerts++;
          prefs.setInt('alert', fcmAlerts);
        });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      print('Message clicked!');
    });
  }

  var value = 1;
  var churchName;
  var devotionalQuote;
  bool ready = false;
  List _links = [];
  List _videoLinks = [];
  List _audioLinks = [];

  Future fetchDevotion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (this.mounted) {
      setState(() {
        fcmAlerts = prefs.getInt('alert');
        print(
            "$fcmAlerts jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj ");
        //print(fcmAlerts);
      });
    }
    var devotionalUrl =
        "http://157.230.150.194:3000/api/churchcontent/dailydevotional";
    var token = "${prefs.getString('token')}";
    var videoUrls =
        "http://157.230.150.194:3000/api/churchcontent/video?limit=0&offset=0";

    var audioUrls =
        "http://157.230.150.194:3000/api/churchcontent/sermon?limit=0&offset=0";

    var churchUrl = "http://157.230.150.194:3000/api/church";

    final churchResponse = await http.get(
      Uri.parse(churchUrl),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final churchResponseJson = jsonDecode(churchResponse.body);
    print('$churchResponseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

    final getDevotion = await http.get(
      Uri.parse(devotionalUrl),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final getVideoUrls = await http.get(
      Uri.parse(videoUrls),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final getaudioUrls = await http.get(
      Uri.parse(audioUrls),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    final responseJson = jsonDecode(getDevotion.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

    final responseJson2 = jsonDecode(getaudioUrls.body);
    print('$responseJson2' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 3 audio');
    var message = jsonDecode(getDevotion.body);
    var message2 = jsonDecode(getVideoUrls.body);
    print('$message2' + 'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 2 video');
    var message3 = jsonDecode(getaudioUrls.body);

    List videoLinks = [];
    List audioLinks = [];

    for (var item in message2['data']) {
      videoLinks.add(item['contentData']);
    }

    for (var item in message3['data']) {
      audioLinks.add(item['contentData']);
    }

    if (this.mounted) {
      setState(() {
        churchName = churchResponseJson["name"];
        _videoLinks = videoLinks;
        _audioLinks = audioLinks;
        if (message['data'] != null) {
          devotionalQuote = message['data']['devotionalContent'];
        }
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
    return ready == false
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color.fromRGBO(242, 245, 247, 1),
              title: Text(
                '$churchName',
                style: TextStyle(color: Colors.black),
              ),
              leading: Image.asset(
                'images/CE_logo.png',
                scale: 0.7,
              ),
              actions: [
                IconButton(
                  icon: '$fcmAlerts' != '0'
                      ? Badge(
                          badgeContent: Text(
                            '$fcmAlerts',
                            style: TextStyle(color: Colors.white),
                          ),
                          badgeColor: Colors.blue,
                          child: Icon(
                            Icons.notifications_none_sharp,
                            color: Colors.black,
                          ),
                        )
                      : Icon(
                          Icons.notifications_none_sharp,
                          color: Colors.black,
                        ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Notifications(),
                      ),
                    );
                  },
                ),
              ],
            ),
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
                  devotionalQuote == null
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
                                    'No Quotes\'s Available',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              _askedToLead();
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 5),
                              height: 180,
                              width: double.infinity,
                              child: Card(
                                color: Colors.black,
                                semanticContainer: true,
                                // color: Colors.grey,
                                elevation: 5.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Text(
                                      '$devotionalQuote',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 16, right: 16),
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
                  _videoLinks.length == 0
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
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var i = 0; i < _videoLinks.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: VideoTile(
                                    link: '${_videoLinks[i]}',
                                    height: 200,
                                    width: 200,
                                  ),
                                ),
                            ],
                          ),
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, top: 16, right: 16),
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
                  _audioLinks.length == 0
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
                                    'No Audio\'s Available',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              for (var i = 0; i < _audioLinks.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: AudioTile(
                                      url:
                                          'http://157.230.150.194:3000/uploads/sermons/SermonAudio-Media-Player_2.mp3'),
                                ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          );
  }
}
