import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomWebView extends StatefulWidget {
  final String url;

  CustomWebView({this.url});

  @override
  CustomWebViewState createState() => CustomWebViewState();
}

class CustomWebViewState extends State<CustomWebView> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NewsFeed"),
      ),
      body: WebView(
        initialUrl: widget.url,
      ),
    );
  }
}
