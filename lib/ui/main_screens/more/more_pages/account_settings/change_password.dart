import 'package:cornerstone/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';


class ChangePassword extends StatefulWidget {
  @override
  State createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  TextEditingController _pwController, _confirmpwController;

  FocusNode _pwFocus, _confirmpwFocus;

  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureText2 = true;
  String _password;
  String _confirmpassword;

  // ignore: non_constant_identifier_names
  bool password_verify = true;
  // ignore: non_constant_identifier_names
  bool confirmPassword_verify = true;

  bool isValidPassword() {
    if ((_password == null) || (_password.length == 0)) {
      return true;
    }
    // ignore: null_aware_before_operator
    return (_password?.length > 6);
  }

  bool isSamePassword() {
    if ((_confirmpassword == _password)) {
      return true;
    } else {
      return false;
    }
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggle2() {
    setState(() {
      _obscureText2 = !_obscureText2;
    });
  }

  void _validate() {
    setState(() {
      _password = _pwController.text;
      _confirmpassword = _confirmpwController.text;
    });
  }

  void performChangePassword() {
    //ChangePassword here

    if ((_pwController.text == null) || (_pwController.text == '')) {
      setState(() {
        password_verify = false;
      });
      // ignore: null_aware_before_operator
    } else if (_pwController.text?.length <= 6) {
      setState(() {
        password_verify = false;
      });
    } else {
      setState(() {
        password_verify = true;
      });
    }

    if (_confirmpwController.text != _pwController.text) {
      setState(() {
        confirmPassword_verify = false;
      });
    } else if (_confirmpwController.text == _pwController.text) {
      setState(() {
        confirmPassword_verify = true;
      });
    }

    if (password_verify == true && confirmPassword_verify == true) {
      print('All is true');

      showLoading(context);
      changePassword();
      // print(map[_currentSelectedValue].toInt());
    }
  }

  

  Future changePassword() async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = "${prefs.getString('token')}";
    var url = "http://157.230.150.194:3000/api/users/change_password";

    var data = {
      "password": "${_pwController.text}",
      "confirmPassword": "${_confirmpwController.text}",
    };

     var response = await http.post(
      Uri.parse(url),
      body: data,
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );
    var message = jsonDecode(response.body);
    print(message);
    print(message['message']);
    print(message['status_code']);
    print(message['reason']);

    
    if (message['status_code'] == "00") {
      Navigator.pop(context);

      failedAlertDialog(context,"Success", message['message']);
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  @override
  void initState() {
    _pwController = TextEditingController();
    _confirmpwController = TextEditingController();

    _pwFocus = FocusNode();
    _confirmpwFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(242, 245, 247, 1),
          title: Text(
            'Change Password',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                
               /*    Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Change Password',
                          style: TextStyle(fontSize: 28.0, color: Colors.blue),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ), */
                 
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 16),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        focusNode: _pwFocus,
                        controller: _pwController,
                        obscureText: _obscureText,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (input) {
                          _pwFocus.unfocus();
                          _password = input;
                          performChangePassword();
                        },
                        onTap: _validate,
                        decoration: InputDecoration(
                          labelText: "New Password",
                          hintText: 'Enter your password',
                          errorText: isValidPassword() && password_verify
                              ? null
                              : "Password too short.",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blue,
                            ),
                            onPressed: _toggle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 16),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        focusNode: _confirmpwFocus,
                        controller: _confirmpwController,
                        obscureText: _obscureText2,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (input) {
                          _confirmpwFocus.unfocus();
                          _confirmpassword = input;
                          performChangePassword();
                        },
                        onTap: _validate,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          hintText: 'Enter your password',
                          errorText: isSamePassword() && confirmPassword_verify
                              ? null
                              : "Passwords do not match",
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.blue,
                            ),
                            onPressed: _toggle2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
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
                  child: Text(' Change Password',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () {
                    performChangePassword();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
