import 'package:cornerstone/account_settings.dart';
import 'package:cornerstone/bible.dart';
import 'package:cornerstone/contact_us.dart';
import 'package:cornerstone/donations/donation_history.dart';
import 'package:cornerstone/edit_profile.dart';
import 'package:cornerstone/event_1.dart';
import 'package:cornerstone/event_2.dart';
import 'package:cornerstone/home/homepage_2.dart';
import 'package:cornerstone/home_1.dart';
import 'package:cornerstone/login.dart';
import 'package:cornerstone/more.dart';
import 'package:cornerstone/onboardingScreen.dart';
import 'package:cornerstone/register.dart';
import 'package:cornerstone/donations/donation_success_screen.dart';

import 'package:cornerstone/search_results_screen.dart';
import 'package:cornerstone/search_screen.dart';
import 'package:cornerstone/terms.dart';
import 'package:cornerstone/video.dart';
import 'package:flutter/material.dart';

import 'appointment.dart';

import 'donations/donation.dart';
import 'home_2.dart';
import 'image_picker.dart';
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Event1(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text("Event 2 Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Event2(),
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
               ListTile(
                title: Text("More Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => More(),
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
                title: Text("Home Screen 2"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home2(),
                    ),
                  );
                },
              ),ListTile(
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
              'Search',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
            ),
            children: <Widget>[
               ListTile(
                title: Text("Search Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Search(),
                    ),
                  );
                },
              ),
             ListTile(
                title: Text("Search Results Screen"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchResults(),
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
