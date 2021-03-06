
import 'package:cornerstone/player_widget.dart';

import 'package:cornerstone/ui/widgets/dialogs.dart';
import 'package:cornerstone/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';


class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<void> _askedToLead(
      String quote, String title, int id, String devotional,
      // ignore: unused_element
      {String sermon}) async {
    switch (await showDialog<SearchPage>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.all(10),
            title: Column(
              children: [
                Row(
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
                Text(
                  '$title',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            children: <Widget>[
              SimpleDialogOption(
                // onPressed: () { Navigator.pop(context, Department.treasury); },
                child: Text(
                  '$devotional',
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
  // ignore: unused_field
  List _videoUrl = [];
  List audioUrls = [];
  List idList = [];
  List titleList = [];
  bool found = false;
  bool loaded = false;
  List _total = [];
  List _videos = [];
  List _sermons = [];
  List _devotionals = [];
  bool _searchdone = false;
  List _searchedSermons = [];
  List _searchedDevotionals = [];
  List _searchedVideos = [];
  bool searching = false;
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

    if (message['status'] == "00") {
      Navigator.pop(context);

      failedAlertDialog(context, "Success", message['message']);
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  Future search() async {
    
    found = false;
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

    var message = jsonDecode(response.body);
    print((message)['data']);
    List dataTypes = [];
    List contentData = [];
    List ids = [];
    List titles = [];
    List videoUrl = [];
    List searchedVideos = [];
    List searchedDevotionals = [];
    List searchedSermons = [];

    audioUrls = [];
    for (var item in message['data']) {
      dataTypes.add(item['contentType']);
      if (item['contentType'] == "video") {
        searchedVideos.add(item);
      } else if (item['contentType'] == "sermon") {
        searchedSermons.add(item);
      } else if (item['contentType'] == "devotional") {
        searchedDevotionals.add(item);
      }
    }
    
      for (var item in message['data']) {
        contentData.add(item['contentData']);
        ids.add(item['id']);
        titles.add(item['title']);
      }
    

      setState(() {
        if (dataTypes.length > 0) {
          found = true;
        } else {
          found = false;
        }

        if (videoUrl.length > 0) {
          _videoUrl = videoUrl;
        }
        searching = false;

        results = dataTypes;
        print('done');
        print(found);
        _contentData = contentData;
        idList = ids;
        titleList = titles;
        _searchdone = true;
        _searchedSermons = searchedSermons;
        _searchedDevotionals = searchedDevotionals;
        _searchedVideos = searchedVideos;
        _loading = false;
      });
    
  }

  Future fetchRecent() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = "${prefs.getString('token')}";

    var recentContentUrl =
        "http://157.230.150.194:3000/api/churchcontent/recent?contentType=all";

    final recentContent = await http.get(
      Uri.parse(recentContentUrl),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final recentContentData = jsonDecode(recentContent.body);
   

    List total = recentContentData['data'];

    

    List sermons = [];
    List videos = [];
    List devotionals = [];

    for (var item in total) {
      if (item['contentType'] == 'sermon') {
        sermons.add(item);
      } else if (item['contentType'] == 'video') {
        videos.add(item);
      } else if (item['contentType'] == 'devotional') {
        devotionals.add(item);
      }
    }

    // print(sermons);
    //print(total[0]['contentType']);
    // print(total[0]['title']);

    if (this.mounted) {
      setState(() {
        _sermons = sermons;
        _videos = videos;
        _devotionals = devotionals;
        _total = total;
        print(_total);
        loaded = true;
      });
    }
  }

  @override
  void initState() {
    _searchPageController = TextEditingController();

    _searchPageFocus = FocusNode();

    fetchRecent();

    super.initState();
  }

  var ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: loaded == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                                      if (_searchPageController.text != '') {
                                        setState(
                                          () {
                                            _loading = true;
                                            search();
                                          },
                                        );
                                      }
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
                            ? _searchdone == false
                                ? _total.length > 0
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Recent',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GridView.count(
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 9.0,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    700,
                                            physics: ScrollPhysics(),
                                            children: <Widget>[
                                              for (var x = 0;
                                                  x < _total.length;
                                                  x++)
                                                '${_total[x]['contentType']}' ==
                                                        "devotional"
                                                    ? InkWell(
                                                        onTap: () {
                                                          _askedToLead(
                                                              _total[x][
                                                                  'contentType'],
                                                              _total[x]
                                                                  ['title'],
                                                              _total[x]['id'],
                                                              _total[x][
                                                                  'contentData']);
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16.0),
                                                          child: Card(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0.0),
                                                            ),
                                                            color: Colors.black,
                                                            child: Text(
                                                              '${_total[x]['contentData']}',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 18,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : '${_total[x]['contentType']}' ==
                                                            "sermon"
                                                        ? InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          AudioApp(
                                                                    details: _total[
                                                                            x][
                                                                        'title'],
                                                                    id: _total[
                                                                            x]
                                                                        ['id'],
                                                                    url: _total[
                                                                            x][
                                                                        'contentData'],
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .all(
                                                                      16.0),
                                                              child: Card(
                                                                  semanticContainer:
                                                                      true,
                                                                  color: Colors
                                                                      .white,
                                                                  elevation:
                                                                      5.0,
                                                                  child: Stack(
                                                                    children: [
                                                                      Column(
                                                                        children: [
                                                                          Spacer(),
                                                                          Container(
                                                                            width:
                                                                                500,
                                                                            color:
                                                                                Colors.white,
                                                                            child:
                                                                                FittedBox(
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Text(
                                                                                  '${_total[x]['title']}',
                                                                                  style: TextStyle(fontSize: 15),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 30.0),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.multitrack_audio,
                                                                            size:
                                                                                150,
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(bottom: 30.0),
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Icon(
                                                                            Icons.play_circle_fill_sharp,
                                                                            size:
                                                                                50,
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 8.0),
                                                            child: VideoTile(
                                                              details: _total[x]
                                                                  ['title'],
                                                              getting: true,
                                                              link:
                                                                  '${_total[x]['contentData']}',
                                                              id: _total[x]
                                                                  ['id'],
                                                            ),
                                                          )
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset(
                                              'images/events_unavailable.png'),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Find Sermons',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'SearchPage Sermons, Devotions, Bible, as you like',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                                      )
                                :found == true? SingleChildScrollView(
                                    child: GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 9.0,
                                      childAspectRatio:
                                          MediaQuery.of(context).size.height /
                                              700,
                                      physics: ScrollPhysics(),
                                      children: [
                                        for (var i = 0; i < results.length; i++)
                                          results[i] == 'sermon'
                                              ? Stack(children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              AudioApp(
                                                                  details:
                                                                      '${titleList[i]}',
                                                                  id: idList[i],
                                                                  url:
                                                                      '${_contentData[i]}'),
                                                        ),
                                                      );
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Card(
                                                        semanticContainer: true,
                                                        color: Colors.white,
                                                        elevation: 5.0,
                                                        child: Stack(
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Spacer(),
                                                                Container(
                                                                  width: 500,
                                                                  color: Colors
                                                                      .white,
                                                                  child:
                                                                      FittedBox(
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        '${titleList[i]}',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          30.0),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .multitrack_audio,
                                                                  size: 150,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          30.0),
                                                              child: Center(
                                                                child: Icon(
                                                                  Icons
                                                                      .play_circle_fill_sharp,
                                                                  size: 50,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ])
                                              : results[i] == 'video'
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0,
                                                              top: 5),
                                                      child: VideoTile(
                                                        getting: true,
                                                        id: idList[i],
                                                        details: titleList[i],
                                                        link:
                                                            '${_contentData[i]}',
                                                        height: 220,
                                                        width: 180,
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () {
                                                        _askedToLead(
                                                            _contentData[i],
                                                            titleList[i],
                                                            idList[i],
                                                            _contentData[i]);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          height: 180,
                                                          width:
                                                              double.infinity,
                                                          child: Card(
                                                            color: Colors.black,
                                                            semanticContainer:
                                                                true,
                                                            // color: Colors.grey,
                                                            elevation: 5.0,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 2.0,
                                                                      right:
                                                                          2.0),
                                                              child: Text(
                                                                _contentData[i],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                      ],
                                    ),
                                  ) :  Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'No Results Found',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 40),
                                          Image.asset(
                                              'images/events_unavailable.png'),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Find Sermons',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'SearchPage Sermons, Devotions, Bible, as you like',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                                      )
                            : CircularProgressIndicator()
                      )
                    else if (ind == 1)
                      SingleChildScrollView(
                        child: _loading == false
                            ? _searchdone == false
                                ? _total.length > 0
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Recent',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GridView.count(
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 9.0,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    700,
                                            physics: ScrollPhysics(),
                                            children: [
                                              for (var i = 0;
                                                  i < _sermons.length;
                                                  i++)
                                                Stack(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                AudioApp(
                                                                    details:
                                                                        '${_sermons[i]['title']}',
                                                                    id: _sermons[
                                                                            i]
                                                                        ['id'],
                                                                    url:
                                                                        '${_sermons[i]['contentData']}'),
                                                          ),
                                                        );
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Card(
                                                            semanticContainer:
                                                                true,
                                                            color: Colors.white,
                                                            elevation: 5.0,
                                                            child: Stack(
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Spacer(),
                                                                    Container(
                                                                      width:
                                                                          500,
                                                                      color: Colors
                                                                          .white,
                                                                      child:
                                                                          FittedBox(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Text(
                                                                            '${_sermons[i]['title']}',
                                                                            style:
                                                                                TextStyle(fontSize: 15),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          30.0),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .multitrack_audio,
                                                                      size: 150,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          30.0),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      Icons
                                                                          .play_circle_fill_sharp,
                                                                      size: 50,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset(
                                              'images/events_unavailable.png'),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Find Sermons',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'SearchPage Sermons, Devotions, Bible, as you like',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                                      )
                                : found == true
                                    ? SingleChildScrollView(
                                        child: GridView.count(
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 9.0,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  700,
                                          physics: ScrollPhysics(),
                                          children: [
                                            for (var i = 0;
                                                i < _searchedSermons.length;
                                                i++)
                                              Stack(children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => AudioApp(
                                                            details:
                                                                '${_searchedSermons[i]['title']}',
                                                            id: _searchedSermons[
                                                                i]['id'],
                                                            url:
                                                                '${_searchedSermons[i]['contentData']}'),
                                                      ),
                                                    );
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Card(
                                                      semanticContainer: true,
                                                      color: Colors.white,
                                                      elevation: 5.0,
                                                      child: Stack(
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Spacer(),
                                                              Container(
                                                                width: 500,
                                                                color: Colors
                                                                    .white,
                                                                child:
                                                                    FittedBox(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      '${_searchedSermons[i]['title']}',
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        30.0),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .multitrack_audio,
                                                                size: 150,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        30.0),
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .play_circle_fill_sharp,
                                                                size: 50,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ])
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'No Results Found',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 40),
                                          Image.asset(
                                              'images/events_unavailable.png'),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Find Sermons',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'SearchPage Sermons, Devotions, Bible, as you like',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                                      )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 30),
                                  CircularProgressIndicator(),
                                ],
                              ),
                      )
                    else if (ind == 2)
                      SingleChildScrollView(
                        child: _loading == false
                            ? _searchdone == false
                                ? _total.length > 0
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Recent',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GridView.count(
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 9.0,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    700,
                                            physics: ScrollPhysics(),
                                            children: [
                                              for (var i = 0;
                                                  i < _devotionals.length;
                                                  i++)
                                                Stack(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        _askedToLead(
                                                            _devotionals[i]
                                                                ['contentData'],
                                                            _devotionals[i]
                                                                ['title'],
                                                            _devotionals[i]
                                                                ['id'],
                                                            _devotionals[i][
                                                                'contentData']);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(16.0),
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          height: 180,
                                                          width:
                                                              double.infinity,
                                                          child: Card(
                                                            color: Colors.black,
                                                            semanticContainer:
                                                                true,
                                                            // color: Colors.grey,
                                                            elevation: 5.0,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 2.0,
                                                                      right:
                                                                          2.0),
                                                              child: Text(
                                                                _devotionals[i][
                                                                    'contentData'],
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset(
                                              'images/events_unavailable.png'),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Find Sermons',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'SearchPage Sermons, Devotions, Bible, as you like',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                                      )
                                : found == true
                                    ? SingleChildScrollView(
                                        child: GridView.count(
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 9.0,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  700,
                                          physics: ScrollPhysics(),
                                          children: [
                                            for (var i = 0;
                                                i < _searchedDevotionals.length;
                                                i++)
                                              Stack(children: [
                                                InkWell(
                                                  onTap: () {
                                                    _askedToLead(
                                                        _searchedDevotionals[i]
                                                            ['contentData'],
                                                        _searchedDevotionals[i]
                                                            ['title'],
                                                        _searchedDevotionals[i]
                                                            ['id'],
                                                        _searchedDevotionals[i]
                                                            ['contentData']);
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 5),
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
                                                                      .only(
                                                                  left: 2.0,
                                                                  right: 2.0),
                                                          child: Text(
                                                            _searchedDevotionals[
                                                                    i]
                                                                ['contentData'],
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
                                              ])
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'No Results Found',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 40),
                                          Image.asset(
                                              'images/events_unavailable.png'),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Find Sermons',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'SearchPage Sermons, Devotions, Bible, as you like',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                                      )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 30),
                                  CircularProgressIndicator(),
                                ],
                              ),
                      )
                    else if (ind == 3)
                      SingleChildScrollView(
                        child: _loading == false
                            ? _searchdone == false
                                ? _total.length > 0
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'Recent',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GridView.count(
                                            shrinkWrap: true,
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 4.0,
                                            mainAxisSpacing: 9.0,
                                            childAspectRatio:
                                                MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    700,
                                            physics: ScrollPhysics(),
                                            children: [
                                              for (var i = 0;
                                                  i < _videos.length;
                                                  i++)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0, top: 5),
                                                  child: Stack(
                                                    children: [
                                                      VideoTile(
                                                        getting: true,
                                                        id: _videos[i]['id'],
                                                        details: _videos[i]
                                                            ['title'],
                                                        link:
                                                            '${_videos[i]['contentData']}',
                                                        height: 220,
                                                        width: 180,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ],
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Image.asset(
                                              'images/events_unavailable.png'),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Find Sermons',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                'SearchPage Sermons, Devotions, Bible, as you like',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                                      )
                                : found == true
                                    ? SingleChildScrollView(
                                        child: GridView.count(
                                          shrinkWrap: true,
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 4.0,
                                          mainAxisSpacing: 9.0,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  700,
                                          physics: ScrollPhysics(),
                                          children: [
                                            for (var i = 0;
                                                i < _searchedVideos.length;
                                                i++)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, right: 8.0),
                                                child: Stack(
                                                  children: [
                                                    VideoTile(
                                                      getting: true,
                                                      id: _searchedVideos[i]
                                                          ['id'],
                                                      details:
                                                          _searchedVideos[i]
                                                              ['title'],
                                                      link:
                                                          '${_searchedVideos[i]['contentData']}',
                                                      height: 220,
                                                      width: 180,
                                                    ),
                                                  ],
                                                ),
                                              )
                                          ],
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          SizedBox(height: 20),
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'No Results Found',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 40),
                                          Image.asset(
                                              'images/events_unavailable.png'),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Find Sermons',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                'SearchPage Sermons, Devotions, Bible, as you like',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                        ], // https://www.youtube.com/watch?v=GEQGDJNPIbE
                                      )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 30),
                                  CircularProgressIndicator(),
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
