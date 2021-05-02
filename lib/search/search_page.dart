import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchPageController;
  FocusNode _searchPageFocus;
  bool _loading = false;
  List results = [];
  List _contentData = [];
  List _youtubeUrls = [];
  List audioUrls = [];
  bool found = false;

  // Initially password is obscure

  // ignore: unused_field
  String _searchPage;

  void performDonationHistory() {
    //DonationHistory here
  }

  Future search() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> queryParameters = {
      'query': "${_searchPageController.text}"
    };
    var uri = Uri.http(
        "157.230.150.194:3000", "/api/churchcontent/search", queryParameters);
    var token = "${prefs.getString('token')}";

    final response = await http.get(
      uri,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    print(jsonDecode(response.body));

    var message = jsonDecode(response.body);
    print((message)['data']);
    List dataTypes = [];
    List contentData = [];
    List youtubeUrls = [];
    audioUrls = [];
    for (var item in message['data']) {
      dataTypes.add(item['contentType']);
      if (item['contentType'] == "video") {
        youtubeUrls.add(YoutubePlayer.convertUrlToId(item['contentData']));
      }
    }
    for (var item in message['data']) {
      contentData.add(item['contentData']);
    }

    print(dataTypes);
    setState(() {
      if (dataTypes.length > 0) {
        found = true;
      }

      if (youtubeUrls.length > 0) {
        _youtubeUrls = youtubeUrls;
      }

      results = dataTypes;
      print('done');
      _contentData = contentData;
      _loading = false;
    });
  }

  @override
  void initState() {
    _searchPageController = TextEditingController();

    _searchPageFocus = FocusNode();

    super.initState();
  }

  var ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color.fromRGBO(242, 245, 247, 1),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 16, bottom: 16),
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10.0),
                        child: TextField(
                          focusNode: _searchPageFocus,
                          controller: _searchPageController,
                          obscureText: false,
                          textInputAction: TextInputAction.next,
                          onSubmitted: (input) {
                            _searchPage = input;
                          },
                          onTap: () {},
                          decoration: InputDecoration(
                            hintText: 'Search Page History',
                            suffixIcon: IconButton(
                              icon: Icon(
                                Icons.search,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                setState(
                                  () {
                                    _loading = true;
                                    search();
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    DefaultTabController(
                      length: 4,
                      child: TabBar(
                        labelColor: Colors.blue,
                        unselectedLabelColor: Colors.black,
                        onTap: (index) {
                          if (index == 1) {
                            ind = 1;
                            setState(() {});
                          } else if (index == 0) {
                            ind = 0;
                            setState(() {});
                          } else if (index == 2) {
                            ind = 2;
                            setState(() {});
                          } else if (index == 3) {
                            ind = 3;
                            setState(() {});
                          }
                        },
                        isScrollable: true,
                        tabs: <Widget>[
                          Tab(text: "All Results"),
                          Tab(text: "Sermons"),
                          Tab(text: "Devotions"),
                          Tab(text: "Videos"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (ind == 0)
                SingleChildScrollView(
                  child: _loading == false
                      ? found == false
                          ? Column(
                              children: [
                                SizedBox(height: 20),
                                Image.asset('images/events_unavailable.png'),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Find Sermons',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'SearchPage Sermons, Devotions, Bible, as you like',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                ),
                              ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                            )
                          : SingleChildScrollView(
                              child: Column(
                                children: [
                                  for (var i = 0; i < results.length; i++)
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: results[i] == 'sermon'
                                          ? AudioTile(
                                              url:
                                                  "http://157.230.150.194:3000/uploads/sermons/SermonAudio%20-%20Media%20Player_2.mp3",
                                            )
                                          : results[i] == 'video'
                                              ? InkWell(
                                                  onTap: () {
                                                    print('tapped');
                                                    launch(
                                                        "${_contentData[i]}"); //or any link you want
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Center(
                                                      child: Stack(
                                                        children: [
                                                          Container(
                                                            height: 200,
                                                            width: 430,
                                                            child: Image.network(
                                                                'https://img.youtube.com/vi/${_youtubeUrls[i]}/0.jpg'),
                                                          ),
                                                          Container(
                                                            width: 430,
                                                            height: 200,
                                                            child: Icon(
                                                              Icons.play_arrow,
                                                              color:
                                                                  Colors.white,
                                                              size: 100,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  margin:
                                                      EdgeInsets.only(top: 5),
                                                  height: 200,
                                                  width: double.infinity,
                                                  child: Card(
                                                    semanticContainer: true,
                                                    // color: Colors.grey,
                                                    elevation: 5.0,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .error_outline_sharp,
                                                          size: 50,
                                                        ),
                                                        SizedBox(height: 20),
                                                        Text(
                                                          results[i],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                    ),
                                ],
                              ),
                            )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 30),
                            CircularProgressIndicator(),
                          ],
                        ),
                )
              else if (ind == 1)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < results.length; i++)
                        results[i] == 'sermon'
                            ? Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AudioTile(
                                  url:
                                      "http://157.230.150.194:3000/uploads/sermons/SermonAudio%20-%20Media%20Player_2.mp3",
                                ),
                              )
                            : SizedBox(),
                    ],
                  ),
                )
              else if (ind == 2)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < results.length; i++)
                        results[i] == 'devotional'
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.error_outline_sharp,
                                          size: 50,
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          results[i],
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                    ],
                  ),
                )
              else if (ind == 3)
                SingleChildScrollView(
                  child: Column(
                    children: [
                      for (var i = 0; i < results.length; i++)
                        results[i] == 'video'
                            ? InkWell(
                                onTap: () {
                                  print('tapped');
                                  launch(
                                      "${_contentData[i]}"); //or any link you want
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: 430,
                                          child: Image.network(
                                              'https://img.youtube.com/vi/${_youtubeUrls[i]}/0.jpg'),
                                        ),
                                        Container(
                                          width: 430,
                                          height: 200,
                                          child: Icon(
                                            Icons.play_arrow,
                                            color: Colors.white,
                                            size: 100,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
