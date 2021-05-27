import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';


import 'dart:async';

class EventSuccess extends StatefulWidget {
  @override
  _EventSuccessState createState() => _EventSuccessState();
}

class _EventSuccessState extends State<EventSuccess> {
  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  var churchName;
  var title;
  var description;
  var venue;
  var date;
  var time;
  var image;
  List data = [];
  bool ready = false;

  Future fetchEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/events";
    var churchUrl = "http://157.230.150.194:3000/api/church";

    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final churchResponse = await http.get(
      Uri.parse(churchUrl),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final churchResponseJson = jsonDecode(churchResponse.body);
    print('$churchResponseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

    print(responseJson['data'].length);
    //print(responseJson['data'][0]);

    print(churchResponseJson["name"]);
    if (this.mounted) {
      setState(() {
        churchName = churchResponseJson["name"];
        ready = true;
        data = responseJson['data'];
      });
    }

    //var value = jsonDecode(message['data']);
    //print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text(
          'Events',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: ready == false
            ? Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(child: CircularProgressIndicator()),
              )
            : data.length != 0
                ? Column(
                    children: [
                      for (int i = 0; i < data.length; i++)
                        Card(
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    
                                    image: NetworkImage(
                                        "http://${data[i]['imageBanner']}", scale: 1),
                                    fit: BoxFit.cover),
                              ),
                            ),

                            /*    new Image.asset(
                                    "images/easter.png",
                                  ),
 */
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                '${data[i]['title']}',
                                style: new TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            subtitle: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: new Text(
                                      '${data[i]['description']}',
                                      style: new TextStyle(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text(
                                            '${data[i]['eventDate']}',
                                            style: new TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        //  Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text(
                                            '${data[i]['eventTime']}, ${data[i]['eventVenue']}',
                                            style: new TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                            //trailing: ,
                            onTap: () {},
                          ),
                        ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Color.fromRGBO(242, 245, 247, 1),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Image.asset('images/events_unavailable.png'),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'No Events Yet',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'All of $churchName\'s events will appear here ',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
      ),
    );
  }
}
