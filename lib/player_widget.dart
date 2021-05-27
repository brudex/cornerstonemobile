import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:async';

import 'package:cornerstone/ui/widgets/dialogs.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

// ignore: must_be_immutable
class AudioApp extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
   AudioApp(
      {this.title = 'Chewie Audio Demo',this.fromList, this.details, this.id, this.url});

  final String title;
  final String details;
  final int id;
  final String url;
  bool fromList = false;

  @override
  State<StatefulWidget> createState() {
    return _AudioAppState();
  }
}

class _AudioAppState extends State<AudioApp> {
  Future addToPlaylist() async {
    showLoading(context);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = "${prefs.getString('token')}";
    var url = "http://157.230.150.194:3000/api/churchContent/playlist/add";

    var data = {
      "churchContentId": "${widget.id}",
      "title": "${widget.details}"
    };

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

      failedAlertDialog(context, "Success", message['message']);
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  // ignore: unused_field
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;

  ChewieAudioController _chewieAudioController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();

    _chewieAudioController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network("${widget.url}");

    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    if (this.mounted) {
      setState(() {
        _chewieAudioController = ChewieAudioController(
          videoPlayerController: _videoPlayerController1,
          autoPlay: false,
          looping: false,
          // Try playing around with some of these other options:

          // showControls: false,
          // materialProgressColors: ChewieProgressColors(
          //   playedColor: Colors.red,
          //   handleColor: Colors.blue,
          //   backgroundColor: Colors.grey,
          //   bufferedColor: Colors.lightGreen,
          // ),
          // placeholder: Container(
          //   color: Colors.grey,
          // ),
          // autoInitialize: true,
        );
      });
    }
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
          'Play Sermon',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: _chewieAudioController != null &&
                _chewieAudioController.videoPlayerController.value.isInitialized
            ? Column(
                children: [
                  Container(
                    height: 200,
                    child: Card(
                      semanticContainer: true,
                      color: Colors.grey,
                      elevation: 5.0,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Spacer(),
                              ChewieAudio(
                                controller: _chewieAudioController,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Center(
                              child: Icon(
                                Icons.multitrack_audio,
                                size: 100,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: FittedBox(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Title : ",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${widget.details}",
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  widget.fromList != true?
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          child: Row(
                            children: [
                              Icon(Icons.add),
                              Text("  Add To List"),
                            ],
                          ),
                          onPressed: () {
                            addToPlaylist();
                          },
                        ),
                      ],
                    ),
                  ) : SizedBox(),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Text('Loading'),
                ],
              ),
      ),
    );
  }
}
