import 'package:flutter/material.dart';

class AccountSettings extends StatelessWidget {
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
                      'Account Settings',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
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
