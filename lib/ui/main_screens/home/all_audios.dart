import 'package:cornerstone/player_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AllAudios extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AllAudios(
      {this.title = 'Chewie Audio Demo',
      this.details,
      this.id,
      this.url,
      this.audios});

  final String title;
  final String details;
  final int id;
  final String url;
  final List audios;

  @override
  State<StatefulWidget> createState() {
    return _AllAudiosState();
  }
}

class _AllAudiosState extends State<AllAudios> {
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
          'All Audios',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: widget.audios.length > 0
          ? GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 9.0,
              childAspectRatio: MediaQuery.of(context).size.height / 700,
              physics: ScrollPhysics(),
              children: <Widget>[
                for (var x = 0; x < widget.audios.length; x++)
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AudioApp(
                            details: widget.audios[x]['title'],
                            id: widget.audios[x]['id'],
                            url: widget.audios[x]['contentData'],
                          ),
                        ),
                      );
                    },
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
                                color: Colors.white,
                                child: FittedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${widget.audios[x]['title']}',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Center(
                              child: Icon(
                                Icons.multitrack_audio,
                                size: 150,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Center(
                              child: Icon(
                                Icons.play_circle_fill_sharp,
                                size: 50,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
