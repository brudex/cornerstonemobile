import 'dart:async';
import 'package:cornerstone/ui/main_screens/donations/donation_success_screen.dart';
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

   StreamSubscription<String> _onStateChanged;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

     _onStateChanged =
            flutterWebviewPlugin.onUrlChanged.listen((String state) async {
          if (state.startsWith( "http://157.230.150.194:3000/paymentResult/failed")) {
                 Navigator.pop(context, 'Failed');
                /*  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonationSuccess(),
                    ),
                  ); */
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
      
      withJavascript: true,
      // javascriptMode: JavascriptMode.unrestricted,
      url: 'http://157.230.150.194:3000${widget.paymentUrl}',

    );
  }
}
