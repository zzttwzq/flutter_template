import 'dart:convert';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CusView.dart';
// import 'package:url_launcher/url_launcher.dart';

class CusWebview extends StatefulWidget {
  final Map data;
  CusWebview({required this.data}) : super();

  @override
  createState() => CusWebviewState(data: data);
}

class CusWebviewState extends CusView {
  var stack = [];
  late WebViewController _webViewController;

  final Map data;
  CusWebviewState({required this.data});

  @override
  customValue() {
    title = data['title'];
  }

  @override
  getNavBarLeading() {
    return MaterialButton(
        onPressed: () async {
          var can = await _webViewController.canGoBack();

          if (can == true) {
            _webViewController.goBack();
          } else {
            Navigator.pop(context);
          }
        },
        child: Image.asset(
          'assets/images/arrow_back.png',
          height: 24,
        ));
  }

  @override
  custView(context) {
    String sourceUrl = data['url'];
    print(sourceUrl);

    String url = '';
    String str = sourceUrl.substring(0, 7);
    print(str);
    var isFromLocal = str == 'assets/';
    if (isFromLocal) {
      url = '';
    } else {
      if (sourceUrl.contains('http://') != true &&
          sourceUrl.contains('https://') != true) {
        url = "http://$url";
      }
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      // child: WebView(
      //     initialUrl: url,
      //     javascriptMode: JavascriptMode.unrestricted,
      //     onWebViewCreated: (WebViewController webViewController) {
      //       _webViewController = webViewController;
      //       if (isFromLocal) {
      //         _loadHtmlFromAssets(sourceUrl);
      //       }
      //     },
      //     onPageStarted: (url) {
      //       stack.add(url);
      //     })
    );
  }

  _loadHtmlFromAssets(url) async {
    print(url);

    // String fileHtmlContents = await rootBundle.loadString(url);
    // _webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
    //         mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
    //     .toString());
  }
}
