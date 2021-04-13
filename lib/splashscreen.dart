import 'dart:async';

import 'package:flutter/material.dart';

import 'onboardingScreen.dart';

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

  void navigationPageWel() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => OnboardingScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset( 'images/logo 1.png'),
      ),
    );
  }
}
