import 'package:cornerstone/ui/main_screens/more/more_pages/account_settings.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/bible.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/contact_us.dart';
import 'package:cornerstone/ui/main_screens/donations/donation_history.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/edit_profile.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/event_2.dart';
import 'package:cornerstone/ui/main_screens/home/homepage_2.dart';
import 'package:cornerstone/ui/main_screens/home_1.dart';
import 'package:cornerstone/access_pages/login.dart';
import 'package:cornerstone/access_pages/onboardingScreen.dart';
import 'package:cornerstone/ui/main_screens/donations/donation_success_screen.dart';
import 'package:cornerstone/access_pages/register.dart';
import 'package:cornerstone/ui/main_screens/more/more_pages/terms.dart';

import 'package:flutter/material.dart';

import 'ui/main_screens/more/more_pages/appointment.dart';

import 'ui/main_screens/donations/donation.dart';


import 'list_empty_screen.dart';
import 'list_screen.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Index'),
      ),
      body: ListView(
        children: <Widget>[
          ExpansionTile(
            title: Text(
              'Access Screens',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text("Onboarding Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Login Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Register Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Register(),
                    ),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Donations Screens',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text("Donation Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Donation(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Donation Success Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationSuccess(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Donation History Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationHistory(),
                    ),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Event Screens',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text("Event Screen"),
                onTap: () {
                  /* Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Event1(),
                    ),
                  ); */
                },
              ),
              ListTile(
                title: Text("Event 2 Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventSuccess(),
                    ),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Account Screens',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text("Account Settings Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AccountSettings(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Edit Profile Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfile(),
                    ),
                  );
                },
              ),
             
            ],
          ),
          ExpansionTile(
            title: Text(
              'T&C Screen',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text("T&C Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Terms(),
                    ),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Bible',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
              ListTile(
                title: Text("Bible Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Bible(),
                    ),
                  );
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text(
              'Home',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
               ListTile(
                title: Text("Home Screen 1"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home1(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("HomePage Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage2(),
                    ),
                  );
                },
              ),
            ],
          ),
           ExpansionTile(
            title: Text(
              'Appointment',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
             /*   ListTile(
                title: Text("Image Picker"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageP(),
                    ),
                  );
                },
              ),
                 ListTile(
                title: Text("Video "),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VideoApp(),
                    ),
                  );
                },
              ), */  ListTile(
                title: Text("Appointment "),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Appointment(title: 'here',),
                    ),
                  );
                },
              ),
           
           
            ],
          ),
         
          ExpansionTile(
            title: Text(
              'Contact',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
               ListTile(
                title: Text("Contact Us"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ContactUs(),
                    ),
                  );
                },
              ),
          
           
            ],
          ),
             ExpansionTile(
            title: Text(
              'List',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
                 ListTile(
                title: Text("List Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListScreen(),
                    ),
                  );
                },
              ),
               ListTile(
                title: Text("My List Empty"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListEmptyScreen(),
                    ),
                  );
                },
              ),
          
           
            ],
          ),
        ],
      ),
    );
  }
}
