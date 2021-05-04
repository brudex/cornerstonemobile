import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/cupertino.dart';


class AudioTile extends StatefulWidget {
  final String url;

  const AudioTile({Key key, @required this.url}) : super(key: key);
  @override
  _AudioTileState createState() => _AudioTileState();
}

class _AudioTileState extends State<AudioTile> {
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
    _videoPlayerController1 = VideoPlayerController.network(widget.url);

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
    return Container(
      margin: EdgeInsets.only(top: 5),
      height: 200,
      width: double.infinity,
      child: Card(
        semanticContainer: true,
        color: Colors.grey,
        elevation: 5.0,
        child: _chewieAudioController != null &&
                _chewieAudioController.videoPlayerController.value.isInitialized
            ? Stack(
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
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Loading',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
      ),
    );
  }
}

class VideoTile extends StatefulWidget {
  final String link;
  final double width;
  final double height;

  const VideoTile({Key key, @required this.link, this.width, this.height})
      : super(key: key);
  @override
  _VideoTileState createState() => _VideoTileState();
}

class _VideoTileState extends State<VideoTile> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.link,
      //closedCaptionFile: _loadCaptions(),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 190,
      width: widget.width ?? double.infinity,
      padding: const EdgeInsets.only(top: 20, bottom: 20, right: 4, left: 16),
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(_controller),
            // ClosedCaption(text: _controller.value.caption.text),
            _ControlsOverlay(controller: _controller),
            VideoProgressIndicator(_controller, allowScrubbing: true),
          ],
        ),
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({Key key, @required this.controller})
      : super(key: key);

  // ignore: unused_field
  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_circle_fill_sharp,
                      color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
          onDoubleTap: () {
            controller.seekTo(Duration(seconds: 3));
          },
        ),
        //Increase speed
        /* Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ), */
      ],
    );
  }
}

class StyledButton extends StatelessWidget {
  final String title;

  const StyledButton({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 32, bottom: 5),
      decoration: BoxDecoration(
        //   color: Colors.blue,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xff4fc3f7), Color(0xff01579b)],
        ),
      ),
      width: 320,
      child: Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
    );
  }
}
