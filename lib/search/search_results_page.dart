import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  TextEditingController _SearchResultsPageController;
  FocusNode _SearchResultsPageFocus;

  // Initially password is obscure

  // ignore: unused_field
  String _SearchResultsPage;

  void performDonationHistory() {
    //DonationHistory here
  }

  @override
  void initState() {
    _SearchResultsPageController = TextEditingController();

    _SearchResultsPageFocus = FocusNode();

    super.initState();
  }

  var ind = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            color: Color.fromRGBO(242, 245, 247, 1),
            child: Column(
              children: [
                 SizedBox(
                  height: 40,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      focusNode: _SearchResultsPageFocus,
                      controller: _SearchResultsPageController,
                      obscureText: false,
                      textInputAction: TextInputAction.next,
                      onSubmitted: (input) {
                        _SearchResultsPage = input;
                      },
                      onTap: () {},
                      decoration: InputDecoration(
                        hintText: 'Law of Process',
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.blue,
                          ),
                          onPressed: () {},
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
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0, left: 8, bottom: 8),
                    child: Row(
                      children: [
                        Text('Showing result for  ‘Law of Process’', style: TextStyle(fontSize:16),),
                      ],
                    ),
                  ),
                  GridView.count(
                    primary: false,
                
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.0,
                    mainAxisSpacing: 4.0,
                    children: <Widget>[
                      VideoTile(
                    link:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                   height: 500,
                  ),
                        VideoTile(
                    link:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                    height: 500,
                  ),
                       VideoTile(
                    link:
                      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                    height: 500,
                  ),
                      
                    ],
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
    );
  }
}
