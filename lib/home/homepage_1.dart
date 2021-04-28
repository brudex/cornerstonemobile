import 'dart:io';
import 'dart:async';
import 'package:badges/badges.dart';
import 'package:cornerstone/video.dart';
import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

  //var id = YoutubePlayer.convertUrlToId(url);
  var devotionalQuote;
  bool ready = false;
  List _links = [];
  List _audioLinks = [];

  Future fetchDevotion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/churchcontent/dailydevotional";
    var token = "${prefs.getString('token')}";
    var youtubeUrls =
        "http://157.230.150.194:3000/api/churchcontent/video?limit=0&offset=0";

    var audioUrls =
        "http://157.230.150.194:3000/api/churchcontent/audio?limit=0&offset=0";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final getUrls = await http.get(
      Uri.parse(youtubeUrls),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final getaudioUrls = await http.get(
      Uri.parse(audioUrls),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    // final responseJson = jsonDecode(response.body);
    //print('$responseJson' + 'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre');

    final responseJson2 = jsonDecode(getaudioUrls.body);
    print('$responseJson2' + 'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre');

    var message = jsonDecode(response.body);
    // print(message['data']);
    var value = message['data'];
    // print(value['id']);

    var message2 = jsonDecode(getUrls.body);

    var message3 = jsonDecode(getaudioUrls.body);
    // print(message2['data']);
    var value2 = message2['data'][1];
    // print(value2);
    // print(value2['contentData']);
    List links = [];
    List audioLinks = [];
    for (var item in message2['data']) {
      links.add(YoutubePlayer.convertUrlToId(item['contentData']));
    }

    for (var item in message3['data']) {
      audioLinks.add(item['contentData']);
    }

    //print(links);
    if (this.mounted) {
      setState(() {
        _links = links;
        _audioLinks = audioLinks;
        devotionalQuote = message['data']['devotionalContent'];
        ready = true;
      });
    }

    //var value = jsonDecode(message['data']);
    //print(value);
  }

  createVideoList(int d) {
    _links.forEach((element) {
      return Container(
        height: 190,
        width: 270,
        padding: const EdgeInsets.only(top: 20, bottom: 20, right: 4, left: 16),
        child: YoutubePlayer(
          controller: YoutubePlayerController(
              flags: YoutubePlayerFlags(autoPlay: false, mute: false),
              initialVideoId: _links[element]),
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blue,
          progressColors: ProgressBarColors(
              playedColor: Colors.blue, handleColor: Colors.blue),
        ),
      );
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
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 8),
            child: Icon(
              Icons.bookmark_border_sharp,
              color: Colors.black,
            ),
          ),
          PopupMenuButton(
            icon: Badge(
              badgeContent: Text(
                '2',
                style: TextStyle(color: Colors.white),
              ),
              badgeColor: Colors.blue,
              child: Icon(
                Icons.notifications_none_sharp,
                color: Colors.black,
              ),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: InkWell(
                    splashColor: Colors.grey, // splash color
                    child: Text('• Payment of GHc 2,000.00 was successful'),
                  ),
                ),
                PopupMenuItem(
                    child: InkWell(
                        splashColor: Colors.grey, // splash color
                        child:
                            Text('• Password has been changed successfully'))),
              ];
            },
          ),
        ],
      ),
      body: ready == false
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                        padding:
                            EdgeInsets.only(left: 25.0, right: 25, top: 20),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          "$devotionalQuote",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        )),
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (String i in _links)
                          Container(
                            height: 190,
                            width: 270,
                            padding: const EdgeInsets.only(
                                top: 20, bottom: 20, right: 4, left: 16),
                            child: YoutubePlayer(
                              controller: YoutubePlayerController(
                                  flags: YoutubePlayerFlags(
                                      autoPlay: false, mute: false),
                                  initialVideoId: "$i"),
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: Colors.blue,
                              progressColors: ProgressBarColors(
                                  playedColor: Colors.blue,
                                  handleColor: Colors.blue),
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
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _audioLinks.length == 0
                        ? Container(
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
                            ),)
                        : Column(
                            children: [
                              for (String i in _audioLinks) AudioTile(url: i),
                            ],
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}
