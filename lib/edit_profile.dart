import 'package:cornerstone/widgets.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  @override
  State createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  TextEditingController _emailController, _passwordController, _fNameController;
  FocusNode _emailFocus, _passwordFocus;

  //

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // Initially password is obscure

  bool _obscureText = true;
  // ignore: unused_field
  String _email;
  // ignore: unused_field
  String _password;
  // ignore: unused_field
  String _fName;

  void performEditProfile() {
    //EditProfile here
  }

  // ignore: unused_element
  void _validate() {
    setState(() {
      _email = _emailController.text;
      _password = _passwordController.text;
      _fName = _fNameController.text;
    });
  }

  @override
  void initState() {
    _emailController = TextEditingController(text: 'jonathan@mail.com');
    _passwordController = TextEditingController(text: 'jonathan');
    _fNameController = TextEditingController(text: 'Jonathan Afari');

    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            color: Color.fromRGBO(242, 245, 247, 1),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'You are about to sow seed to the church. Enter details below to continue',
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                focusNode: _emailFocus,
                controller: _emailController,
                obscureText: false,
                textInputAction: TextInputAction.next,
                onSubmitted: (input) {
                  _email = input;
                },
                onTap: () {},
                decoration: InputDecoration(
                  labelText: 'Email',
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
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                focusNode: _passwordFocus,
                controller: _passwordController,
                obscureText: _obscureText,
                textInputAction: TextInputAction.next,
                onSubmitted: (input) {
                  _password = input;
                },
                onTap: () {},
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      _toggle();
                    },
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                readOnly: true,
                controller: _fNameController,
                onTap: () {},
                decoration: InputDecoration(
                  labelText: 'Full Name',
                ),
              ),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: StyledButton(
              title: 'Save',
            ),
          ),
        ],
      ),
    );
  }
}
