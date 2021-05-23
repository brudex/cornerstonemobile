
import 'package:cornerstone/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class ForgotPassword extends StatefulWidget {
  @override
  State createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _emailController;
  FocusNode _emailFocus;

  // Initially password is obscure
  
  String _email;
 
  // ignore: non_constant_identifier_names
  bool email_verify = true;
 

  bool isValidEmail() {
    if ((_email == null) || (_email.length == 0)) {
      return true;
    }
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(_email);
  }

  void _validate() {
    setState(() {
      _email = _emailController.text;
     
    });
  }

  void performForgotPassword() {
    //ForgotPassword here

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
   
    if (
        email_verify == true ) {
          showLoading(context);
      print('All is true');
    forgotPassword();
    // print(map[_currentSelectedValue].toInt());
    }
  }

  Future forgotPassword() async {
    var url = "http://157.230.150.194:3000/api/users/forgotten_password";

    var data = {
     'email': "${_emailController.text}"
    };

    var response = await http.post(Uri.parse(url), body: data);
    var message = jsonDecode(response.body);
    print(message);
    print(message['message']);
    print(message['status_code']);
    print(message['reason']);

    if (message['status_code'] == "00") {
      Navigator.pop(context);

     failedAlertDialog(context, "Success",  message['message']);
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
   

    _emailFocus = FocusNode();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(242, 245, 247, 1),
          title: Text(
            'Forgot password',
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
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'images/logo 1.png',
                  scale: 2,
                ),
                SizedBox(
                  height: 20
                ),
              
              
                  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Forgot Password',
                            style:
                                TextStyle(fontSize: 26.0, color: Colors.blue),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),

                     SizedBox(
                  height: 20
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, bottom: 16),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextField(
                      focusNode: _emailFocus,
                      controller: _emailController,
                      obscureText: false,
                      keyboardType:
                          TextInputType.emailAddress, //show email keyboard
                      textInputAction: TextInputAction.next,
                      onSubmitted: (input) {
                        _emailFocus.unfocus();
                        _email = input;
                        FocusScope.of(context).requestFocus(_emailFocus);
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
                ),  Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Please enter the email used in creating the account',
                    style: TextStyle(fontSize: 15.0, color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                ),
               
              ],
            ),
            Spacer(),
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
              // ignore: deprecated_member_use
              child: FlatButton(
                child: Text('Reset Password',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  performForgotPassword();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
