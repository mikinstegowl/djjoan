import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AnimatedBottomsheet.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CommonAdWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/AddPlaylistDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SongAddToDialog.dart';
import 'package:new_music_app/Utils/Widgets/SongListWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/SongPlayScreen.dart';
import 'package:new_music_app/View/HomeScreen/SongViewList.dart';

class AppNavigationScreen extends StatefulWidget {
  const AppNavigationScreen({super.key});

  @override
  State<AppNavigationScreen> createState() => _AppNavigationScreenState();
}

class _AppNavigationScreenState extends State<AppNavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<BaseController>(
          init: Get.find<BaseController>(),
          builder: (controller) {
            return Scaffold(
              appBar: AppNavigationBar(
                defaultAppBar: AppBar(),
              ),
              endDrawerEnableOpenDragGesture: false,
              endDrawer: Container(
                margin: EdgeInsets.only(top: 50.h),
                width: 320.h,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Drawer(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.r),
                    ),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Container(
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppAssets.blackBackgroundScreen)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.r),
                        ),
                        border: Border(
                            top: BorderSide(
                                color: AppColors.appButton, width: 6.w),
                            left: BorderSide(
                                color: AppColors.appButton, width: 6.w))),
                    child: GetBuilder<HomeController>(
                        init: Get.find<HomeController>(),
                        builder: (controller) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TitleBackButtonWidget(
                                onTap: () async {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (_, __, ___) =>
                                              SongViewList(
                                                title: UserPreference.getValue(
                                                        key: PrefKeys
                                                            .categoryName) ??
                                                    '',
                                                // assests:
                                                //     Get.find<HomeController>()
                                                //         .categoriesSongDataModel
                                                //         ?.data,
                                              )));
                                },
                                iconShow: false,
                                customTitle: const AppTextWidget(
                                  txtTitle: "-- View All --",
                                  txtColor: AppColors.appButton,
                                  fontSize: 16,
                                ),
                              ),
                              Expanded(
                                child: Get.find<HomeController>()
                                            .categorySongModel
                                            ?.data
                                            ?.songs
                                            ?.length !=
                                        0
                                    ? ListView.separated(
                                        shrinkWrap: true,
                                        physics: const ClampingScrollPhysics(),
                                        controller: controller
                                            .scrollControllerForCategorySong,
                                        itemCount: Get.find<HomeController>()
                                                    .categorySongModel
                                                    ?.data
                                                    ?.songs
                                                    ?.length !=
                                                0
                                            ? Get.find<HomeController>()
                                                    .categorySongModel
                                                    ?.data
                                                    ?.songs
                                                    ?.length ??
                                                0
                                            : 0,
                                        itemBuilder: (context, index) {
                                          if (Get.find<HomeController>()
                                                  .categorySongModel
                                                  ?.data
                                                  ?.songs
                                                  ?.length !=
                                              0) {
                                            return SongListWidget(
                                              gifWidget: Get.find<
                                                          HomeController>()
                                                      .audioPlayer
                                                      .current
                                                      .hasValue &&
                                                  Get.find<HomeController>()
                                                          .categorySongModel
                                                          ?.data
                                                          ?.songs?[index]
                                                          .songName ==
                                                      Get.find<HomeController>()
                                                          .audioPlayer
                                                          .current
                                                          .value
                                                          ?.audio
                                                          .audio
                                                          .metas
                                                          .title,
                                              onOptionTap: () {
                                                Get.dialog(SongAddToDialog(
                                                  onFavorites: () async {
                                                    if (Get.find<
                                                                HomeController>()
                                                            .categorySongModel
                                                            ?.data
                                                            ?.songs?[index]
                                                            .isFavourite ??
                                                        false) {
                                                      Get.back();
                                                      Utility.showSnackBar(
                                                          "This Song is already in Favorites",
                                                          isError: true);
                                                    } else {
                                                      Get.back();
                                                      Get.find<HomeController>()
                                                          .categorySongModel
                                                          ?.data
                                                          ?.songs?[index]
                                                          .isFavourite = await Get
                                                              .find<
                                                                  HomeController>()
                                                          .addRemoveSongFromFavourites(
                                                              type: 'song',
                                                              menuId: Get.find<
                                                                          HomeController>()
                                                                      .categorySongModel
                                                                      ?.data
                                                                      ?.songs?[
                                                                          index]
                                                                      .menuId ??
                                                                  0,
                                                              songId: Get.find<
                                                                          HomeController>()
                                                                      .categorySongModel
                                                                      ?.data
                                                                      ?.songs?[
                                                                          index]
                                                                      .id ??
                                                                  0);
                                                    }
                                                  },
                                                  onPlaylist: () {
                                                    Get.back();
                                                    Get.dialog(
                                                        AddPlaylistDialog(
                                                      menuId: Get.find<
                                                                  HomeController>()
                                                              .categorySongModel
                                                              ?.data
                                                              ?.songs?[index]
                                                              .menuId ??
                                                          0,
                                                      songId: Get.find<
                                                                  HomeController>()
                                                              .categorySongModel
                                                              ?.data
                                                              ?.songs?[index]
                                                              .id ??
                                                          0,
                                                    ));
                                                  },
                                                ));
                                              },
                                              onTap: () async {
                                                await Get.find<HomeController>()
                                                    .playSong(
                                                        assests: Get.find<
                                                                    HomeController>()
                                                                .categorySongModel
                                                                ?.data
                                                                ?.songs ??
                                                            [],
                                                        index: index);
                                                await Get.find<HomeController>()
                                                    .songUpdateAPi(
                                                        songId: Get.find<
                                                                    HomeController>()
                                                                .categorySongModel
                                                                ?.data
                                                                ?.songs?[index]
                                                                .id ??
                                                            0,
                                                        action: 'play',
                                                        currentIndex: index);
                                                Navigator.push(context,
                                                    PageRouteBuilder(
                                                        pageBuilder:
                                                            (_, __, ___) {
                                                  return SongPlayScreen(
                                                    menuId: Get.find<
                                                                HomeController>()
                                                            .categorySongModel
                                                            ?.data
                                                            ?.songs?[index]
                                                            .menuId ??
                                                        0,
                                                    songId: Get.find<
                                                                HomeController>()
                                                            .categorySongModel
                                                            ?.data
                                                            ?.songs?[index]
                                                            .id ??
                                                        0,
                                                    // index: index ?? 0,
                                                    // assests: assests,
                                                  );
                                                }));
                                              },
                                              imageUrl:
                                                  Get.find<HomeController>()
                                                          .categorySongModel
                                                          ?.data
                                                          ?.songs?[index]
                                                          .songImage ??
                                                      Get.find<HomeController>()
                                                          .categorySongModel
                                                          ?.data
                                                          ?.songs?[index]
                                                          .songImage ??
                                                      '',
                                              title: Get.find<HomeController>()
                                                      .categorySongModel
                                                      ?.data
                                                      ?.songs?[index]
                                                      .songName ??
                                                  Get.find<HomeController>()
                                                      .categorySongModel
                                                      ?.data
                                                      ?.categoryName ??
                                                  '',
                                              subTitle:
                                                  Get.find<HomeController>()
                                                          .categorySongModel
                                                          ?.data
                                                          ?.songs?[index]
                                                          .songArtist ??
                                                      '',
                                            );
                                          } else {
                                            return const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Center(
                                                  child: AppTextWidget(
                                                    txtTitle:
                                                        'No Data Found !!',
                                                    fontSize: 20,
                                                    txtColor: AppColors.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          Get.find<AdService>().bannerAds = [];
                                          if ((index + 1) % 6 == 0) {
                                            Get.find<AdService>()
                                                .bannerAds
                                                .add(BannerAd(
                                                  size: AdSize.fullBanner,
                                                  adUnitId: Platform.isAndroid
                                                      ? "ca-app-pub-3940256099942544/6300978111"
                                                      : 'ca-app-pub-3940256099942544/2934735716',
                                                  listener:
                                                      Get.find<AdService>()
                                                          .showBannerAd(),
                                                  request: const AdRequest(),
                                                )..load());

                                            // print(
                                            //     "this is nativeads called ${Get.find<AdService>().nativeads.length}");
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Divider(),
                                                SizedBox(
                                                    height: 80.h,
                                                    child: AdWidget(
                                                        ad: Get.find<
                                                                AdService>()
                                                            .bannerAds
                                                            .first)),
                                                const Divider()
                                              ],
                                            );
                                          } else {
                                            return const Divider();
                                          }
                                        },
                                      )
                                    : const Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: AppTextWidget(
                                              txtTitle: 'No Data Found !!',
                                              fontSize: 20,
                                              txtColor: AppColors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                              )
                            ],
                          );
                        }),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Expanded(child: controller.tabs[AppConst.currentTabIndex]),
                ],
              ),
              bottomNavigationBar: const Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBottomSheet(),
                  // if (Get.find<AdService>().bannerAd != null)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: CommonAdWidget(),
                      // Container(
                      //   color: AppColors.transparent,
                      //   height: 60,
                      //   width: double.maxFinite,
                      //   child: AdWidget(ad: Get.find<AdService>().bannerAd!),
                      // // ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
