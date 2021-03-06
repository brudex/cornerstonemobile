import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentPage extends StatefulWidget {
  final String paymentUrl;
  final String reference;

  const PaymentPage({Key key, @required this.paymentUrl, this.reference})
      : super(key: key);
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  //StreamSubscription<String> _onStateChanged;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String state) async {
      if (state
          .startsWith("http://157.230.150.194:3000/paymentResult/failed")) {
            await checkStatus();
        Navigator.pop(context, 'Failed');
        /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationSuccess(),
                    ),
                  ); */
      } else if(state
          .startsWith("http://157.230.150.194:3000/paymentResult/success")){
              Navigator.pop(context, 'Success');
          }
    });
  }

  Future checkStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url =
        "http://157.230.150.194:3000/api/paymentStatus/${widget.reference}";

    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);
    print('$responseJson');

    if (responseJson["status"] == "00") {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar:  AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(242, 245, 247, 1),
         
          leading: IconButton(
              icon: Icon(
                CupertinoIcons.xmark,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
      ),
      withJavascript: true,
      // javascriptMode: JavascriptMode.unrestricted,
      url: 'http://157.230.150.194:3000${widget.paymentUrl}',
    );
  }
}
