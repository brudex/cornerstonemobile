import 'package:flutter/material.dart';

class RedeemConfirmationScreen extends StatelessWidget {
  final String text;

  const RedeemConfirmationScreen({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
          0.85), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Center(child: Text(text)),
    );
  }
}
