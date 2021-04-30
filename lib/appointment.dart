import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'dialogs.dart';

class Appointment extends StatefulWidget {
  final String title;

  const Appointment({Key key, this.title}) : super(key: key);
  @override
  _AppointmentState createState() => _AppointmentState();
}

bool _selected = false;

class _AppointmentState extends State<Appointment> {
  bool reasonVerify = true;

  bool isValidReason() {
    if ((reason == null) || (reason.length == 0) || (reason != null)) {
      return true;
    } else {
      return false;
    }
  }

  List availableTimes = [];
  List availableTimesID = [];
  List<Color> buttonColor = <Color>[];
  List<Color> textColor = <Color>[];

  var dateSelected;
  var selectedTime;
  var errorText;
  bool ready = false;
  bool pressed = false;
  @override
  void initState() {
    reasonController = TextEditingController();
    super.initState();
    //fetchAppointments();
  }

  void _validate() {
    setState(() {
      reason = reasonController.text;
    });
  }

  Future verify() async {
    if (reasonController.text == '') {
      setState(() {
        reasonVerify = false;
      });
    } else {
      setState(() {
        reasonVerify = true;
        print('Success');
        showLoading(context);
        setAppointment();
      });
    }
  }

  Future setAppointment() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = "${prefs.getString('token')}";
    var url = "http://157.230.150.194:3000/api/appointment/set";

    var data = {
      "appointmentTimeId": "$selectedTimeId",
      "appointmentReason": "${reasonController.text}",
    };

    var response = await http.post(
      Uri.parse(url),
      body: data,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    var message = jsonDecode(response.body);
    print(message);
    print(message['status_code']);

    if (message['status_code'] == "00") {
      //failedAlertDialog is for dialogs that pop without navigating to different pages
      Navigator.pop(context);
      failedAlertDialog(context, 'Success', message['message']);
    } else {
      Navigator.pop(context);
      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  Future fetchAppointments() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/appointment/$dateSelected";
    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);
    print('$responseJson' +
        'herrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrre  message 1 devotional');

    // print(responseJson['data'].length);

    if (this.mounted) {
      setState(() {
        availableTimes = [];
        availableTimesID = [];
        buttonColor = [];
        textColor = [];
        if (responseJson['status_code'] == '03') {
          errorText = responseJson['reason'];
        } else if (responseJson['status_code'] == '00') {
          errorText = null;
          for (var i = 0; i < responseJson['data'].length; i++) {
            // print(responseJson['data'][i]['appointmentTime']);
            availableTimes.add(responseJson['data'][i]['appointmentTime']);
            availableTimesID.add(responseJson['data'][i]['id']);
            buttonColor.add(Colors.transparent);
            textColor.add(Colors.black);
          }
          print(availableTimes);
          print(availableTimesID);
          print(buttonColor.length);
          ready = true;
          pressed = true;
        }
      });
    }

    //var value = jsonDecode(message['data']);
    //print(value);
  }

  TextEditingController reasonController;
  FocusNode reasonFocus;

  String reason;

  var selectedTimeId;
  bool tenAm = false;
  bool twelvePm = false;
  bool twoPm = false;
  bool fourPm = false;
  bool sixPm = false;

  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();

  DateTime _targetDateTime = DateTime.now();
//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];

  @override
  Widget build(BuildContext context) {
    final _calendarCarouselNoHeader = CalendarCarousel<Event>(
      weekdayTextStyle: TextStyle(color: Colors.black),
      onDayPressed: (date, events) {
        setState(() {
          this.setState(() => _currentDate2 = date);
          events.forEach((event) => print(event.title));
          var x = "$date";
          print(x.substring(0, x.length - 13));
          dateSelected = x.substring(0, x.length - 13);
          _selected = true;
          fetchAppointments();
        });
      },
      selectedDayButtonColor: Colors.blue,
      selectedDayBorderColor: Colors.blue,
      showOnlyCurrentMonthDate: false,
      weekendTextStyle: TextStyle(
        color: Colors.black,
      ),
      weekFormat: false,
      height: 420.0,
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      todayButtonColor: Colors.transparent,
      todayTextStyle: TextStyle(color: Colors.black),
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
    );

    return new Scaffold(
        appBar: new AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(242, 245, 247, 1),
          title: Text(
            'Book Appointment',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 16, right: 16, bottom: 8),
                child: Row(
                  children: [
                    Text(
                      'Select appointment day',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: _calendarCarouselNoHeader,
              ),
              _selected == true
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, left: 16),
                          child: Row(
                            children: [
                              Text('Available Times'),
                            ],
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color: Colors.white,
                              elevation: 5.0,
                              child: errorText != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text('$errorText'),
                                    )
                                  : availableTimes.length == 0 &&
                                          pressed == true
                                      ? Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                              'No appointments found for selected date'),
                                        )
                                      : ready == true &&
                                              availableTimes.length > 0 &&
                                              pressed == true
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Wrap(
                                                      alignment: WrapAlignment
                                                          .spaceBetween,
                                                      direction:
                                                          Axis.horizontal,
                                                      children: [
                                                        for (var a = 0;
                                                            a <
                                                                availableTimes
                                                                    .length;
                                                            a++)
                                                          InkWell(
                                                            onTap: () {
                                                              setState(() {
                                                                //Reset Colors onTap
                                                                buttonColor =
                                                                    [];
                                                                textColor = [];
                                                                for (var i = 0;
                                                                    i <
                                                                        availableTimes
                                                                            .length;
                                                                    i++) {
                                                                  buttonColor
                                                                      .add(Colors
                                                                          .transparent);
                                                                  textColor.add(
                                                                      Colors
                                                                          .black);
                                                                }
                                                                selectedTimeId =
                                                                    availableTimesID[
                                                                        a];
                                                                textColor[a] =
                                                                    Colors
                                                                        .white;
                                                                buttonColor[a] =
                                                                    Colors.blue;

                                                                selectedTime =
                                                                    availableTimes[
                                                                        a];

                                                                print(
                                                                    selectedTime);
                                                                print(
                                                                    selectedTimeId);
                                                              });
                                                            },
                                                            child: Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(8),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color:
                                                                      buttonColor[
                                                                          a],
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            8),
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    '${availableTimes[a]}',
                                                                    style: TextStyle(
                                                                        color: textColor[
                                                                            a]),
                                                                  ),
                                                                )),
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ])
                                          : SizedBox(),
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      focusNode: reasonFocus,
                      controller: reasonController,
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (input) {
                        reasonFocus.unfocus();
                        reason = input;
                        verify();
                      },
                      onTap: _validate,
                      decoration: InputDecoration(
                        hintText: 'Reason For Appointment',
                        errorText: isValidReason() && reasonVerify
                            ? null
                            : "Enter a Reason",
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
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
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text('Book appointment',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        if (selectedTime == null) {
                          failedAlertDialog(context, 'Error',
                              'Please select a Date and Time');
                        } else {
                          
                          verify();
                        }
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
