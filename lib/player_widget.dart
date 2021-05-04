import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AudioApp extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AudioApp({this.title = 'Chewie Audio Demo'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _AudioAppState();
  }
}

class _AudioAppState extends State<AudioApp> {
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
    _videoPlayerController1 = VideoPlayerController.network(
        "http://157.230.150.194:3000/uploads/sermons/SermonAudio%20-%20Media%20Player_2.mp3");

    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: _chewieAudioController != null &&
                      _chewieAudioController
                          .videoPlayerController.value.isInitialized
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
          ),
         
        ],
      ),
    );
  }
}
