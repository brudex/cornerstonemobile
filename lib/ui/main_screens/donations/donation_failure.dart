
import 'package:cornerstone/ui/main_screens/donations/donation_history.dart';
import 'package:cornerstone/ui/main_screens/home_1.dart';
import 'package:flutter/material.dart';

class DonationFailure extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: () async => false,
          child: Scaffold(
       
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
              SizedBox(height: 30),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 250,
                  margin: EdgeInsets.only(top: 12, bottom: 5),
                  decoration: BoxDecoration(
                    //   color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xff4fc3f7), Color(0xff01579b)],
                    ),
                  ),
                  //width: 320,
                  height: 40,
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    child: Text(' Okay',
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DonationHistory(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              
       
             
            ],
          ),
        ),
      ),
    );
  }
}