import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';


class PaymentPage extends StatefulWidget {
  final String paymentUrl;
  final String reference;

  const PaymentPage({Key key, @required this.paymentUrl, this.reference}) : super(key: key); 
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  Timer timer;
  @override
  void initState() {
    super.initState();
      timer = Timer.periodic(Duration(seconds: 3), (Timer t) => checkStatus());
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
void dispose() {
  timer?.cancel();
  super.dispose();
}

 Future checkStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var url = "http://157.230.150.194:3000/api/paymentStatus/${widget.reference}";

    var token = "${prefs.getString('token')}";

    final response = await http.get(
      Uri.parse(url),
      headers: {HttpHeaders.authorizationHeader: "Bearer $token"},
    );

    final responseJson = jsonDecode(response.body);
    print('$responseJson');

    if(responseJson["status"] == "00"){
      Navigator.pop(context);
    }

    
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
          child: WebView(
        initialUrl: 'http://157.230.150.194:3000${widget.paymentUrl}',
      ),
    );
  }
}
