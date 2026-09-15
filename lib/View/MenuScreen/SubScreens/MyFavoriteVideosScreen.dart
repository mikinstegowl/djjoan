import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';

class MyFavoriteVideoScreen extends GetView<MenuPageController> {
  const MyFavoriteVideoScreen({super.key});

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
              image: DecorationImage(
                  image: AssetImage(
                    AppAssets.blackBackgroundScreen,
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              const TitleBackButtonWidget(title: 'My Favorite Video'),
              5.verticalSpace,
              GetBuilder<MenuPageController>(
                  init: controller..geFavouriteVideoApi(),
                  builder: (controller) {
                    if (controller
                            .getFavouriteVideoModel.value?.data?.isNotEmpty ??
                        false) {
                      return Flexible(
                        child: GridView.builder(
                          controller: controller.scrollController1,
                          itemCount: controller
                                  .getFavouriteVideoModel.value?.data?.length ??
                              0,
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.7,
                            mainAxisSpacing: 15.h,
                            crossAxisSpacing: 15.w,
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                // Navigator.push(context,
                                //     PageRouteBuilder(pageBuilder: (_, __, ___) {
                                //   return VideoWatchScreen(
                                //     videoData: controller
                                //         .getFavouriteVideoModel.value?.data,
                                //     videosId: controller.favouriteVideoModel.value
                                //             ?.data?[index].videosId ??
                                //         0,
                                //     datas: controller
                                //             .favouriteVideoModel.value?.data ??
                                //         [],
                                //     videoUrl: controller.favouriteVideoModel.value
                                //             ?.data?[index].videosLink ??
                                //         '',
                                //     videoDescp: controller.favouriteVideoModel
                                //         .value?.data?[index].videosDescription,
                                //     videoTitle: controller.favouriteVideoModel
                                //         .value?.data?[index].videosName,
                                //   );
                                // }));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r)),
                                clipBehavior: Clip.hardEdge,
                                child: Stack(
                                  children: [
                                    CachedNetworkImageWidget(
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      image: controller.getFavouriteVideoModel.value
                                              ?.data?[index].videosImage ??
                                          '',
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.only(
                                        bottom: 15.h,
                                      ),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                              stops: const [0.65, 0.75, 0.85],
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                AppColors.transparent,
                                                AppColors.black.withOpacity(0.75),
                                                AppColors.black.withOpacity(0.89)
                                              ])),
                                      child: AppTextWidget(
                                        txtTitle: controller.getFavouriteVideoModel
                                                .value?.data?[index].videosName ??
                                            '',
                                        txtColor: AppColors.error,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 8,
                                      child: InkWell(
                                        onTap: () async {
                                              await Get.find<HomeController>()
                                                  .addRemoveSongFromFavourites(
                                                type: 'video',
                                                      assestsDataIndex: index,
                                                      songId: controller
                                                              .getFavouriteVideoModel
                                                              .value
                                                              ?.data?[index]
                                                              .id ??
                                                          0);
                                          controller
                                              .getFavouriteVideoModel.value?.data
                                              ?.removeWhere((element) =>
                                                  element.id ==
                                                  controller
                                                      .getFavouriteVideoModel
                                                      .value
                                                      ?.data?[index]
                                                      .id);
                                          controller.update();
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: AppColors.appButton,
                                          size: 25.r,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Flexible(
                        child: Center(
                            child: AppTextWidget(
                          txtTitle: 'No Data Found !!',
                          txtColor: AppColors.white,
                          fontSize: 18,
                        )),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
