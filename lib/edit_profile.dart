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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromRGBO(242, 245, 247, 1),
        title: Text(
          'Edit Profile',
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
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 25),
          Stack(
            children: [
              Center(
                child: Container(
                  width: 90,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        colorFilter:
                            ColorFilter.mode(Colors.black12, BlendMode.darken),
                        image: AssetImage('images/profile.png'),
                        fit: BoxFit.cover),
                  ),
                  child: Icon(Icons.camera_alt_outlined, color: Colors.blue,),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
              child: TextField(
                readOnly: true,
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
