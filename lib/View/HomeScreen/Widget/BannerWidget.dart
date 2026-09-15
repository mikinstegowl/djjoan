import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';

class BannerWidget extends GetView<HomeController> {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: controller,
        builder: (controller) {
          return Column(
            children: [
              CarouselSlider.builder(
                itemCount: controller.banner.value?.data?.length ?? 1,
                options: CarouselOptions(
                  onPageChanged: (index, reason) {
                    controller.bannerIndex.value = index;
                    controller.update();
                  },
                  aspectRatio: 2.5 / 1,
                  initialPage: 0,
                  // height: 100.h,
                  padEnds: false,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  // autoPlayInterval: const Duration(seconds: 3),
                  autoPlay: true,
                ),
                itemBuilder: (context, index, realIndex) =>
                    controller.banner.value?.data?.isNotEmpty ?? false
                        ? CachedNetworkImageWidget(
                            fit: BoxFit.fill,
                            image:
                                controller.banner.value?.data?[index].image ?? '',
                          )
                        : const SizedBox(),
              ),
              5.verticalSpace,
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: controller.banner.value?.data?.map((e) {
                        int? index = controller.banner.value?.data?.indexOf(e);
                        return Container(
                          width: 8.h,
                          height: 8.h,
                          margin: EdgeInsets.symmetric(
                              vertical: 8.h, horizontal: 4.w),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: index == controller.bannerIndex.value
                                  ? AppColors.appButton
                                  : AppColors.white),
                        );
                      }).toList() ??
                      []),
            ],
          );
        });
    // Column(
    //   children: [
    //     CarouselSlider(
    //       items: imageSliders,
    //       carouselController: _controller,
    //       options: CarouselOptions(
    //         height: 130.h,
    //         autoPlay: true,
    //         viewportFraction: 1,
    //         enlargeCenterPage: true,
    //       ),
    //     ),
    //     5.verticalSpace,
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: imgList.asMap().entries.map((entry) {
    //         return GestureDetector(
    //           onTap: () => _controller.animateToPage(entry.key),
    //           child: Container(
    //             width: 12.h,
    //             height: 12.h,
    //             margin:
    //                 const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
    //             decoration: const BoxDecoration(
    //                 shape: BoxShape.circle, color: Colors.white),
    //           ),
    //         );
    //       }).toList(),
    //     ),
    //   ],
    // );
  }
}
