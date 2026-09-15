import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';

class SearchAlbumTab extends GetView<MenuPageController> {
  const SearchAlbumTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.only(top: 10.h, left: 10.h, right: 10.h),
        itemCount: controller.searchDataModel.value?.data?.albums?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 15.w, crossAxisCount: 2, mainAxisExtent: 260),
        itemBuilder: (context, index) {
          print(controller.searchDataModel.value?.data?.albums?[index].categoryImage);
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                // onTap: () {
                //   Get.find<HomeController>().playSong(
                //       assests: items
                //               as List<AssestsSong> ??
                //           [],
                //       index: index);
                //   Navigator.push(context,
                //       PageRouteBuilder(
                //           pageBuilder: (_, __, ___) {
                //     return SongPlayScreen(
                //         // index: index ?? 0,
                //         // assests: items as List<AssestsSong>,
                //         );
                //   }));
                // },
                child: Container(
                  height: 195,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.grey,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImageWidget(
                    fit: BoxFit.fill,
                    image:
                        controller.searchDataModel.value?.data?.albums?[index].categoryImage ?? '',
                  ),
                ),
              ),
              3.verticalSpace,
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: AppTextWidget(
                    fontSize: 14,
                    maxLine: 2,
                    txtTitle: controller.searchDataModel.value?.data?.albums?[index]
                            .categoryName ??
                        '',
                    txtColor: AppColors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              3.verticalSpace,
              AppTextWidget(
                fontSize: 12,
                txtTitle: controller.searchDataModel.value?.data?.albums?[index]
                        .categoryName ??
                    '',
                txtColor: AppColors.error,
                fontWeight: FontWeight.w300,
              ),
              3.verticalSpace
            ],
          );
        });
  }
}
