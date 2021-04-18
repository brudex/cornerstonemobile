import 'package:flutter/material.dart';

class AccountSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(242, 245, 247, 1),
          title: Text(
            'Account Settings',
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
      body: Column(
        children: [
         
          ListTile(
            

            title: new Text(
              'Notifications & Messages',
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
        
            trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blue ),
            onTap: () {},
          ),
         ListTile(
            

            title: new Text(
              'Change Password',
              style: new TextStyle(
                fontSize: 18.0,
              ),
            ),
        
            trailing: Icon(Icons.arrow_forward_ios_sharp, color: Colors.blue ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
