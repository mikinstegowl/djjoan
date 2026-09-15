
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';

class BackGroundWidget extends GetView<BaseController> {
  final Widget screen;

  const BackGroundWidget({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: controller.backGroundStreamController.stream,
        builder: (context, snap) {
          return Scaffold(
            backgroundColor: AppColors.smokeBlack,
            body: Container(
              height: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        AppAssets.blackBackgroundScreen,
                      ),
                      fit: BoxFit.cover)),
              child: screen,
            ),
            bottomNavigationBar: SafeArea(
              child: Container(
                color: AppColors.transparent,
                height: 60,
                width: double.maxFinite,
                child: AdWidget(ad: Get.find<AdService>().bannerAd!),
              ),
            ),
          );
        });
  }
}
