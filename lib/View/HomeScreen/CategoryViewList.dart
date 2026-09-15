import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AnimatedBottomsheet.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/View/HomeScreen/SongViewList.dart';

class CategoryViewList extends GetView<HomeController> {
  const CategoryViewList({super.key});

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
                        title:
                            controller.viewAllCategoryModel?.data?.menuName ??
                                '',
                      ),
                      controller.viewAllCategoryModel?.data?.categories
                                  ?.isEmpty ??
                              false
                          ? const Expanded(
                              child: AppTextWidget(
                                txtTitle: "No Data Found !",
                                txtColor: AppColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : Expanded(
                              child: GridView.builder(
                                  controller: controller
                                      .scrollControllerForViewAllCategoryModel,
                                  itemCount: controller.viewAllCategoryModel
                                      ?.data?.categories?.length,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 0.7,
                                          crossAxisSpacing: 10.w),
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        Get.find<HomeController>().page = 1;
                                        await controller.getCategorySongList(
                                            title: controller
                                                    .viewAllCategoryModel
                                                    ?.data
                                                    ?.categories?[index]
                                                    .categoryName ??
                                                '',
                                            id: controller
                                                    .viewAllCategoryModel
                                                    ?.data
                                                    ?.categories?[index]
                                                    .categoryId ??
                                                0,
                                            context: context);
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (_, __, ___) =>
                                                    SongViewList(
                                                      title: controller
                                                              .viewAllCategoryModel
                                                              ?.data
                                                              ?.categories?[
                                                                  index]
                                                              .categoryName ??
                                                          '',
                                                      assests: controller
                                                              .categorySongModel
                                                              ?.data
                                                              ?.songs ??
                                                          [],
                                                    )));
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 120.h,
                                            width: 120.w,
                                            child: CachedNetworkImageWidget(
                                              fit: BoxFit.cover,
                                              image: controller
                                                  .viewAllCategoryModel
                                                  ?.data
                                                  ?.categories?[index]
                                                  .categoryImage,
                                            ),
                                          ),
                                          2.verticalSpace,
                                          AppTextWidget(
                                            txtTitle: controller
                                                    .viewAllCategoryModel
                                                    ?.data
                                                    ?.categories?[index]
                                                    .categoryName ??
                                                '',
                                            txtColor: AppColors.white,
                                            fontSize: 10,
                                            maxLine: 1,
                                          ),
                                          5.verticalSpace,
                                          // AppTextWidget(
                                          //   txtTitle: controller.viewAllCategoryModel?.data?.categories?[index]
                                          //           .categoryName ??
                                          //       '',
                                          //   txtColor: AppColors.white,
                                          //   fontSize: 10,
                                          //   maxLine: 1,
                                          // )
                                        ],
                                      ),
                                    );
                                  }))
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
