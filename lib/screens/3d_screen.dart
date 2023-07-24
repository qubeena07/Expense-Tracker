import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ThreeDScreen extends StatefulWidget {
  const ThreeDScreen({super.key});

  @override
  State<ThreeDScreen> createState() => _ThreeDScreenState();
}

class _ThreeDScreenState extends State<ThreeDScreen> {
  InAppWebViewController? webViewController;

  @override
  Widget build(BuildContext context) {
    final GlobalKey webViewKey = GlobalKey();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 300,
          width: 300,
          child: InAppWebView(
            key: webViewKey,
            initialUrlRequest: URLRequest(
                url: Uri.parse('https://elegant-tanuki-0787ed.netlify.app/')),
          ),

          // (
          //             key: _key,
          //             javascriptMode: JavascriptMode.unrestricted,
          //             initialUrl: _url)
        ),
      ),
    );
  }
}
