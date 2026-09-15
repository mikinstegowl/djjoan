import 'package:flutter/material.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialMediaWebView extends StatefulWidget {
  final String url;
  final String title;

  const SocialMediaWebView({super.key, required this.url, required this.title});

  @override
  State<SocialMediaWebView> createState() => _SocialMediaWebViewState();
}

class _SocialMediaWebViewState extends State<SocialMediaWebView> {
  late WebViewController _webViewController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const AppLoder();
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppNavigationBar(
          defaultAppBar: AppBar(),
        ),
        body: Container(
          width: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppAssets.blackBackgroundScreen,
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              TitleBackButtonWidget(title: widget.title),
              Expanded(
                child: WebViewWidget(
                  controller: _webViewController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
