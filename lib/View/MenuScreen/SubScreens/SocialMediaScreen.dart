// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:new_music_app/Controller/MenuPageController.dart';
// import 'package:new_music_app/Utils/Constants/AppAssets.dart';
// import 'package:new_music_app/Utils/Styling/AppColors.dart';
// import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
// import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
// import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
// import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
// import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
// import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
// import 'package:new_music_app/View/HomeScreen/Widget/BannerWidget.dart';
// import 'package:new_music_app/View/MenuScreen/SubScreens/SocialMediaWebView.dart';
// import 'package:new_music_app/View/MenuScreen/SubScreens/Widgets/SocialMdeisAppContainer.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class SocialMediaScreen extends StatefulWidget {
//   const SocialMediaScreen({super.key});
//
//   @override
//   State<SocialMediaScreen> createState() => _SocialMediaScreenState();
// }
//
// class _SocialMediaScreenState extends State<SocialMediaScreen> {
//   late WebViewController _webViewController;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     _webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             AppLoder();
//           },
//           onPageStarted: (String url) {
//             AppLoder();
//           },
//           onPageFinished: (String url) {},
//           onWebResourceError: (WebResourceError error) {},
//         ),
//       )
//       ..loadRequest(Uri.parse('https://durisimoapps.wufoo.com/forms/z13f3id91u6k478/'));
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppNavigationBar(defaultAppBar: AppBar()),
//       body: Container(
//         constraints: BoxConstraints(
//             minHeight: MediaQuery.of(context).size.height,
//             maxHeight: MediaQuery.of(context).size.height),
//         width: double.maxFinite,
//         decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage(
//                   AppAssets.blackBackgroundScreen,
//                 ),
//                 fit: BoxFit.cover)),
//         child: GetBuilder<MenuPageController>(
//           init: Get.find<MenuPageController>(),
//             initState: (state) {
//               Get.find<MenuPageController>().socialMedia();
//         }, builder: (controller) {
//           return Column(
//             children: [
//               const TitleBackButtonWidget(title: "Social and Booking"),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const BannerWidget(),
//                       SocialMediaContainer(
//                         icons: AppAssets.instagram,
//                         title: "Instagram",
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               PageRouteBuilder(
//                                   pageBuilder: (_, __, ___) =>
//                                       SocialMediaWebView(
//                                           url: controller.getSocialMediaModel.value
//                                                   ?.data?.instagramLink ??
//                                               "",
//                                           title: "Instagram")));
//                         },
//                       ),
//                       20.verticalSpace,
//                       SocialMediaContainer(
//                         icons: AppAssets.twitter,
//                         title: "Twitter",
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               PageRouteBuilder(
//                                   pageBuilder: (_, __, ___) =>
//                                       SocialMediaWebView(
//                                           url: controller.getSocialMediaModel.value
//                                               ?.data?.twitterLink ??
//                                               "",
//                                           title: "Twitter")));
//                         },
//                       ),
//                       20.verticalSpace,
//                       SocialMediaContainer(
//                         icons: AppAssets.facebook,
//                         title: "Facebook",
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               PageRouteBuilder(
//                                   pageBuilder: (_, __, ___) =>
//                                       SocialMediaWebView(
//                                           url: controller.getSocialMediaModel.value
//                                               ?.data?.facebookLink ??
//                                               "",
//                                           title: "Facebook")));
//                         },
//                       ),
//                       20.verticalSpace,
//                       SocialMediaContainer(
//                         icons: AppAssets.earth,
//                         title: "Other",
//                         onTap: () {
//                           Navigator.push(
//                               context,
//                               PageRouteBuilder(
//                                   pageBuilder: (_, __, ___) =>
//                                       SocialMediaWebView(
//                                           url: controller.getSocialMediaModel.value
//                                               ?.data?.otherLink ??
//                                               "",
//                                           title: "Others")));
//                         },
//                       ),
//                       20.verticalSpace,
//                       AppTextWidget(
//                         txtTitle: "-Book Dj Sisko-",
//                         txtColor: AppColors.appButton,
//                         fontSize: 20,
//                       ),
//                       25.verticalSpace,
//                       // Padding(
//                       //   padding: EdgeInsets.symmetric(horizontal: 25.w),
//                       //   child: AppTextFormField(
//                       //     hintText: "Enter Your Name",
//                       //     titleText: "Name",
//                       //     hintTextColor: AppColors.textFormFieldTextColor,
//                       //   ),
//                       // ),
//                       // 25.verticalSpace,
//                       // Padding(
//                       //   padding: EdgeInsets.symmetric(horizontal: 25.w),
//                       //   child: AppTextFormField(
//                       //     hintText: "Enter Email",
//                       //     titleText: "Email",
//                       //     hintTextColor: AppColors.textFormFieldTextColor,
//                       //   ),
//                       // ),
//                       // 25.verticalSpace,
//                       // Padding(
//                       //   padding: EdgeInsets.symmetric(horizontal: 25.w),
//                       //   child: AppTextFormField(
//                       //     hintText: "Enter Phone",
//                       //     titleText: "Phone",
//                       //     hintTextColor: AppColors.textFormFieldTextColor,
//                       //   ),
//                       // ),
//                       // 25.verticalSpace,
//                       // Flexible(
//                       //   flex: 3,
//                       //   child: Padding(
//                       //     padding: EdgeInsets.symmetric(horizontal: 15.w),
//                       //     child: AppTextFormField(
//                       //       hintText: "",
//                       //       titleText: "Comment",
//                       //       titleTextColor: AppColors.white.withOpacity(0.5),
//                       //       maxLine: null,
//                       //       maxLength: null,
//                       //     ),
//                       //   ),
//                       // ),
//                       // 25.verticalSpace,
//                       // AppButtonWidget(
//                       //   onPressed: () {
//                       //     controller.bookingApi();
//                       //   },
//                       //   btnName: 'Submit'.toUpperCase(),
//                       //   fontWeight: FontWeight.w800,
//                       //   padding: EdgeInsets.symmetric(
//                       //       horizontal: 45.w, vertical: 10.h),
//                       //   borderRadius: 10,
//                       //   btnColor: AppColors.textFormFieldTextColor,
//                       // ),
//                       Container(
//                         height: 500,
//                         width: double.maxFinite,
//                         child: WebViewWidget(
//                           controller: _webViewController,
//                         ),
//                       ),
//                       30.verticalSpace,
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         }),
//       ),
//     ));
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/Widget/BannerWidget.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/SocialMediaWebView.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/Widgets/SocialMdeisAppContainer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SocialMediaScreen extends StatefulWidget {
  const SocialMediaScreen({super.key});

  @override
  State<SocialMediaScreen> createState() => _SocialMediaScreenState();
}

class _SocialMediaScreenState extends State<SocialMediaScreen> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
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
      ..loadRequest(
          Uri.parse('https://durisimoapps.wufoo.com/forms/z13f3id91u6k478/'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppNavigationBar(defaultAppBar: AppBar()),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.blackBackgroundScreen),
            fit: BoxFit.cover,
          ),
        ),
        child: GetBuilder<MenuPageController>(
          init: Get.find<MenuPageController>(),
          initState: (_) => Get.find<MenuPageController>().socialMedia(),
          builder: (controller) {
            return Column(
              children: [
                const TitleBackButtonWidget(title: "Social and Booking"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const BannerWidget(),
                        SocialMediaContainer(
                          icons: AppAssets.instagram,
                          title: "Instagram",
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => SocialMediaWebView(
                                  url: controller.getSocialMediaModel.value
                                          ?.data?.instagramLink ??
                                      "",
                                  title: "Instagram",
                                ),
                              ),
                            );
                          },
                        ),
                        20.verticalSpace,
                        SocialMediaContainer(
                          icons: AppAssets.twitter,
                          title: "Twitter",
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => SocialMediaWebView(
                                  url: controller.getSocialMediaModel.value
                                          ?.data?.twitterLink ??
                                      "",
                                  title: "Twitter",
                                ),
                              ),
                            );
                          },
                        ),
                        20.verticalSpace,
                        SocialMediaContainer(
                          icons: AppAssets.facebook,
                          title: "Facebook",
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => SocialMediaWebView(
                                  url: controller.getSocialMediaModel.value
                                          ?.data?.facebookLink ??
                                      "",
                                  title: "Facebook",
                                ),
                              ),
                            );
                          },
                        ),
                        20.verticalSpace,
                        SocialMediaContainer(
                          icons: AppAssets.earth,
                          title: "Other",
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (_, __, ___) => SocialMediaWebView(
                                  url: controller.getSocialMediaModel.value
                                          ?.data?.otherLink ??
                                      "",
                                  title: "Others",
                                ),
                              ),
                            );
                          },
                        ),
                        20.verticalSpace,
                        const AppTextWidget(
                          txtTitle: "-Book Dj Jay Lyrics-",
                          txtColor: AppColors.appButton,
                          fontSize: 20,
                        ),
                        25.verticalSpace,
                        // Fix: Using SizedBox instead of Container
                        Container(
                          color: AppColors.white,
                          height: 520.h,
                          // Ensuring fixed height for WebView
                          width: double.infinity,
                          child: WebViewWidget(
                            controller: _webViewController,
                          ),
                        ),
                        30.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ));
  }
}
