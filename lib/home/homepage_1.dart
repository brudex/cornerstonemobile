import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';


class HomePage1 extends StatefulWidget {
  @override
  _HomePage1State createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 150,
                width: double.infinity,
                padding: EdgeInsets.only(left: 25.0, right: 25, top: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  "Zara of Thamar; and Phares begat Esrom; and Esrom begat Aram;\nAnd Aram begat Aminadab and aminadab begat Naasson; and",
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
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
                  VideoTile(
                    link:
                        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                    width: 270,
                  ),
                  VideoTile(
                    link:
                        'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4',
                    width: 270,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16, right: 16),
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
              padding: const EdgeInsets.only(right: 16.0),
              child: VideoTile(
                  link:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'),
            )
          ],
        ),
      ),
    );
  }
}
