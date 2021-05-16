import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';



class DateUtil {
  static const DATE_FORMAT = 'dd/MM/yyyy';
  String formattedDate(DateTime dateTime) {
    print('dateTime ($dateTime)');
    return DateFormat(DATE_FORMAT).format(dateTime);
  }
}


class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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

    var url =
        "http://157.230.150.194:3000/api/notifications/getusernotifications";

    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

    if (this.mounted) {
      setState(() {
        data = responseJson['data'];
        ready = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text(
          'Notifications & Messages',
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
                            /* image == null
                                ?
                                : */
                            /*     Image.network(
                              "http://${data[i]['imageBanner']}",
                            ), */

                            /*    new Image.asset(
                                    "images/easter.png",
                                  ),
 */
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Text(
                                '${data[i]['body']}',
                                style: new TextStyle(
                                  fontSize: 18.0,
                                ),
                              ),
                            ),
                            subtitle: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                SizedBox(
                                  height: 20
                                ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text(
                                            '${data[i]['title']}',
                                            style: new TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        //  Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text(
                                            '${DateUtil().formattedDate(DateTime.parse(data[i]['createdAt']))}',
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
                                'No Notifications Yet',
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
                                'All of\'s events will appear here ',
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
