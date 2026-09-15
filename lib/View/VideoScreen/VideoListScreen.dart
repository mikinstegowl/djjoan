import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/View/VideoScreen/VideoShowCategoryScreen.dart';

class VideoListScreen extends GetView<VideoController> {
  const VideoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: double.maxFinite,
        decoration: const BoxDecoration(
            color: AppColors.appButton,
            image: DecorationImage(
                image: AssetImage(
                  AppAssets.blackBackgroundScreen,
                ),
                fit: BoxFit.cover)),
        child: Stack(
          children: [
            GetBuilder<VideoController>(
                init: controller,
                builder: (controller) {
                  return SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (controller.videoCategoryModel.value?.data
                                ?.isNotEmpty ??
                            false)
                          GridView.builder(
                            controller: controller.scrollControllerForVideoCategory,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.w, vertical: 5.h),
                              itemCount: controller.videoCategoryModel.value
                                      ?.data?.length ??
                                  0,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 1.6,
                                      crossAxisSpacing: 15.w,
                                      mainAxisSpacing: 10.h),
                              itemBuilder: (context, index) {
                                if (controller
                                        .videoCategoryModel.value?.data !=
                                    null) {
                                  return InkWell(
                                    onTap: () async {
                                      AppConst.liveVideoUrl.value = false;
                                      await controller.videoCategoryListApi(
                                          categoryId: controller
                                                  .videoCategoryModel
                                                  .value
                                                  ?.data?[index]
                                                  .categoryId ??
                                              0);
                                      Navigator.push(context, PageRouteBuilder(
                                          pageBuilder: (BuildContext context,
                                              Animation<double> animation,
                                              Animation<double>
                                                  secondaryAnimation) {
                                        return VideoShowCategoryListScreen(
                                          title: controller
                                                  .videoCategoryModel
                                                  .value
                                                  ?.data?[index]
                                                  .categoryName ??
                                              '',
                                        );
                                      }));
                                    },
                                    child: Stack(
                                      children: [
                                        CachedNetworkImageWidget(
                                          width: double.maxFinite,
                                          image: controller
                                                  .videoCategoryModel
                                                  .value
                                                  ?.data?[index]
                                                  .categoryImage ??
                                              '',
                                          fit: BoxFit.cover,
                                        ),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          padding: EdgeInsets.only(
                                              left: 20.w,
                                              bottom: 10.h,
                                              right: 10.w),
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  stops: const [0.6, 0.75, 0.8],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    AppColors.transparent,
                                                    AppColors.black
                                                        .withOpacity(0.55),
                                                    AppColors.black
                                                        .withOpacity(0.75)
                                                  ])),
                                          child: Row(children: [
                                            Expanded(
                                              flex: 6,
                                              child: AppTextWidget(
                                                txtTitle: controller
                                                        .videoCategoryModel
                                                        .value
                                                        ?.data?[index]
                                                        .categoryName ??
                                                    '',
                                                txtColor: AppColors.white,
                                                fontSize: 12,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            const Flexible(
                                              child: Icon(
                                                Icons.play_arrow,
                                                color: AppColors.white,
                                                size: 29,
                                              ),
                                            )
                                          ]),
                                        )
                                      ],
                                    ),
                                  );
                                } else {
                                  return const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: AppTextWidget(
                                        txtTitle: 'No Data Found !!',
                                        fontSize: 20,
                                        txtColor: AppColors.white,
                                      )),
                                    ],
                                  );
                                }
                              })
                        else
                          Flexible(
                            child: SizedBox(
                              height: MediaQuery.sizeOf(context).height,
                              child: const Center(
                                child: AppTextWidget(
                                  txtTitle: 'No Data Found !!',
                                  fontSize: 20,
                                  txtColor: AppColors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
            Obx(() => Visibility(
                visible: controller.loader.value, child: const AppLoder()))
          ],
        ),
      ),
    );
  }
}
