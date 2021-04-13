import 'package:cornerstone/login.dart';
import 'package:cornerstone/register.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Center(
                child: Image.asset('images/logo 1.png'),
              ),
              SizedBox(height: 50),
              Text(
                'Welcome to cornerstone',
                style: TextStyle(color: Colors.blue, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Free sermon streaming and donation app for your church',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(top: 32, bottom: 5),
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
                width: 320,
                child: FlatButton(
                  child: Text('Register',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 0, bottom: 0),
                decoration: BoxDecoration(
                  // shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                width: 320,
                child: FlatButton(
                  child: Text('Log in',
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              )
            ],
          )
        ],
      ),
    );
  }
}
