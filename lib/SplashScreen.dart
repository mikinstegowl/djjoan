import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final String? token = UserPreference.getValue(key: PrefKeys.logInToken);
    Future.delayed(const Duration(seconds: 3), () {
      Get.put(AdService(), permanent: true);
      Get.find<AdService>().createBannerAd();
      // Get.find<AdService>().createNativeAd();
      if (token == null) {
        if (UserPreference.getValue(key: PrefKeys.firstTime)) {
          // Get.offAllNamed(RoutesName.loginScreen);
          Get.offAllNamed(RoutesName.walkthroughScreen);
        } else {
          Get.offAllNamed(RoutesName.loginScreen);
        }
      } else {
        // Get.offAllNamed(RoutesName.loginScreen);
        Get.offAllNamed(RoutesName.homeScreen);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.smokeBlack,
      resizeToAvoidBottomInset: false,
      body: SizedBox.expand(
        child: Image.asset(
          AppAssets.launchScreen,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
