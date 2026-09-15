import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/HomeModel.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AnimatedBottomsheet.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/AddPlaylistDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SongAddToDialog.dart';
import 'package:new_music_app/Utils/Widgets/SongListWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/SongPlayScreen.dart';

class SongViewList extends GetView<HomeController> {
  final String title;
  final int? assestsDataIndex;
  final List<Items>? assests;

  const SongViewList(
      {super.key, required this.title, this.assests, this.assestsDataIndex});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: Scaffold(
          appBar: AppNavigationBar(
            defaultAppBar: AppBar(),
          ),
          bottomNavigationBar: const AnimatedBottomSheet(),
          body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      AppAssets.blackBackgroundScreen,
                    ),
                    fit: BoxFit.cover)),
            child: GetBuilder<HomeController>(
                init: controller,
                builder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TitleBackButtonWidget(
                        title: title,
                      ),
                      Expanded(
                        child: assests?.length != 0
                            ? ListView.separated(
                                shrinkWrap: true,
                                controller:
                                    controller.scrollControllerForCategorySong,
                                physics: const ClampingScrollPhysics(),
                                itemCount: assests?.length != 0
                                    ? assests?.length ?? 0
                                    : 0,
                                itemBuilder: (context, index) {
                                  if (assests?.length != 0) {
                                    return SongListWidget(
                                      gifWidget: Get.find<HomeController>()
                                              .audioPlayer
                                              .current
                                              .hasValue &&
                                          assests?[index].songName ==
                                              Get.find<HomeController>()
                                                  .audioPlayer
                                                  .current
                                                  .value
                                                  ?.audio
                                                  .audio
                                                  .metas
                                                  .title,
                                      onOptionTap: () {
                                        controller.assetsSongs
                                            .addAll(assests ?? []);
                                        Get.dialog(SongAddToDialog(
                                          onFavorites: () async {
                                            if (assests?[index].isFavourite ??
                                                false) {
                                              Get.back();
                                              Utility.showSnackBar(
                                                  "This Song is already in Favorites",
                                                  isError: true);
                                            } else {
                                              Get.back();
                                              assests?[
                                                      index]
                                                  .isFavourite = await Get.find<
                                                      HomeController>()
                                                  .addRemoveSongFromFavourites(
                                                      assestsDataIndex: index,
                                                      type: 'song',
                                                      menuId: assests?[index]
                                                              .menuId ??
                                                          0,
                                                      songId:
                                                          assests?[index].id ??
                                                              0);
                                            }
                                          },
                                          onPlaylist: () {
                                            Get.back();
                                            Get.dialog(AddPlaylistDialog(
                                              menuId:
                                                  assests?[index].menuId ?? 0,
                                              songId: assests?[index].id ?? 0,
                                            ));
                                          },
                                        ));
                                      },
                                      onTap: () async {
                                        await controller.playSong(
                                            assests: assests ?? [],
                                            index: index);
                                        await controller.songUpdateAPi(
                                            songId: assests?[index].id ?? 0,
                                            action: 'play',
                                            currentIndex: index);
                                        Navigator.push(context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) {
                                          return SongPlayScreen(
                                            menuId: assests?[index].menuId ?? 0,
                                            songId: assests?[index].id ?? 0,
                                            // assests?[index].songId ??
                                            // index: index ?? 0,
                                            // assests: assests,
                                          );
                                        }));
                                      },
                                      imageUrl: assests?[index].songImage ??
                                          assests?[index].categoryImage ??
                                          '',
                                      title: assests?[index].categoryName ??
                                          assests?[index].songName ??
                                          '',
                                      subTitle:
                                          assests?[index].songArtist ?? '',
                                    );
                                  } else {
                                    return const Column(
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
                                    );
                                  }
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  if ((index + 1) % 6 == 0) {
                                    Get.find<AdService>()
                                        .bannerAds
                                        .add(BannerAd(
                                          size: AdSize.fullBanner,
                                          adUnitId: Platform.isAndroid
                                              ? "ca-app-pub-3940256099942544/6300978111"
                                              : 'ca-app-pub-3940256099942544/2934735716',
                                          listener: Get.find<AdService>()
                                              .showBannerAd(),
                                          request: const AdRequest(),
                                        )..load());

                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Divider(),
                                        SizedBox(
                                            height: 80.h,
                                            child: AdWidget(
                                                ad: Get.find<AdService>()
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
                                mainAxisAlignment: MainAxisAlignment.center,
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
        )),
        Obx(() => Visibility(
            visible: controller.loader.value, child: const AppLoder())),
      ],
    );
  }
}
