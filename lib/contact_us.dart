import 'package:flutter/material.dart';


class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text(
          'Contact us',
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
      body: ListView(
        children: [
          ListTile(
            subtitle: Text(
              '020 000 0000',
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            title: new Text(
              'Phone number',
              style: new TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ),
          ListTile(
            subtitle: Text(
              'Mon- Sat',
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            title: new Text(
              'Working hours',
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
            trailing: Text('8:00 am - 8:00 pm'),
          ),
          ListTile(
            title: new Text(
              'Sundays',
              style: new TextStyle(fontSize: 20.0, color: Colors.grey[600]),
            ),
            trailing: Text('6:00 am - 8:00 pm'),
          ),
          ListTile(
            subtitle: Text('christembassy@gmail.com'),
            title: new Text(
              'Email',
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          ListTile(
            subtitle: Text('www.christembassy.org'),
            title: new Text(
              'Website',
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          ListTile(
            subtitle: Text('Levites Avenue'),
            title: new Text(
              'Find us',
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Text('Social Media',),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                "images/facebook_logo.png",
              ),
              Image.asset(
                "images/instagram_logo.png",
              ),
              Image.asset(
                "images/twitter_logo.png",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
