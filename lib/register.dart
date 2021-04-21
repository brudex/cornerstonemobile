import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  State createState() => RegisterState();
}

class RegisterState extends State<Register> {
  TextEditingController _emailController,
      _pwController,
      _confirmpwController,
      _fullNameController;
  FocusNode _emailFocus, _pwFocus, _confirmpwFocus, _fullNameFocus;

  // Initially password is obscure
  bool _obscureText = true;
  bool _obscureText2 = true;
  String _password;
  String _confirmpassword;
  String _email;
  String _fullName;

  bool church_verify = true;
  bool email_verify = true;
  bool password_verify = true;
  bool confirmPassword_verify = true;
  bool fullName_verify = true;

  String _currentSelectedValue;

  var _churches = [
    "Christ Embassy",
    "The Church of Pentecost",
    "Church of Christ",
    "ICGC"
  ];

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
    return (_password?.length > 6);
  }

  bool isSamePassword() {
    if ((_confirmpassword == _password)) {
      return true;
    } else {
      return false;
    }
  }

  bool isValidFullName() {
    if ((_fullName == null) || (_fullName.length == 0)) {
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
      _fullName = _fullNameController.text;
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
    } else if (_pwController.text?.length <= 6) {
      setState(() {
        password_verify = false;
      });
    } else {
      setState(() {
        password_verify = true;
      });
    }

    if (_fullNameController.text == '') {
      setState(() {
        fullName_verify = false;
      });
    } else if (_fullNameController.text != '') {
      setState(() {
        fullName_verify = true;
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
    if(_currentSelectedValue == null){
      setState(() {
        church_verify = false;
      });
    }
    else{
       setState(() {
        church_verify = true;
      });
    }
    

    if (password_verify == true) {
      print('password = true');
    }
    if (email_verify == true) {
      print('email = true');
    }
    if (confirmPassword_verify == true) {
      print('confirm = true');
    }
    if (fullName_verify == true) {
      print('Full name = true');
      print(_currentSelectedValue);
    }
  }

  @override
  void initState() {
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _confirmpwController = TextEditingController();
    _fullNameController = TextEditingController();

    _emailFocus = FocusNode();
    _pwFocus = FocusNode();
    _confirmpwFocus = FocusNode();
    _fullNameFocus = FocusNode();
    super.initState();
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
                        focusNode: _fullNameFocus,
                        controller: _fullNameController,
                        obscureText: _obscureText,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (input) {
                          _fullNameFocus.unfocus();
                          _fullName = input;
                          performRegister();
                        },
                        onTap: _validate,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          hintText: 'Enter your Full Name',
                          errorText: isValidFullName() && fullName_verify
                              ? null
                              : "Invalid Name",
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
                    child: FormField<String>(
                      builder: (FormFieldState<String> state) {
                        return InputDecorator(
                          decoration: InputDecoration(
                            errorText: church_verify? null: "Please select a church",
                            errorStyle: TextStyle(
                                color: Colors.redAccent, fontSize: 16),
                            hintText: 'Please select church',
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text('Select church'),
                              value: _currentSelectedValue,
                              isDense: true,
                              onChanged: (String newValue) {
                                setState(() {
                                  _currentSelectedValue = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _churches.map((String value) {
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
