import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zimvest/widgets/new/new_widgets.dart';

class FAQScreen extends StatefulWidget {
  final String url;
  final String title;

  const FAQScreen({Key key, this.url, this.title}) : super(key: key);
  static Route<dynamic> route({String url, String title}) {
    return MaterialPageRoute(
        builder: (_) => FAQScreen(
          url: url,
          title: title,
        ),
        settings:
        RouteSettings(name: FAQScreen().toStringShort()));
  }
  @override
  FAQScreenState createState() => FAQScreenState();
}

class FAQScreenState extends State<FAQScreen> {
  final _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    print("ppp");
    return Scaffold(
      appBar:ZimAppBar(
        text: widget.title,
        icon: Icons.arrow_back_ios_rounded,
        callback: (){
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: WebView(
              onPageStarted: (value){
                print("sfdfdf $value");
              },
              onWebResourceError: (error){
                print("oooo ${error.errorType}");
              },
              onPageFinished: (String url) {
                print('Page finished loading: $url');
              },
              key: _key,
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.url,
            ),
          ),
        ],
      ),
    );
  }
}