import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String name;
  final dynamic html;

  const WebViewPage({Key? key, required this.name, required this.html}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: const Color(0xFF2D333B),
      ),
      body: WebView(
        initialUrl: widget.html,
      ),
    );
  }
}
