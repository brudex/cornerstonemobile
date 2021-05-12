import 'package:cornerstone/ui/widgets/dialogs.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart' as dio;
import 'dart:async';

import 'package:path/path.dart' as Path;

import 'package:http_parser/http_parser.dart';

class EditProfile extends StatefulWidget {
  final String email;
  final String fname;
  final String lname;

  const EditProfile({Key key, @required this.email, this.fname, this.lname})
      : super(key: key);

  @override
  State createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  //var dio = Dio();

  var initFName;
  var changePicture;
  var initLName;
  File _image;
  final picker = ImagePicker();
  bool fNameVerify = true;
  bool lNameVerify = true;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  TextEditingController _emailController, _lNameController, _fNameController;
  // ignore: unused_field
  FocusNode _emailFocus, _passwordFocus;

  //

  // Initially password is obscure

  bool _obscureText = true;
  // ignore: unused_field
  String _email;
  // ignore: unused_field
  String _lName;
  // ignore: unused_field
  String _fName;

  Future changePic() async {
    //EditProfile here

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = "http://157.230.150.194:3000/api/users/upload_profile_picture";

    var data = {
      'user-image': _image != null ? 'data:${_image.path}' : '',
    };

    var token = "${prefs.getString('token')}";

    try {
      ///[1] CREATING INSTANCE
      var dioRequest = dio.Dio();
      dioRequest.options.baseUrl = '$url';

      //[2] ADDING TOKEN
      dioRequest.options.headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      //[3] ADDING EXTRA INFO
      var formData = new dio.FormData.fromMap({'': ''});

      //[4] ADD IMAGE TO UPLOAD
      var file = await dio.MultipartFile.fromFile(_image.path,
          filename: Path.basename(_image.path),
          contentType: MediaType("image", Path.basename(_image.path)));

      formData.files.add(MapEntry('user-image', file));

      //[5] SEND TO SERVER
      var response = await dioRequest.post(
        url,
        data: formData,
      );
      final result = json.decode(response.toString())['imageUrl'];

      print(result);
      if (json.decode(response.toString())['status_code'] == "00") {
        Navigator.pop(context);
        successAlertDialog(
            context, 'Success', "Profile picture changed successfully");
      }
    } catch (err) {
      print('ERROR  $err');

      Navigator.pop(context);
      // failedAlertDialog(context, 'Error', "$err");
    }
  }

  Future verify() async {
    if (_fNameController.text == '') {
      setState(() {
        fNameVerify = false;
      });
    } else {
      setState(() {
        fNameVerify = true;
        print('Success');
      });
    }

    if (_lNameController.text == '') {
      setState(() {
        lNameVerify = false;
      });
    } else {
      setState(() {
        lNameVerify = true;
        print('Success');
      });
    }

    if (_fNameController.text != '' && _lNameController.text != '') {
      if (_fNameController.text != initFName ||
          _lNameController.text != initLName) {
        setState(() {
          showLoading(context);
          changeNames();
        });
      } else {
        if (_image != null) {
          showLoading(context);
          //  showLoading(context);
          await changePic();
        }
      }
    }
  }

  Future changeNames() async {
    if (_image != null) {
      await changePic();
      Navigator.pop(context);
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = "${prefs.getString('token')}";
      var url = "http://157.230.150.194:3000/api/users/edit_user_details";

      var data = {
        "email": "${_emailController.text}",
        "firstName": "${_fNameController.text}",
        "lastName": "${_lNameController.text}",
      };

      var response = await http.post(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
          body: data);
      var message = jsonDecode(response.body);
      print(message);
      print(message['message']);
      print(message['status_code']);

      if (message['status_code'] == "00") {
        successAlertDialog(context, 'Success', message['message']);
      }
      print(message['reason']);
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var token = "${prefs.getString('token')}";
      var url = "http://157.230.150.194:3000/api/users/edit_user_details";

      var data = {
        "email": "${_emailController.text}",
        "firstName": "${_fNameController.text}",
        "lastName": "${_lNameController.text}",
      };

      var response = await http.post(Uri.parse(url),
          headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
          body: data);
      var message = jsonDecode(response.body);
      print(message);
      print(message['message']);
      print(message['status_code']);

      if (message['status_code'] == "00") {
        Navigator.pop(context);
        successAlertDialog(context, 'Success', message['message']);
      }
      print(message['reason']);
    }
  }

  // ignore: unused_element
  void _validate() {
    setState(() {
      _email = _emailController.text;
      _lName = _lNameController.text;
      _fName = _fNameController.text;
    });
  }

  @override
  void initState() {
    initFName = widget.fname;
    initLName = widget.lname;
    _emailController = TextEditingController(text: '${widget.email}');

    _fNameController = TextEditingController(text: '${widget.fname}');

    _lNameController = TextEditingController(text: '${widget.lname}');

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 25),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: _image == null
                        ? CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Icon(Icons.person, size: 50),
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(_image),
                            backgroundColor: Colors.white,
                            radius: 30,
                          ),
                  ),
                  Column(
                    children: [
                      SizedBox(height: 100),
                      IconButton(
                        onPressed: getImage,
                        icon: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                  controller: _fNameController,
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      errorText: fNameVerify ? null : "Field Can't be empty"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
              child: Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
                child: TextField(
                  controller: _lNameController,
                  onTap: () {},
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                      errorText: lNameVerify ? null : "Field Can't be empty"),
                ),
              ),
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
                child: Text('Save',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                onPressed: () {
                  verify();
                  /*     print('${_fNameController.text}  ${initFName}');
                  if (_image != null) {
                    changePic();
                  } */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
