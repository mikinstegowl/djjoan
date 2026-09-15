import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Network/AppChopperClient.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppSearchField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/AddPlaylistDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SongAddToDialog.dart';
import 'package:new_music_app/Utils/Widgets/SongListWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/Widgets/SearchAlbumTab.dart';
import 'package:new_music_app/View/VideoScreen/VideoWatchScreen.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryItemModel.dart';

class SearchScreen extends GetView<MenuPageController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
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
              child: DefaultTabController(
                length: 3,
                child: GetBuilder<MenuPageController>(
                    init: controller,
                    builder: (controller) {
                      return Column(
                        children: [
                          const TitleBackButtonWidget(title: 'Search'),
                          5.verticalSpace,
                          AppSearchField(
                            onSearch: () async {
                              controller.showLoader(true);
                              await controller.searchAPi(
                                  homeChopperService: AppChopperClient()
                                      .getChopperService<HomeChopperService>(),
                                  searchText:
                                      controller.globalSearchController.text);
                              // await controller.albumSearchApi();
                              // await controller.videoSearchApi();
                              controller.showLoader(false);
                            },
                            controller: controller.globalSearchController,
                            hintFontSize: 16,
                          ),
                          5.verticalSpace,
                          const Divider(
                            color: AppColors.error,
                          ),
                          InkWell(
                            onTap: () {
                              controller.searchDataModel.value?.data?.musics
                                  ?.clear();
                              controller.searchDataModel.value?.data?.albums
                                  ?.clear();
                              controller.searchDataModel.value?.data?.videos
                                  ?.clear();
                              controller.globalSearchController.clear();
                              controller.update();
                            },
                            child: const Center(
                                child: AppTextWidget(
                              txtTitle: 'Clear Result',
                              txtColor: AppColors.appButton,
                            )),
                          ),
                          const Divider(
                            color: AppColors.appButton,
                          ),
                          if ((controller.searchDataModel.value?.data?.musics?.isNotEmpty ?? false) ||
                              (controller.searchDataModel.value?.data?.albums
                                      ?.isNotEmpty ??
                                  false) ||
                              (controller.searchDataModel.value?.data?.videos
                                      ?.isNotEmpty ??
                                  false))
                            Container(
                              clipBehavior: Clip.hardEdge,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  color: AppColors.textFormFieldTextColor,
                                  borderRadius: BorderRadius.circular(18.r)),
                              child: TabBar(
                                dividerColor: AppColors.transparent,
                                indicatorWeight: 0,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                    color: AppColors.appButton,
                                    borderRadius: BorderRadius.circular(18.r),
                                    border:
                                        Border.all(color: AppColors.appButton)),
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white,
                                tabs: const [
                                  Tab(
                                    text: "Songs",
                                  ),
                                  Tab(
                                    text: "Album",
                                  ),
                                  Tab(
                                    text: "Videos",
                                  )
                                ],
                              ),
                            ),
                          // if (controller.searchDataModel.value?.data?.musics?.isNotEmpty ??
                          //     false)
                          Expanded(
                            child: TabBarView(
                              children: [
                                SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      20.verticalSpace,
                                      controller.searchDataModel.value?.data
                                                  ?.musics?.isNotEmpty ??
                                              false
                                          ? ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount: controller
                                                      .searchDataModel
                                                      .value
                                                      ?.data
                                                      ?.musics
                                                      ?.length ??
                                                  0,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return SongListWidget(
                                                  gifWidget: Get.find<
                                                              HomeController>()
                                                          .audioPlayer
                                                          .current
                                                          .hasValue &&
                                                      controller
                                                              .searchDataModel
                                                              .value
                                                              ?.data
                                                              ?.musics?[index]
                                                              .songName ==
                                                          Get.find<
                                                                  HomeController>()
                                                              .audioPlayer
                                                              .current
                                                              .value
                                                              ?.audio
                                                              .audio
                                                              .metas
                                                              .title,
                                                  onOptionTap: () {
                                                    Get.dialog(SongAddToDialog(
                                                      favoritesScreen: controller
                                                              .searchDataModel
                                                              .value
                                                              ?.data
                                                              ?.musics?[index]
                                                              .isFavourite ??
                                                          false,
                                                      onFavorites: () {
                                                        Get.find<HomeController>().addRemoveSongFromFavourites(
                                                            assestsDataIndex:
                                                                index,
                                                            type: 'song',
                                                            menuId: controller
                                                                    .searchDataModel
                                                                    .value
                                                                    ?.data
                                                                    ?.musics?[
                                                                        index]
                                                                    .menuId ??
                                                                0,
                                                            songId: controller
                                                                    .searchDataModel
                                                                    .value
                                                                    ?.data
                                                                    ?.musics?[
                                                                        index]
                                                                    .id ??
                                                                0);
                                                        Get.back();
                                                      },
                                                      onPlaylist: () {
                                                        Get.back();
                                                        Get.dialog(
                                                            AddPlaylistDialog(
                                                          menuId: controller
                                                                  .searchDataModel
                                                                  .value
                                                                  ?.data
                                                                  ?.musics?[
                                                                      index]
                                                                  .menuId ??
                                                              0,
                                                          songId: controller
                                                                  .searchDataModel
                                                                  .value
                                                                  ?.data
                                                                  ?.musics?[
                                                                      index]
                                                                  .id ??
                                                              0,
                                                        ));
                                                      },
                                                    ));
                                                  },
                                                  // onTap: () async {
                                                  //   await Get.find<HomeController>()
                                                  //       .playSong(
                                                  //       assests: (controller.searchDataModel.value?.data?.musics ?? [])
                                                  //       .map((music) => Items(
                                                  //     id: music.id,
                                                  //     songName: music.songName,
                                                  //     songArtist: music.songArtist,
                                                  //     songImage: music.songImage,
                                                  //     songUrl: music.songUrl??music.songFile,
                                                  //   )).toList()
                                                  //           ,
                                                  //     index: index
                                                  //   );
                                                  //   Navigator.push(context,
                                                  //       PageRouteBuilder(
                                                  //           pageBuilder:
                                                  //               (_, __, ___) {
                                                  //     return SongPlayScreen(
                                                  //       menuId: controller
                                                  //               .searchDataModel
                                                  //               .value
                                                  //               ?.data?.musics?[index]
                                                  //               .menuId ??
                                                  //           0,
                                                  //       songId:controller
                                                  //           .searchDataModel
                                                  //           .value
                                                  //           ?.data?.musics?[index]
                                                  //               .id ??
                                                  //           0,
                                                  //       // index: index ?? 0,
                                                  //       // assests: assests,
                                                  //     );
                                                  //   }));
                                                  // },
                                                  imageUrl: controller
                                                          .searchDataModel
                                                          .value
                                                          ?.data
                                                          ?.musics?[index]
                                                          .songImage ??
                                                      controller
                                                          .searchDataModel
                                                          .value
                                                          ?.data
                                                          ?.albums?[index]
                                                          .categoryImage ??
                                                      '',
                                                  title: controller
                                                          .searchDataModel
                                                          .value
                                                          ?.data
                                                          ?.musics?[index]
                                                          .songName ??
                                                      controller
                                                          .searchDataModel
                                                          .value
                                                          ?.data
                                                          ?.albums?[index]
                                                          .categoryName ??
                                                      '',
                                                  subTitle: controller
                                                          .searchDataModel
                                                          .value
                                                          ?.data
                                                          ?.musics?[index]
                                                          .songArtist ??
                                                      '',
                                                );
                                              },
                                            )
                                          : const Center(
                                              child: AppTextWidget(
                                                txtTitle: "No Data Found",
                                                fontSize: 24,
                                                txtColor: AppColors.appButton,
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                                controller.searchDataModel.value?.data?.albums
                                            ?.isNotEmpty ??
                                        false
                                    ? const SearchAlbumTab()
                                    : const Center(
                                        child: AppTextWidget(
                                          txtTitle: "No Data Found",
                                          fontSize: 24,
                                          txtColor: AppColors.appButton,
                                        ),
                                      ),
                                SingleChildScrollView(
                                  physics: const ClampingScrollPhysics(),
                                  child: Column(
                                    children: [
                                      20.verticalSpace,
                                      controller.searchDataModel.value?.data
                                                  ?.videos?.isNotEmpty ??
                                              false
                                          ? GridView.builder(
                                              itemCount: controller
                                                      .searchDataModel
                                                      .value
                                                      ?.data
                                                      ?.videos
                                                      ?.length ??
                                                  0,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.only(
                                                  left: 10.w,
                                                  right: 10.w,
                                                  top: 10.h),
                                              shrinkWrap: true,
                                              gridDelegate:
                                                  SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 0.7,
                                                mainAxisSpacing: 15.h,
                                                crossAxisSpacing: 15.w,
                                                crossAxisCount: 2,
                                              ),
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                print(controller
                                                    .searchDataModel
                                                    .value
                                                    ?.data
                                                    ?.videos
                                                    ?.length);
                                                return InkWell(
                                                  onTap: () async {
                                                    await Get.find<
                                                            VideoController>()
                                                        .videoDetailAPi(
                                                            videoId: controller
                                                                    .searchDataModel
                                                                    .value
                                                                    ?.data
                                                                    ?.videos?[
                                                                        index]
                                                                    .id ??
                                                                0);

                                                    Navigator.push(context,
                                                        PageRouteBuilder(
                                                            pageBuilder:
                                                                (_, __, ___) {
                                                      return VideoWatchScreen(
                                                        videosId: controller
                                                                .searchDataModel
                                                                .value
                                                                ?.data
                                                                ?.videos?[index]
                                                                .id ??
                                                            0,
                                                        datas: controller
                                                                .searchDataModel
                                                                .value
                                                                ?.data
                                                                ?.videos
                                                            as List<Videos>,
                                                        videoUrl: Get.find<
                                                                    VideoController>()
                                                                .videoDetailModel
                                                                ?.data
                                                                ?.videosLink ??
                                                            Get.find<
                                                                    VideoController>()
                                                                .videoDetailModel
                                                                ?.data
                                                                ?.videosFile??'',
                                                        videoDescp: controller
                                                            .searchDataModel
                                                            .value
                                                            ?.data
                                                            ?.videos?[index]
                                                            .videosDescription,
                                                        videoTitle: controller
                                                            .searchDataModel
                                                            .value
                                                            ?.data
                                                            ?.videos?[index]
                                                            .videosName,
                                                        // videoData: controller.searchDataModel.value?.data
                                                        //     as i.Data,
                                                      );
                                                    }));
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.r)),
                                                    clipBehavior: Clip.hardEdge,
                                                    child: Stack(
                                                      children: [
                                                        CachedNetworkImageWidget(
                                                          width:
                                                              double.maxFinite,
                                                          height:
                                                              double.maxFinite,
                                                          image: controller
                                                                  .searchDataModel
                                                                  .value
                                                                  ?.data
                                                                  ?.videos?[
                                                                      index]
                                                                  .videosImage ??
                                                              '',
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          padding:
                                                              EdgeInsets.only(
                                                            bottom: 15.h,
                                                          ),
                                                          width:
                                                              double.maxFinite,
                                                          decoration: BoxDecoration(
                                                              gradient: LinearGradient(
                                                                  stops: const [0.6, 0.75, 0.8],
                                                                  begin: Alignment.topCenter,
                                                                  end: Alignment.bottomCenter,
                                                                  colors: [
                                                                    AppColors
                                                                        .transparent,
                                                                    AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.75),
                                                                    AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.89)
                                                                  ])),
                                                          child: AppTextWidget(
                                                            txtTitle: controller
                                                                    .searchDataModel
                                                                    .value
                                                                    ?.data
                                                                    ?.videos?[
                                                                        index]
                                                                    .videosName ??
                                                                '',
                                                            txtColor:
                                                                AppColors.error,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            )
                                          : const Center(
                                              child: AppTextWidget(
                                                txtTitle: "No Data Found",
                                                fontSize: 24,
                                                txtColor: AppColors.appButton,
                                              ),
                                            ),
                                    ],
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
          Obx(() => Visibility(
              visible: controller.loader.value, child: const AppLoder()))
        ],
      ),
    );
  }
}
