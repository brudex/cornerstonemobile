import 'package:cornerstone/list/list_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoDetail extends StatefulWidget {
  final String backgroundImage;
  final String videoUrl;

  const VideoDetail({Key key, @required this.backgroundImage, @required this.videoUrl})
      : super(key: key);
  @override
  _VideoDetailState createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  @override
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(widget.backgroundImage),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, shadowColor: Colors.transparent),
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.67,
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  color: Colors.transparent,
                  child: BottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(20.0),
                          topRight: const Radius.circular(20.0),
                        ),
                      ),
                      elevation: 10,
                      backgroundColor: Colors.white,
                      onClosing: () {
                        // Do something
                      },
                      builder: (BuildContext ctx) => Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.67,
                            alignment: Alignment.center,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 13.0, right: 13),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "The Law of Process",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("1h 29m"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("• Video Sermon"),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 12, bottom: 5),
                                    decoration: BoxDecoration(
                                      //   color: Colors.blue,
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xff4fc3f7),
                                          Color(0xff01579b)
                                        ],
                                      ),
                                    ),
                                    //width: 320,
                                    height: 40,
                                    // ignore: deprecated_member_use
                                    child: FlatButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.play_arrow_outlined,
                                            color: Colors.white,
                                          ),
                                          Text(' Play',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      onPressed: () {
                                        launch(widget.videoUrl);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        OutlinedButton(
                                          child: Row(
                                            children: [
                                              Icon(
                                                  Icons.bookmark_outline_sharp),
                                              Text("  My Lists"),
                                            ],
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ListPage(),
                                              ),
                                            );
                                          },
                                        ),
                                        OutlinedButton(
                                          child: Row(
                                            children: [
                                              Icon(Icons.share_sharp),
                                              Text("  Share"),
                                            ],
                                          ),
                                          onPressed: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                      "In this video sermon, Pastor Chris shares with us the Law of Process of life"),
                                  Spacer(),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'By: Pastor Chris Oyakhilome',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                    ],
                                  )
                                  /*   ElevatedButton(
                                    child: Text(
                                      'Close this bottom sheet',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {
                                      setState(() {});
                                    },
                                  ), */
                                ],
                              ),
                            ),
                          )),
                )),
          ),
        ),
        /*  Positioned(
            bottom: MediaQuery.of(context).size.height * 0.58,
            left: MediaQuery.of(context).size.width * 0.4,
            child: Container(
                height: 100,
                width: 70,
                child: Image.network(
                  widget.image,
                  height: 100,
                  width: 70,
                ))) */
      ],
    );
  }
}
