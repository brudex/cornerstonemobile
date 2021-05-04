import 'dart:io';
import 'dart:async';
import 'package:badges/badges.dart';
import 'package:cornerstone/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
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
  }

  var churchName;
  var devotionalQuote;
  bool ready = false;
  List _links = [];
  List _youtubeLinks = [];
  List _audioLinks = [];

  Future fetchDevotion() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/churchcontent/dailydevotional";
    var token = "${prefs.getString('token')}";
    var youtubeUrls =
        "http://157.230.150.194:3000/api/churchcontent/video?limit=0&offset=0";

    var audioUrls =
        "http://157.230.150.194:3000/api/churchcontent/audio?limit=0&offset=0";

    var churchUrl = "http://157.230.150.194:3000/api/church";

    final churchResponse = await http.get(
      Uri.parse(churchUrl),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final churchResponseJson = jsonDecode(churchResponse.body);
    print('$churchResponseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

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
    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

    final responseJson2 = jsonDecode(getaudioUrls.body);
    print('$responseJson2' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 3 audio');

    var message = jsonDecode(response.body);
    //  print(message['data']);
//var value = message['data'];
    //   print(value['id']);

    var message2 = jsonDecode(getUrls.body);
    print('$message2' + 'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 2 video');
    var message3 = jsonDecode(getaudioUrls.body);
    //(message2['data']);
    //var value2 = message2['data'][1];
    // print(value2);
    //print(value2['contentData']);
    List links = [];
    List youtubeLinks = [];
    List audioLinks = [];
    for (var item in message2['data']) {
      links.add(YoutubePlayer.convertUrlToId(item['contentData']));
    }

    for (var item in message2['data']) {
      youtubeLinks.add(item['contentData']);
    }

    for (var item in message3['data']) {
      audioLinks.add(item['contentData']);
    }

    print(links);
    if (this.mounted) {
      setState(() {
        churchName = churchResponseJson["name"];
        _links = links;
        _youtubeLinks = youtubeLinks;
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
                scale: 2,
              ),
              actions: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, bottom: 16.0, right: 8),
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
                          child:
                              Text('• Payment of GHc 2,000.00 was successful'),
                        ),
                      ),
                      PopupMenuItem(
                          child: InkWell(
                              splashColor: Colors.grey, // splash color
                              child: Text(
                                  '• Password has been changed successfully'))),
                    ];
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
                  _links.length == 0
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
                              for (var i = 0; i < _links.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: InkWell(
                                    onTap: () {
                                      print('tapped');

                                      launch(
                                          "${_youtubeLinks[i]}"); //or any link you want
                                    },
                                    child: Stack(children: [
                                      Container(
                                        height: 150,
                                        width: 220,
                                        child: Image.network(
                                            'https://img.youtube.com/vi/${_links[i]}/0.jpg'),
                                      ),
                                      Container(
                                        width: 220,
                                        height: 150,
                                        child: Icon(
                                          Icons.play_arrow,
                                          color: Colors.white,
                                          size: 100,
                                        ),
                                      ),
                                    ]),
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
                            ),
                          )
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
