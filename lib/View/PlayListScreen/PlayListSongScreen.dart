import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/PlayListController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Models/HomeModel.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppSearchField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SongAddToDialog.dart';
import 'package:new_music_app/Utils/Widgets/SongListWidget.dart';
import 'package:new_music_app/View/HomeScreen/SongPlayScreen.dart';
import 'package:new_music_app/View/HomeScreen/Widget/BannerWidget.dart';

class PlayListSongScreen extends GetView<PlayListController> {
  final int playlistId;

  const PlayListSongScreen({required this.playlistId, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppNavigationBar(
              defaultAppBar: AppBar(),
            ),
            // bottomNavigationBar: AnimatedBottomSheet(),
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        AppAssets.blackBackgroundScreen,
                      ),
                      fit: BoxFit.cover)),
              child: GetBuilder<HomeController>(
                  init: Get.find<HomeController>(),
                  initState: (state) =>
                      controller.getPlayListSongApi(playlistId),
                  builder: (homeController) {
                    return Column(
                      children: [
                        const BannerWidget(),
                        10.verticalSpace,
                        AppSearchField(
                          onChanged: (value) {
                            controller.searchPlaylistSong(value, playlistId);
                          },
                          controller: controller.playListSongController,
                          onSearch: () {
                            controller.searchPlaylistSong(
                                controller.playListController.text, playlistId);
                          },
                        ),
                        30.verticalSpace,
                        if (controller.getPlayListSongModel.value?.data?.songs
                                ?.isNotEmpty ??
                            false)
                          Expanded(
                            child: ListView.builder(
                                controller: controller.scrollControllerFor1,
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.getPlayListSongModel.value
                                        ?.data?.songs?.length ??
                                    1,
                                itemBuilder: (context, index) {
                                  return SongListWidget(
                                      gifWidget: Get.find<HomeController>()
                                              .audioPlayer
                                              .current
                                              .hasValue &&
                                          controller
                                                  .getPlayListSongModel
                                                  .value
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
                                          playlistScreen: true,
                                          favoritesScreen: controller
                                                  .getPlayListSongModel
                                                  .value
                                                  ?.data
                                                  ?.songs?[index]
                                                  .isFavourite ??
                                              false,
                                          onFavorites: () {
                                            Get.find<HomeController>()
                                                .addRemoveSongFromFavourites(
                                                    type: 'song',
                                                    assestsDataIndex: index,
                                                    menuId: controller
                                                            .getPlayListSongModel
                                                            .value
                                                            ?.data
                                                            ?.songs?[index]
                                                            .menuId ??
                                                        0,
                                                    songId: controller
                                                            .getPlayListSongModel
                                                            .value
                                                            ?.data
                                                            ?.songs?[index]
                                                            .id ??
                                                        0);
                                            Get.back();
                                          },
                                          onPlaylist: () {
                                            controller.deleteSongFromPlaylist(
                                                playlistId: playlistId,
                                                songId: controller
                                                        .getPlayListSongModel
                                                        .value
                                                        ?.data
                                                        ?.songs?[index]
                                                        .id ??
                                                    0);
                                          },
                                        ));
                                      },
                                      onTap: () {
                                        AppConst.liveVideoUrl.value = false;
                                        Get.find<HomeController>().playSong(
                                            assests: controller
                                                .getPlayListSongModel
                                                .value
                                                ?.data
                                                ?.songs as List<Items>,
                                            index: index);
                                        Navigator.push(context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) {
                                          return SongPlayScreen(
                                            menuId: controller
                                                    .getPlayListSongModel
                                                    .value
                                                    ?.data
                                                    ?.songs?[index]
                                                    .menuId ??
                                                0,
                                            songId: controller
                                                    .getPlayListSongModel
                                                    .value
                                                    ?.data
                                                    ?.songs?[index]
                                                    .id ??
                                                0,
                                            // index: index ?? 0,
                                            // assests: items as List<AssestsSong>,
                                          );
                                        }));
                                      },
                                      imageUrl: controller
                                              .getPlayListSongModel
                                              .value
                                              ?.data
                                              ?.songs?[index]
                                              .songImage ??
                                          '',
                                      title: controller
                                              .getPlayListSongModel
                                              .value
                                              ?.data
                                              ?.songs?[index]
                                              .songName ??
                                          '',
                                      subTitle: controller
                                              .getPlayListSongModel
                                              .value
                                              ?.data
                                              ?.songs?[index]
                                              .songArtist ??
                                          '');
                                }),
                          )
                        else
                          // SizedBox(
                          //   height: 140,
                          //   width: 250,
                          //   child: Image.asset(
                          //     AppAssets.addToFavoritesButton,
                          //     fit: BoxFit.fill,
                          //   ),
                          // )
                          Column(
                            children: [
                              const AppTextWidget(
                                txtTitle: "No Song Found in Playlist",
                                txtColor: AppColors.appButton,
                                fontSize: 20,
                              ),
                              20.verticalSpace,
                              InkWell(
                                onTap: () {
                                  AppConst.currentTabIndex = 0;
                                  // Navigator.push(
                                  //     context,
                                  //     PageRouteBuilder(
                                  //         pageBuilder: (_, __, ___) =>
                                  //             AppNavigationScreen()));

                                  Get.find<BaseController>().update();
                                },
                                child: SizedBox(
                                  height: 140,
                                  width: 250,
                                  child: Image.asset(
                                    AppAssets.addToFavoritesButton,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              )
                            ],
                          )
                      ],
                    );
                  }),
            ),
          ),
          Obx(() => Visibility(
              visible: Get.find<HomeController>().loader.value,
              child: const AppLoder()))
        ],
      ),
    );
  }
}
