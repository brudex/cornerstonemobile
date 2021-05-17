import 'package:cornerstone/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DonationFailure extends StatelessWidget {
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
                  'FAILURE',
                  style: TextStyle(fontSize: 28.0),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Center(
              child: Icon(Icons.cancel_sharp, color: Colors.red[700], size: 150),
            ),
            SizedBox(height: 17,),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Sorry! We could not process your payment. Please try again later',
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