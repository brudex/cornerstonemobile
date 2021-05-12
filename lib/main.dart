import 'package:cornerstone/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  /*  final SharedPreferences prefs = await SharedPreferences.getInstance();

  var fcmAlerts = prefs.getInt('alert'); */

  print('background message ${message.notification.body}');

  /* fcmAlerts++;
  prefs.setInt('alert', fcmAlerts); */
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging messaging;
  String notificationText;
  @override
  void initState() {
    super.initState();
    messaging = FirebaseMessaging.instance;
    messaging.subscribeToTopic("messaging");
    messaging.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      print("message recieved");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (this.mounted) {
        setState(() {
          var fcmAlerts = prefs.getInt('alert');

          fcmAlerts++;
          prefs.setInt('alert', fcmAlerts);
        });
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
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
