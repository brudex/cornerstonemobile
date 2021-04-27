import 'package:cornerstone/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Register extends StatefulWidget {
  @override
  State createState() => RegisterState();
}

class RegisterState extends State<Register> {
  TextEditingController _emailController,
      _pwController,
      _confirmpwController,
      _fNameController,
      _lNameController;
  FocusNode _emailFocus, _pwFocus, _confirmpwFocus, _fNameFocus, _lNameFocus;

  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureText2 = true;
  String _password;
  String _confirmpassword;
  String _email;
  String _fName;
  String _lName;

  // ignore: non_constant_identifier_names
  bool church_verify = true;
  // ignore: non_constant_identifier_names
  bool email_verify = true;
  // ignore: non_constant_identifier_names
  bool password_verify = true;
  // ignore: non_constant_identifier_names
  bool confirmPassword_verify = true;
  // ignore: non_constant_identifier_names
  bool fName_verify = true;
  // ignore: non_constant_identifier_names
  bool lName_verify = true;

  String _currentSelectedValue;
  int _currentSelectedId;

  bool churches_list_ready = false;

  var notReady = ["Loading ...."];
  var _churches = [];
  var _churches_id = [];



  Map<String, int> map = {
    "Roman": 1,
    "Presbyterian Church of Ghana": 2,
    "Christ Embassy": 3,
    "The Church of Pentecost": 4,
    "Church of Christ": 5,
    "ICGC": 6
  };
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
    return (_password?.length > 6);
  }

  bool isSamePassword() {
    if ((_confirmpassword == _password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidFirstName() {
    if ((_fName == null) || (_fName.length == 0) || (_fName != null)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidLastName() {
    if ((_lName == null) || (_lName.length == 0) || (_fName != null)) {
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
      _email = _emailController.text;
      _password = _pwController.text;
      _confirmpassword = _confirmpwController.text;
      _fName = _fNameController.text;
      _lName = _lNameController.text;
    });
  }

  void performRegister() {
    //Register here

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

    if (_fNameController.text == '') {
      setState(() {
        fName_verify = false;
      });
    } else {
      setState(() {
        fName_verify = true;
      });
    }

    if (_lNameController.text == '') {
      setState(() {
        lName_verify = false;
      });
    } else {
      setState(() {
        lName_verify = true;
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
    if (_currentSelectedValue == null) {
      setState(() {
        church_verify = false;
      });
    } else {
      setState(() {
        church_verify = true;
      });
    }

    if (password_verify == true &&
        email_verify == true &&
        confirmPassword_verify == true &&
        fName_verify == true &&
        lName_verify == true &&
        church_verify == true) {
      
      print('All is true');
      for (int i = 0; i < _churches.length; i++) {
        if (_currentSelectedValue == _churches[i]) {
           _currentSelectedId = _churches_id[i]['id'];
         // _currentSelectedId = int.parse(_churches_id[i]);
        }
      }
      showLoading(context);
       register();
      // print(map[_currentSelectedValue].toInt());
    }
  }

  Future register() async {
    var url = "http://157.230.150.194:3000/api/users/register";

    var data = {
      "firstName": "${_fNameController.text}",
      "lastName": "${_lNameController.text}",
      "email": "${_emailController.text}",
      "password": "${_pwController.text}",
      "churchId": "$_currentSelectedId",
    };

    var response = await http.post(Uri.parse(url), body: data);
    var message = jsonDecode(response.body);
    print(message);
    print(message['message']);
    print(message['status_code']);
    print(message['reason']);

    if (message['status_code'] == "00") {
      Navigator.pop(context);

      successAlertDialog(context, message['message'], 'Log In to Continue');
    } else {
      Navigator.pop(context);

      failedAlertDialog(context, message['message'], message['reason']);
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _confirmpwController = TextEditingController();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();

    _emailFocus = FocusNode();
    _pwFocus = FocusNode();
    _confirmpwFocus = FocusNode();
    _fNameFocus = FocusNode();
    _lNameFocus = FocusNode();
    super.initState();

    fetch();
  }

  Future fetch() async {
    final response =
        await http.get(Uri.parse('http://157.230.150.194:3000/api/churches'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(jsonDecode(response.body));
      var message = jsonDecode(response.body);

      print(message[1]);
      List churches_list = [];
      List churches_id = [];

      for (var item in message) {
        churches_list.add(item['name']);
      }

      for (var item in message) {
        churches_id.add(item);
      }

      print(churches_list);
      setState(() {
        _churches = churches_list;
        _churches_id = churches_id;
      });

      churches_list_ready = true;
      print('done');

      //return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Image.asset(
                    'images/logo 1.png',
                    scale: 2,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Create Account',
                          style: TextStyle(fontSize: 28.0, color: Colors.blue),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Enter information below or register with your social account to get started',
                      style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      textAlign: TextAlign.left,
                    ),
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
                          performRegister();
                        },
                        onTap: _validate,
                        decoration: InputDecoration(
                          labelText: "Password",
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
                          performRegister();
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 16),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10.0),
                      child: TextField(
                        focusNode: _fNameFocus,
                        controller: _fNameController,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (input) {
                          _fNameFocus.unfocus();
                          _fName = input;
                          performRegister();
                        },
                        onTap: _validate,
                        decoration: InputDecoration(
                          labelText: "First Name",
                          hintText: 'Enter your First Name',
                          errorText: isValidFirstName() && fName_verify
                              ? null
                              : "Invalid Name",
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
                        focusNode: _lNameFocus,
                        controller: _lNameController,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (input) {
                          _lNameFocus.unfocus();
                          _lName = input;
                          performRegister();
                        },
                        onTap: _validate,
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          hintText: 'Enter your Last Name',
                          errorText: isValidLastName() && lName_verify
                              ? null
                              : "Invalid Name",
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16.0, right: 16, bottom: 16),
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            errorText:
                                church_verify ? null : "Please select a church",
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 16),
                            hintText: 'Please select church',
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: churches_list_ready == false
                                  ? Text('Loading...')
                                  : Text('Select church'),
                              value: _currentSelectedValue,
                              isDense: true,
                              onChanged: churches_list_ready == false
                                  ? null
                                  : (String newValue) {
                                      setState(() {
                                        _currentSelectedValue = newValue;
                                        state.didChange(newValue);
                                      });
                                    },
                              items: _churches.map((dynamic value) {
                                return DropdownMenuItem<String>(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
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
                // ignore: deprecated_member_use
                child: FlatButton(
                  child: Text('Register',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () {
                    performRegister();
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
