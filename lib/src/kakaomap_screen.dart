import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

@deprecated
class KakaoMapScreen extends StatefulWidget {
  const KakaoMapScreen({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<KakaoMapScreen> createState() => _KakaoMapScreenState();
}

class _KakaoMapScreenState extends State<KakaoMapScreen> {
  late final WebViewController _controller;

  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          _scaffoldMessengerKey.currentState
              ?.showSnackBar(SnackBar(content: Text(message.message)));
        },
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
          body: SafeArea(
        child: WebViewWidget(controller: _controller),
      )),
    );
  }
}
