import 'package:cornerstone/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DonationSuccess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 35,
            ),
            
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'SUCCESS',
                  style: TextStyle(fontSize: 28.0),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Center(
              child: Icon(Icons.check_circle_outline_sharp, color: Colors.green[700], size: 150),
            ),
            SizedBox(height: 17,),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Donation Successful!',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            
            
          ],
        ),
      ),
    );
  }
}