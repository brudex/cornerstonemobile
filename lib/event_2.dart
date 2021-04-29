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

  Future fetchEvents() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/events";
    var token = "${prefs.getString('token')}";
    

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

   
    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

   


    if (this.mounted) {
      
    }

    //var value = jsonDecode(message['data']);
    //print(value);
  }


  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color.fromRGBO(242, 245, 247, 1),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Events',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
          Card(
            child: ListTile(
              leading: new Image.asset(
                "images/easter.png",
              ),

              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  'Easter Convention',
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
                        'Easter Convention at the Light House chapel. Good Friday, Saturday , Easter Sunday and Easter Monday',
                        style: new TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            '28 Mar 2021',
                            style: new TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            '4:00 pm, Light House',
                            style: new TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ]),
              //trailing: ,
              onTap: () {},
            ),
          ),
          Card(
            child: ListTile(
              leading: new Image.asset(
                "images/festival.png",
              ),

              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Text(
                  'Praise Festival',
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
                        'Praise Festival at the National Theatre Live ...',
                        style: new TextStyle(
                            fontSize: 13.0, fontWeight: FontWeight.normal),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            '28 Mar 2021',
                            style: new TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Text(
                            '4:00 pm, Light House',
                            style: new TextStyle(
                                fontSize: 11.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ]),
              //trailing: ,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

