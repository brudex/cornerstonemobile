import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchPageController;
  FocusNode _searchPageFocus;

  // Initially password is obscure

  // ignore: unused_field
  String _searchPage;

  void performDonationHistory() {
    //DonationHistory here
  }

  Future search() async {
     final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, String> queryParameters = {
      'query': "${_searchPageController.text}"
    };
    var uri = Uri.http("157.230.150.194:3000","/api/churchcontent/search",queryParameters);
    var token = "${prefs.getString('token')}";

    final response = await http.get(
     uri,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    print(jsonDecode(response.body));
  }

  @override
  void initState() {
    _searchPageController = TextEditingController();

    _searchPageFocus = FocusNode();

    super.initState();
  }

  var ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
              child: Column(
          children: [
            Container(
              color: Color.fromRGBO(242, 245, 247, 1),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                 
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        focusNode: _searchPageFocus,
                        controller: _searchPageController,
                        obscureText: false,
                        textInputAction: TextInputAction.next,
                        onSubmitted: (input) {
                          _searchPage = input;
                        },
                        onTap: () {},
                        decoration: InputDecoration(
                          hintText: 'Search Page History',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              search();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  DefaultTabController(
                    length: 4,
                    child: TabBar(
                      labelColor: Colors.blue,
                      unselectedLabelColor: Colors.black,
                      onTap: (index) {
                        if (index == 1) {
                          ind = 1;
                          setState(() {});
                        } else if (index == 0) {
                          ind = 0;
                          setState(() {});
                        } else if (index == 2) {
                          ind = 2;
                          setState(() {});
                        } else if (index == 3) {
                          ind = 3;
                          setState(() {});
                        }
                      },
                      isScrollable: true,
                      tabs: <Widget>[
                        Tab(text: "All Results"),
                        Tab(text: "Sermons"),
                        Tab(text: "Devotions"),
                        Tab(text: "Bible"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (ind == 0)
              SingleChildScrollView(
                child: Column(
                 
                  children: [
                    SizedBox(height: 20),
                    Image.asset('images/events_unavailable.png'),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Find Sermons',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'SearchPage Sermons, Devotions, Bible, as you like',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else if (ind == 1)
              SingleChildScrollView(
                child: Text('1'),
              )
            else if (ind == 2)
              SingleChildScrollView(
                child: Text('2'),
              )
            else if (ind == 3)
              SingleChildScrollView(
                child: Text('3'),
              ),
          ],
        ),
      ),
    );
  }
}
