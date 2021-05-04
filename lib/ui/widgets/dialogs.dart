import 'package:cornerstone/ui/main_screens/home_1.dart';
import 'package:cornerstone/access_pages/onboardingScreen.dart';
import 'package:flutter/material.dart';

showLoading(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: new Row(
      children: [
        CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          child: Text('  Loading'),
        ),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

/* showAlertDialog(BuildContext context, title, result) {
  Widget okButton = FlatButton(
    onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
        (Route<dynamic> route) => false,
      );
    },
    child: Text(
      'OK',
      style: TextStyle(color: darkBlue),
    ),
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      '$title',
      style: TextStyle(color: darkBlue),
    ),
    content: Text(
      '$result',
      style: TextStyle(color: darkBlue),
    ),
    actions: [okButton],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

signUpDialog(BuildContext context, title, result) {
  Widget okButton = FlatButton(
    onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => WelcomePage()),
        (Route<dynamic> route) => false,
      );
    },
    child: Text(
      'OK',
      style: TextStyle(color: darkBlue),
    ),
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      '$title',
      style: TextStyle(color: darkBlue),
    ),
    content: Text(
      '$result',
      style: TextStyle(color: darkBlue),
    ),
    actions: [okButton],
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

afterTransAlertDialog(BuildContext context, title, result) {
  Widget okButton = FlatButton(
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ContactSupport(),
        ),
      );
    },
    child: Text(
      'OK',
      style: TextStyle(color: darkBlue),
    ),
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      '$title',
      style: TextStyle(color: darkBlue),
    ),
    content: Text(
      '$result',
      style: TextStyle(color: darkBlue),
    ),
    actions: [okButton],
  );

  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


 */
failedAlertDialog(BuildContext context, title, result) {
  // ignore: deprecated_member_use
  Widget okButton = FlatButton(
    onPressed: () {
      Navigator.of(context).pop();
    },
    child: Text(
      'OK',
      style: TextStyle(color: Colors.blue),
    ),
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      '$title',
      style: TextStyle(color: Colors.blue),
    ),
    content: Text(
      '$result',
      style: TextStyle(color: Colors.blue),
    ),
    actions: [okButton],
  );

  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

successAlertDialog(BuildContext context, title, result) {
  // ignore: deprecated_member_use
  Widget okButton = FlatButton(
    onPressed: () {
      if (result == 'login successful') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Home1()),
          (Route<dynamic> route) => false,
        );
      }
      else if(title == 'Registration successful')
      {
         Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OnboardingScreen()),
          (Route<dynamic> route) => false,
        );
      }
    },
    child: Text(
      'OK',
      style: TextStyle(color: Colors.blue),
    ),
  );
  AlertDialog alert = AlertDialog(
    title: Text(
      '$title',
      style: TextStyle(color: Colors.blue),
    ),
    content: Text(
      '$result',
      style: TextStyle(color: Colors.blue),
    ),
    actions: [okButton],
  );

  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
