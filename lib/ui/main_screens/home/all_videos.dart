import 'package:cornerstone/ui/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllVideos extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AllVideos(
      {this.title = 'Chewie Audio Demo',
      this.details,
      this.id,
      this.url,
      this.videos});

  final String title;
  final String details;
  final int id;
  final String url;
  final List videos;

  @override
  State<StatefulWidget> createState() {
    return _AllVideosState();
  }
}

class _AllVideosState extends State<AllVideos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          'All videos',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: widget.videos.length > 0
          ? GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 9.0,
              childAspectRatio: MediaQuery.of(context).size.height / 700,
              physics: ScrollPhysics(),
              children: <Widget>[
                for (var x = 0; x < widget.videos.length; x++)
                  VideoTile(
                    details: widget.videos[x]['title'],
                    getting: true,
                    link: '${widget.videos[x]['contentData']}',
                  )
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
