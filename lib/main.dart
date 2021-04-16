import 'package:cornerstone/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
