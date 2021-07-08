import 'package:cornerstone/access_pages/forgot_password.dart';
import 'package:cornerstone/ui/widgets/dialogs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../ui/main_screens/home_1.dart';

class Login extends StatefulWidget {
  @override
  State createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController _emailController, _pwController;
  FocusNode _emailFocus, _pwFocus;

  // Initially password is obscure
  bool _obscureText = true;
  String _password;
  String _email;

  // ignore: non_constant_identifier_names
  bool email_verify = true;
  // ignore: non_constant_identifier_names
  bool password_verify = true;

  bool isValidEmail() {
    if ((_email == null) || (_email.length == 0)) {
      return true;
    }
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
  }

  bool isValidPassword() {
    if ((_password == null) || (_password.length == 0)) {
      return true;
    }
    // ignore: null_aware_before_operator
    return (_password?.length > 2);
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _validate() {
    setState(() {
      _email = _emailController.text;
      _password = _pwController.text;
    });
  }

  void performLogin() {
    //login here
    if ((_emailController.text == null) || (_emailController.text == '')) {
      setState(() {
        email_verify = false;
      });
    }
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(_emailController.text) ==
        false) {
      setState(() {
        email_verify = false;
      });
    } else {
      setState(() {
        email_verify = true;
      });
    }
    if ((_pwController.text == null) || (_pwController.text == '')) {
      setState(() {
        password_verify = false;
      });
    }
    // ignore: null_aware_before_operator
    else if (_pwController.text?.length <= 2) {
      setState(() {
        password_verify = false;
      });
    } else {
      password_verify = true;
    }

    if (password_verify == true && email_verify == true) {
      showLoading(context);
      print('password = true');
      print('email = true');
      login();
    }
  }

  Future login() async {
    var url = "http://157.230.150.194:3000/api/users/login";

    var data = {
      "email": "${_emailController.text}",
      "password": "${_pwController.text}",
    };

    var response = await http.post(Uri.parse(url), body: data);
    var message = jsonDecode(response.body);
    print(message);
    print(message['message']);
    print(message['status_code']);
    print(message['reason']);

    if (message['status_code'] == "00") {
      Navigator.pop(context);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', message['token']);
      prefs.setInt('alert', 0);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home1()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _emailFocus = FocusNode();
    _pwFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(Colors.white54, BlendMode.lighten),
                  image: AssetImage('images/Background.jpg'),
                  fit: BoxFit.cover,
                ),
                //   color: Colors.blue,
                shape: BoxShape.rectangle,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        'images/logo 1.png',
                        scale: 2,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              'User Login',
                              style:
                                  TextStyle(fontSize: 28.0, color: Colors.blue),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10.0),
                          child: TextField(
                            // focusNode: _emailFocus,
                            controller: _emailController,
                            obscureText: false,
                            keyboardType: TextInputType
                                .emailAddress, //show email keyboard
                            textInputAction: TextInputAction.next,
                            onSubmitted: (input) {
                              _emailFocus.unfocus();
                              _email = input;
                              FocusScope.of(context).requestFocus(_pwFocus);
                            },
                            onTap: _validate,
                            decoration: InputDecoration(
                              labelText: "Email",
                              hintText: 'Enter your Email',
                              errorText: isValidEmail() && email_verify
                                  ? null
                                  : "Invalid Email Address",
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.mail_outline,
                                  color: Colors.blue,
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
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
                              // performLogin();
                            },
                            onTap: _validate,
                            decoration: InputDecoration(
                              labelText: "Password",
                              hintText: 'Enter your password',
                              errorText: isValidPassword() && password_verify
                                  ? null
                                  : "Invalid Password",
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
                      ButtonBar(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Text(
                                'Forgot Password ?',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 32, bottom: 5),
                        decoration: BoxDecoration(
                          color: Colors.blue,
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
                        // ignore: deprecated_member_use
                        child: FlatButton(
                          child: Text('Log in',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)),
                          onPressed: () {
                            performLogin();
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
