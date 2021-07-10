import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';


class Bible extends StatefulWidget {
  @override
  _BibleState createState() => _BibleState();
}

class _BibleState extends State<Bible> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar:  AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
         
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
      url: 'https://www.bible.com/bible/59/GEN.1.ESV',
    
    );
  }
}
