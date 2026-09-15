import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationScreen.dart';

class AdScreen extends StatefulWidget {
  final bool stopRebuilding;

  const AdScreen({super.key, this.stopRebuilding = false});

  @override
  State<AdScreen> createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {
  bool shouldRebuild(AdScreen oldWidget) {
    // If stopRebuilding is true, the widget won't rebuild.
    return !widget.stopRebuilding;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            const Expanded(child: AppNavigationScreen()),
            if (Get.find<AdService>().bannerAd != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: SafeArea(
                  child: Container(
                    color: AppColors.black,
                    height: 60,
                    width: double.maxFinite,
                    child: AdWidget(ad: Get.find<AdService>().bannerAd!),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
