import 'package:flutter/material.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ContactUsScreen extends StatefulWidget {
  final String url;

  const ContactUsScreen({super.key, required this.url});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
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
          onPageStarted: (String url) {
            const AppLoder();
          },
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
            color: AppColors.white,
            // image: DecorationImage(
            //     image: AssetImage(
            //       AppAssets.blackBackgroundScreen,
            //     ),
            //     fit: BoxFit.cover)
          ),
          child: Column(
            children: [
              const TitleBackButtonWidget(
                contactUs: false,
                title: 'Contact Us',
              ),
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
