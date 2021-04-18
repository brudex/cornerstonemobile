import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:intl/intl.dart' show DateFormat;

class Appointment extends StatefulWidget {
  final String title;

  const Appointment({Key key, this.title}) : super(key: key);
  @override
  _AppointmentState createState() => _AppointmentState();
}
bool _selected = false;
class _AppointmentState extends State<Appointment> {
 TextEditingController reasonController;
  FocusNode reasonFocus;

  // ignore: unused_field
  String reason;

  bool eightAm = false;
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
        this.setState(() => _currentDate2 = date);
        events.forEach((event) => print(event.title));
        print(date);
        _selected = true;
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
                padding: const EdgeInsets.only(top: 8.0, left: 16,right: 16, bottom: 8 ),
                child: Row(children: [
                  Text('Select appointment day',style: TextStyle(fontSize: 18),),
                ],),
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
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                eightAm = !eightAm;
                                                tenAm = false;
                                                twelvePm = false;
                                                twoPm = false;
                                                fourPm = false;
                                                sixPm = false;
                                              });
                                            },
                                            child: Container(
                                                decoration: eightAm == true
                                                    ? BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                      )
                                                    : BoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '8:00 am',
                                                    style: TextStyle(
                                                        color: eightAm == true
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                eightAm = false;
                                                tenAm = !tenAm;
                                                twelvePm = false;
                                                twoPm = false;
                                                fourPm = false;
                                                sixPm = false;
                                              });
                                            },
                                            child: Container(
                                                decoration: tenAm == true
                                                    ? BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                      )
                                                    : BoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '10:00 am',
                                                    style: TextStyle(
                                                        color: tenAm == true
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                eightAm = false;
                                                tenAm = false;
                                                twelvePm = !twelvePm;
                                                twoPm = false;
                                                fourPm = false;
                                                sixPm = false;
                                              });
                                            },
                                            child: Container(
                                                decoration: twelvePm == true
                                                    ? BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                      )
                                                    : BoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '12:00 pm',
                                                    style: TextStyle(
                                                        color: twelvePm == true
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                eightAm = false;
                                                tenAm = false;
                                                twelvePm = false;
                                                twoPm = !twoPm;
                                                fourPm = false;
                                                sixPm = false;
                                              });
                                            },
                                            child: Container(
                                                decoration: twoPm == true
                                                    ? BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                      )
                                                    : BoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '2:00 pm',
                                                    style: TextStyle(
                                                        color: twoPm == true
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0, right: 12, bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                eightAm = false;
                                                tenAm = false;
                                                twelvePm = false;
                                                twoPm = false;
                                                fourPm = !fourPm;
                                                sixPm = false;
                                              });
                                            },
                                            child: Container(
                                                decoration: fourPm == true
                                                    ? BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                      )
                                                    : BoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '4:00 pm',
                                                    style: TextStyle(
                                                        color: fourPm == true
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                eightAm = false;
                                                tenAm = false;
                                                twelvePm = false;
                                                twoPm = false;
                                                fourPm = false;
                                                sixPm = !sixPm;
                                              });
                                            },
                                            child: Container(
                                                decoration: sixPm == true
                                                    ? BoxDecoration(
                                                        color: Colors.blue,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(8),
                                                        ),
                                                      )
                                                    : BoxDecoration(),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    '6:00 pm',
                                                    style: TextStyle(
                                                        color: sixPm == true
                                                            ? Colors.white
                                                            : Colors.black),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
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
                          reason = input;
                        },
                        onTap: () {},
                        decoration: InputDecoration(
                          hintText: 'Reason For Appointment',
                          
                        ),
                    ),
                  ),
                ),
                     ),
                Center(child: StyledButton(title: 'Book appointment'))
            ],
          ),
        ));
  }
}