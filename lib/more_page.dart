import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(242, 245, 247, 1),
      body: ListView(
        children: [
          SizedBox(height: 25, child: Container(color: Colors.white,),),
          Container( color: Colors.white,
            child: Center(
              child: Container(
                width: 90,
                height: 80,
                decoration: BoxDecoration(
                 
                  image: DecorationImage(
                     
                      image: AssetImage('images/profile.png'),
                      fit: BoxFit.cover),
                ),
                
              ),
            ),
          ),
          Container(color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('doe.jonathan@mail.com', style: TextStyle(fontSize: 18),),
              ),
            ),
          ),
           Container( 
             color: Colors.white,
             child: Center(child: Text('Edit Profile', style: TextStyle(color: Colors.blue),))),
          ListTile(
            leading: Icon(Icons.inbox, color: Colors.blue,),
            title: Text('Events'),
          ),
          ListTile(
            leading: Icon(Icons.person_outline_sharp, color: Colors.blue,),
            title: Text('Account Settings'),
          ), ListTile(
            leading: Icon(Icons.contact_phone_outlined, color: Colors.blue,),
            title: Text('Contact us'),
          ), ListTile(
            leading: Icon(Icons.menu_book_sharp, color: Colors.blue,),
            title: Text('The Bible'),
          ), ListTile(
            leading: Icon(Icons.history, color: Colors.blue,),
            title: Text('Donation History'),
          ),
           ListTile(
            leading: Icon(Icons.calendar_today_outlined, color: Colors.blue,),
            title: Text('Book Appointment'),
          ),
              ListTile(
           
            title: Text('Terms & Condition', style: TextStyle(color: Colors.grey),),
          ),
          ListTile(
           
            title: Text('Privacy & Policy',  style: TextStyle(color: Colors.grey),),
          ),
        ],
      ),
    );
  }
}