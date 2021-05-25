import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

class DonationHistory extends StatefulWidget {
  @override
  State createState() => DonationHistoryState();
}

class DonationHistoryState extends State<DonationHistory> {
  TextEditingController _searchController;
  FocusNode _searchFocus;
  List _statusMessage = [];
  List _donationType = [];
  List _amount = [];
  List _paymentMode = [];
  bool ready = false;
  List _date = [];
  List solns = [];
  String _convertDateToday;
  String _convertDateYesterday;

  // Initially password is obscure

  // ignore: unused_field
  String _search;

  void performDonationHistory() {
    //DonationHistory here
  }

  @override
  void initState() {
    _searchController = TextEditingController();

    _searchFocus = FocusNode();
    fetchHistory();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future fetchHistory() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/donationhistory";

    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    var ans = jsonDecode(response.body);

    //print(ans);

    print(ans['data']);

    // print(soln.length);
    List statusMessage = [];
    List donationType = [];
    List amount = [];
    List paymentMode = [];
    List dateCreated = [];
    Iterable some = ans['data'].reversed;

    var soln = some.toList();

    if (soln != null) {
      for (var i = 0; i < soln.length; i++) {
        statusMessage.add(soln[i]['statusMessage']);
        donationType.add(soln[i]['donationType']);
        amount.add(soln[i]['amount']);
        paymentMode.add(soln[i]['paymentMode']);
        dateCreated.add(soln[i]['createdAt']);
      }
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final f = new DateFormat('MMM d, yyyy');
    //print(f.format(DateTime.now()));
    var convertDateToday = f.format(today).toString();
    var convertDateYesterday = f.format(yesterday).toString();

    print(today);
    print(yesterday);

    setState(() {
      solns = soln;
      _statusMessage = statusMessage;
      _donationType = donationType;
      _amount = amount;
      _paymentMode = paymentMode;
      _date = dateCreated;
      _convertDateToday = convertDateToday;
      _convertDateYesterday = convertDateYesterday;
      ready = true;
    });

    //  print(statusMessage);
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
          'Donation History',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: ready == false
              ? Center(child: CircularProgressIndicator())
              : GroupedListView<dynamic, String>(
                  sort: false,
                  //reverse: true,
                  elements: solns,
                  groupBy: (element) =>
                      element['createdAt'] == _convertDateToday
                          ? "Today"
                          : element['createdAt'] == _convertDateYesterday
                              ? "Yesterday"
                              : element['createdAt'],
                  groupComparator: (value1, value2) => value2.compareTo(value1),
                  itemComparator: (item1, item2) =>
                      item1['pageId'].compareTo(item2['pageId']),
                  order: GroupedListOrder.DESC,
                  // useStickyGroupSeparators: true,
                  groupSeparatorBuilder: (String value) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      value,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  itemBuilder: (c, element) {
                    return Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          //leading: Icon(Icons.account_circle),
                          title: Text(
                            element['amount'],
                            style: TextStyle(fontSize: 16),
                          ),
                          leading: element['paymentMode'] == 'Visa, Mastercard & More'
                              ? Image.asset('images/visa2.png')
                              : element['paymentMode'] == 'stripe'
                                  ? Image.asset('images/visa2.png')
                                  : Image.asset('images/paypal.png'),
                          subtitle: Text(element['donationType']),
                          trailing: Text(element['statusMessage'],
                              style: TextStyle(
                                  color: element['statusMessage']
                                              .toString()
                                              .toLowerCase() ==
                                          'success'
                                      ? Colors.green
                                      : element['statusMessage']
                                                  .toString()
                                                  .toLowerCase() ==
                                              'pending'
                                          ? Colors.grey
                                          : Colors.red)),
                        ),
                      ),
                    );
                  },
                )),
    );
  }
}
