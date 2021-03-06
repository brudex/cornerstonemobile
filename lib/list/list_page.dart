import 'package:cornerstone/player_widget.dart';
import 'package:cornerstone/ui/main_screens/home/playsingle.dart';
import 'package:cornerstone/ui/widgets/dialogs.dart';
import 'package:cornerstone/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  List _contentData = [];
  // ignore: unused_field
  List _youtubeUrls = [];
  List _titles = [];
  bool loading = true;
  List _dataTypes = [];
  List _ids = [];

  Future<void> _askedToLead(String quote, String title) async {
    switch (await showDialog<ListPage>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.all(10),
            title: Text('$title'),
            children: <Widget>[
              SimpleDialogOption(
                // onPressed: () { Navigator.pop(context, Department.treasury); },
                child: Text(
                  '$quote',
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

  // ignore: unused_element
  Future<void> _playaudio(String url, String title) async {
    switch (await showDialog<ListPage>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            insetPadding: EdgeInsets.all(10),
            title: Text('$title'),
            children: <Widget>[
              AudioTile(url: 'http://157.230.150.194:3000/uploads/sermons/$url')
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
    fetchUserPlaylist();
  }

  Future deletePlayList(id) async {
    showLoading(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/playlist/delete";

    var token = "${prefs.getString('token')}";

    var data = {"churchContentId": "$id"};

    var response = await http.post(
      Uri.parse(url),
      body: data,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    print(jsonDecode(response.body));

    var message = jsonDecode(response.body);
    print(message);
    print(message['message']);
    print(message['status_code']);

    if (message['status'] == "00") {
      Navigator.pop(context);

      failedAlertDialog(context, "Success", message['message']);
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  Future fetchUserPlaylist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/users/getUserplaylist";

    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');
    List dataTypes = [];
    List youtubeUrls = [];
    List contentData = [];
    List titles = [];
    List ids = [];

    for (var item in responseJson['data']) {
      contentData.add(item['contentData']);
      dataTypes.add(item['contentType']);
      titles.add(item['title']);
      ids.add(item['id']);
      if (item['contentType'] == "video") {
        youtubeUrls.add(YoutubePlayer.convertUrlToId(item['contentData']));
      }
    }

    setState(() {
      /* print(titles);
      print(dataTypes);
      print(contentData);
      print(youtubeUrls); */
      print(ids);
      _youtubeUrls = youtubeUrls;
      _ids = ids;
      _contentData = contentData;
      _titles = titles;
      loading = false;
      _dataTypes = dataTypes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text(
          'My List',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: loading == true
          ? Center(child: CircularProgressIndicator())
          : _dataTypes.length != 0
              ? ListView(
                  children: [
                    /*  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15.0, left: 15, right: 15, bottom: 10),
                        child: Text(
                          'Today',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                    ],
                  ), */
                    for (var i = 0; i < _titles.length; i++)
                      _dataTypes[i] == "video"
                          ? ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlaySingle(
                                      clips: null,
                                      playlistLink: _contentData[i],
                                      details: _titles[i],
                                      id: _ids[i],
                                    ),
                                  ),
                                );
                              },
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.video_library_outlined,
                                  size: 50,
                                  color: Colors.black,
                                ),
                              ),
                              title: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    Text("${_titles[i]}"),
                                  ],
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Text(
                                  'Video',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                              trailing: PopupMenuButton(
                                icon: Icon(
                                  Icons.more_vert_sharp,
                                  color: Colors.black,
                                ),
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem(
                                      child: InkWell(
                                        onTap: () {
                                          print(_ids[i]);
                                          deletePlayList(_ids[i]);
                                        },
                                        splashColor:
                                            Colors.grey, // splash color
                                        child: Row(children: [
                                          Text('Delete'),
                                          Spacer(),
                                          Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            )
                          : _dataTypes[i] == "devotional"
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: ListTile(
                                    onTap: () {
                                      _askedToLead(_contentData[i], _titles[i]);
                                    },
                                    leading: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.library_books_outlined,
                                        size: 50,
                                        color: Colors.black,
                                      ),
                                    ),
                                    title: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text("${_titles[i]}"),
                                        ],
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Text(
                                        'Devotional Text',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    trailing: PopupMenuButton(
                                      icon: Icon(
                                        Icons.more_vert_sharp,
                                        color: Colors.black,
                                      ),
                                      itemBuilder: (BuildContext context) {
                                        return [
                                          PopupMenuItem(
                                            child: InkWell(
                                              onTap: () {
                                                print(_ids[i]);
                                                deletePlayList(_ids[i]);
                                              },
                                              splashColor:
                                                  Colors.grey, // splash color
                                              child: Row(children: [
                                                Text('Delete'),
                                                Spacer(),
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ),
                                )
                              : ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AudioApp(
                                            details: _titles[i],
                                            id: _ids[i],
                                            url: _contentData[i]),
                                      ),
                                    );
                                  },
                                  leading: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.audiotrack,
                                      color: Colors.black,
                                      size: 50,
                                    ),
                                  ),
                                  title: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text("${_titles[i]}"),
                                      ],
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      'Audio',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                  ),
                                  trailing: PopupMenuButton(
                                    icon: Icon(
                                      Icons.more_vert_sharp,
                                      color: Colors.black,
                                    ),
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          child: InkWell(
                                            onTap: () {
                                              print(_ids[i]);
                                              deletePlayList(_ids[i]);
                                            },
                                            splashColor:
                                                Colors.grey, // splash color
                                            child: Row(children: [
                                              Text('Delete'),
                                              Spacer(),
                                              Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ]),
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                                ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(height: 70),
                    Container(
                      child: Center(
                        child: SvgPicture.asset('images/empty.svg'),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Nothing here',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        )),
                  ],
                ),
    );
  }
}
