import 'package:cornerstone/ui/main_screens/home/homepage_1.dart';
import 'package:cornerstone/ui/main_screens/search/video_details.dart';
import 'package:cornerstone/ui/widgets/dialogs.dart';
import 'package:cornerstone/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


var x = fcmAlerts;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<void> _askedToLead(String quote, String title, int id,
      {String sermon}) async {
        
    switch (await showDialog<SearchPage>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.all(10),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      Text("  Add To List "),
                    ],
                  ),
                  onPressed: () {
                    addToPlaylist("$title", id);
                  },
                ),
              ],
            ),
            children: <Widget>[
              SimpleDialogOption(
                // onPressed: () { Navigator.pop(context, Department.treasury); },
                child: Text(
                  sermon != 'sermon' ? '$quote' : "$title",
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

  TextEditingController _searchPageController;
  FocusNode _searchPageFocus;
  bool _loading = false;
  List results = [];
  List _contentData = [];
  List _youtubeUrls = [];
  List audioUrls = [];
  List idList = [];
  List titleList = [];
  bool found = false;

  // Initially password is obscure

  // ignore: unused_field
  String _searchPage;

  Future addToPlaylist(String title, int id) async {
    showLoading(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = "${prefs.getString('token')}";
    var url = "http://157.230.150.194:3000/api/churchContent/playlist/add";

    var data = {"churchContentId": "$id", "title": "$title"};

    var response = await http.post(
      Uri.parse(url),
      body: data,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    var message = jsonDecode(response.body);
    print(message);
    /* print(message['message']);
    print(message['status_code']);
    print(message['reason']);
 */
     
    if (message['status'] == "00") {
      Navigator.pop(context);

      failedAlertDialog(context,"Success", message['message']);
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

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
    List ids = [];
    List titles = [];
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
      ids.add(item['id']);
      titles.add(item['title']);
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
      idList = ids;
      titleList = titles;
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
                                          ? Stack(children: [
                                              InkWell(
                                                onTap: () {
                                                  _askedToLead(_contentData[i],
                                                      titleList[i], idList[i],
                                                      sermon: 'sermon');
                                                },
                                                child: AudioTile(
                                                  url: _contentData[i],
                                                ),
                                              ),
                                            ])
                                          : results[i] == 'video'
                                              ? InkWell(
                                                  onTap: () {
                                                    print('tapped');
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            VideoDetail(
                                                          backgroundImage:
                                                              'https://img.youtube.com/vi/${_youtubeUrls[i]}/0.jpg',
                                                          videoUrl:
                                                              _contentData[i],
                                                          title: titleList[i],
                                                          id: idList[i],
                                                        ),
                                                      ),
                                                    );
                                                    /*  launch(
                                                        "${_contentData[i]}"); */ //or any link you want
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
                                              : InkWell(
                                                  onTap: () {
                                                    _askedToLead(
                                                        _contentData[i],
                                                        titleList[i],
                                                        idList[i]);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        EdgeInsets.only(top: 5),
                                                    height: 180,
                                                    width: double.infinity,
                                                    child: Card(
                                                      color: Colors.black,
                                                      semanticContainer: true,
                                                      // color: Colors.grey,
                                                      elevation: 5.0,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Text(
                                                            _contentData[i],
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ),
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
                                child: InkWell(
                                  onTap: () {
                                    _askedToLead(_contentData[i], titleList[i],
                                        idList[i],
                                        sermon: 'sermon');
                                  },
                                  child: AudioTile(
                                    url: _contentData[i],
                                  ),
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
                                child: InkWell(
                                  onTap: () {
                                    _askedToLead(_contentData[i], titleList[i],
                                        idList[i]);
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
                                            _contentData[i],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoDetail(
                                        backgroundImage:
                                            'https://img.youtube.com/vi/${_youtubeUrls[i]}/0.jpg',
                                        videoUrl: _contentData[i],
                                        title: titleList[i],
                                        id: idList[i],
                                      ),
                                    ),
                                  );
                                  /*   launch(
                                      "${_contentData[i]}"); */ //or any link you want
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
