import 'dart:async';
import 'package:cornerstone/access_pages/onboardingScreen.dart';
import 'package:cornerstone/ui/main_screens/home_1.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() {
    return new SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 5);

    // First time

    return new Timer(_duration, navigationPageWel);
  }

  void navigationPageWel() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var userValid = prefs.getString('token');

    print(userValid);

    if (userValid != null) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home1()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('images/logo 1.png'),
      ),
    );
  }
}
