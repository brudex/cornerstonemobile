import 'package:cornerstone/donation_history.dart';
import 'package:cornerstone/login.dart';
import 'package:cornerstone/onboardingScreen.dart';
import 'package:cornerstone/register.dart';
import 'package:cornerstone/donation_success_screen.dart';
import 'package:flutter/material.dart';

import 'donation.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Index'),
      ),
      body: ListView(
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
    );
  }
}
