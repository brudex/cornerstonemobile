import 'package:cornerstone/dialogs.dart';
import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';

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

  bool email_verify = true;
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
    return (_password?.length > 6);
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
    }  if (RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
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
    if ((_pwController.text == null) || (_pwController.text  == '')) {
     setState(() {
         password_verify = false;
     });
    
    }
    else if  (_pwController.text?.length <= 6){
      setState(() {
         password_verify = false;
      });

     
    }
    else{
       password_verify = true;
    }

    if(password_verify == true){
      print('password = true');
    }if(email_verify == true){
      print('email = true');
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Image.asset('images/Background.png'),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
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
                            'Login',
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
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Text(
                            'Forgot Password ?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
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
                  child: Text('Log in',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  onPressed: () {
                    performLogin();
                  },
                ),
              ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
