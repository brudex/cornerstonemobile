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
        'http://157.230.150.194:3000/uploads/sermons/SermonAudio%20-%20Media%20Player_2.mp3');
   
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
                child: _chewieAudioController != null && _chewieAudioController.videoPlayerController.value.isInitialized
                    ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(elevation: 5.0,
                                              child: ChewieAudio(
                            controller: _chewieAudioController,
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
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        if (_chewieAudioController != null) _chewieAudioController.dispose();
                        _videoPlayerController1.pause();
                        _videoPlayerController1.seekTo(const Duration());
                        _chewieAudioController = ChewieAudioController(
                          videoPlayerController: _videoPlayerController1,
                          autoPlay: true,
                          looping: true,
                        );
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Audio 1"),
                    ),
                  ),
                ),
               
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.android;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Android controls"),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.iOS;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("iOS controls"),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      
    );
  }
}