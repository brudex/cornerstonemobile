import 'package:cornerstone/splashscreen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var fcmAlerts = 0;


class _MyAppState extends State<MyApp> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.configure(
      // ignore: missing_return
      onLaunch: (Map<String, dynamic> message) {
        print('onLaunch called');
      },
      // ignore: missing_return
      onResume: (Map<String, dynamic> message) {
        print('onResume called');
      },
      // ignore: missing_return
      onMessage: (Map<String, dynamic> message) {
        print('onMessage called sweet');

        setState(() {
          fcmAlerts++;
          increaseAlerts();
        });
      },
    );
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.requestNotificationPermissions(IosNotificationSettings(
      sound: true,
      badge: true,
      alert: true,
    ));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print('Hello');
    });
    _firebaseMessaging.getToken().then((token) {
      print(token); // Print the Token in Console
    });
  }

  Future increaseAlerts() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      prefs.setInt('alert', fcmAlerts);
    });
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage('images/logo 1.png'), context);
    precacheImage(AssetImage('images/stripe.png'), context);
    precacheImage(AssetImage('images/paypal.png'), context);
    precacheImage(AssetImage('images/easter.png'), context);
    precacheImage(AssetImage('images/Background.png'), context);
    precacheImage(AssetImage('images/events_unavailable.png'), context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cornerstone',

      /*   theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.amber,
      ), */
      routes: {
        '/': (context) => SplashScreen(),
      },
    );
  }
}
