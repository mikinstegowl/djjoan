import 'package:flutter/material.dart';
import 'package:get/get.dart' as gt;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/LiveVideoController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationScreen.dart';
import 'package:new_music_app/View/LiveVideoScreen/LiveVideoScreen.dart';

class AppNavigationBar extends StatefulWidget implements PreferredSizeWidget {
  final AppBar defaultAppBar;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Widget? leading;
  final Widget? title;

  const AppNavigationBar(
      {super.key,
      required this.defaultAppBar,
      this.automaticallyImplyLeading = false,
      this.actions,
      this.backgroundColor,
      this.leading,
      this.title});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(87);
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(widget.defaultAppBar.preferredSize.height);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BaseController>(
        init: Get.find<BaseController>(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            height: preferredSize.height,
            color: widget.backgroundColor ?? AppColors.smokeBlack,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    width: preferredSize.width,
                    height: preferredSize.height,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: InkWell(
                            child: Image.asset(
                              AppAssets.menu1,
                              width: 20.w,
                              height: 20.h,
                              color: AppConst.currentTabIndex == 0
                                  ? AppColors.appButton
                                  : AppColors.white,
                            ),
                            onTap: () {
                              Get.find<AdService>().bannerAd = null;
                              Get.find<AdService>().createBannerAd();

                              AppConst.currentTabIndex = 0;
                              setState(() {});
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return const AppNavigationScreen();
                              })).then((value) => null);

                              // Get.toNamed(RoutesName.homeScreen);
                            },
                          ),
                        ),
                        SizedBox(
                          child: InkWell(
                            onTap: () {
                              Get.find<AdService>().bannerAd = null;
                              Get.find<AdService>().createBannerAd();
                              Get.find<LiveVideoController>().subscriptionStatusAPi();
                              AppConst.currentTabIndex = 1;
                              AppConst.liveVideoUrl.value = true;
                              controller.backGroundStreamController.sink
                                  .add(false);
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return const LiveVideoScreen();
                              }));
                            },
                            child: Image.asset(AppAssets.menu2,
                                fit: BoxFit.cover,
                                width: 20.w,
                                height: 20.h,
                                color: AppConst.currentTabIndex == 1
                                    ? AppColors.appButton
                                    : AppColors.white),
                          ),
                        ),
                        SizedBox(
                          child: InkWell(

                            child: Image.asset(AppAssets.menu3,
                                width: 20.w,
                                height: 20.h,
                                color: AppConst.currentTabIndex == 2
                                    ? AppColors.appButton
                                    : AppColors.white),
                            onTap: () {
                              Get.find<AdService>().bannerAd = null;
                              Get.find<AdService>().createBannerAd();
                              AppConst.currentTabIndex = 2;
                              controller.update();
                              setState(() {});
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return const AppNavigationScreen();
                              }));
                            },
                          ),
                        ),
                        SizedBox(
                          child: InkWell(
                            child: Image.asset(AppAssets.menu4,
                                width: 20.w,
                                height: 20.h,
                                color: AppConst.currentTabIndex == 3
                                    ? AppColors.appButton
                                    : AppColors.white),
                            onTap: () {
                              Get.find<AdService>().bannerAd = null;
                              Get.find<AdService>().createBannerAd();

                              AppConst.currentTabIndex = 3;
                              setState(() {});
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return const AppNavigationScreen();
                              }));
                            },
                          ),
                        ),
                        SizedBox(
                          child: InkWell(
                            child: Image.asset(AppAssets.menu5,
                                width: 20.w,
                                height: 20.h,
                                color: AppConst.currentTabIndex == 4
                                    ? AppColors.appButton
                                    : AppColors.white),
                            onTap: () {
                              Get.find<AdService>().bannerAd = null;
                              Get.find<AdService>().createBannerAd();
                              AppConst.currentTabIndex = 4;
                              setState(() {});
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return const AppNavigationScreen();
                              }));
                            },
                          ),
                        ),
                        SizedBox(
                          child: InkWell(
                            child: Image.asset(AppAssets.menu6,
                                width: 20.w,
                                height: 20.h,
                                color: AppConst.currentTabIndex == 5
                                    ? AppColors.appButton
                                    : AppColors.white),
                            onTap: () {
                              Get.find<AdService>().bannerAd = null;
                              Get.find<AdService>().createBannerAd();

                              AppConst.currentTabIndex = 5;
                              setState(() {});
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return const AppNavigationScreen();
                              }));
                            },
                          ),
                        ),
                        SizedBox(
                          child: InkWell(
                            child: Icon(
                              Icons.menu,
                              size: 20.r,
                              color: AppConst.currentTabIndex == 6
                                  ? AppColors.appButton
                                  : AppColors.white,
                            ),
                            // Image.asset(AppAssets.menu7,
                            //     width: 20.w,
                            //     height: 20.h,
                            //     color: controller.currentTabIndex.value == 6
                            //         ? AppColors.error
                            //         : AppColors.white),
                            onTap: () {
                              Get.find<AdService>().bannerAd = null;
                              Get.find<AdService>().createBannerAd();

                              AppConst.currentTabIndex = 6;
                              setState(() {});
                              Navigator.push(context,
                                  PageRouteBuilder(pageBuilder: (_, __, ___) {
                                return const AppNavigationScreen();
                              }));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
