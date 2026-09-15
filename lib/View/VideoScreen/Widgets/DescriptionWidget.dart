import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryItemModel.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';
import 'package:new_music_app/View/VideoScreen/VideoWatchScreen.dart';

class DescriptionWidget extends StatefulWidget {
  final String videoDescription;
  final int videoId;
  final String? videoTitle;
  final Data? videoData;
  final List<Videos> datas;

  const DescriptionWidget(
      {super.key,
      required this.videoDescription,
      this.videoTitle,
      this.videoData,
      required this.datas,
      required this.videoId});

  @override
  State<DescriptionWidget> createState() => _DescriptionWidgetState();
}

class _DescriptionWidgetState extends State<DescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.verticalSpace,
              const AppTextWidget(
                txtTitle: 'Description',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                txtColor: AppColors.white,
              ),
              5.verticalSpace,
              AppTextWidget(
                txtTitle: widget.videoDescription,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                txtColor: AppColors.white,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      // Get.find<VideoController>().videoDetailModel?.data?.isFavourite =
                      await Get.find<HomeController>()
                          .addRemoveSongFromFavourites(
                              songId: widget.videoId, type: 'video');
                      setState(() {});
                    },
                    child: Icon(
                      Get.find<VideoController>()
                                  .videoDetailModel
                                  ?.data
                                  ?.isFavourite ??
                              false
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: Get.find<VideoController>()
                                  .videoDetailModel
                                  ?.data
                                  ?.isFavourite ??
                              false
                          ? AppColors.appButton
                          : AppColors.white,
                      size: 29.r,
                    ),
                  ),
                  5.horizontalSpace,
                  const AppTextWidget(
                    txtTitle: 'Favorites',
                    txtColor: AppColors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
              10.verticalSpace,
              const AppTextWidget(
                txtTitle: 'Suggested Videos',
                txtColor: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              10.verticalSpace,
              if (widget.datas.length > 1)
                Expanded(
                  child: SizedBox(
                    height: 200.h,
                    child: GridView.builder(
                      itemCount: widget.datas.length > 1
                          ? (widget.datas.length - 1)
                          : 1,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        childAspectRatio: 1.6,
                        mainAxisSpacing: 15.h,
                        crossAxisSpacing: 15.w,
                        // crossAxisCount: 2,
                        maxCrossAxisExtent: 800.w,
                      ),
                      itemBuilder: (context, index) {
                        List<Videos> videoData1 = [];
                        videoData1.addAll(widget.datas);
                        videoData1.removeWhere(
                            (element) => element.id == widget.videoId);

                        return InkWell(
                          onTap: () async {
                            print(videoData1[index].id);
                            await Get.find<VideoController>().videoDetailAPi(
                                videoId: videoData1[index].id ?? 0);
                            Navigator.pushReplacement(context,
                                PageRouteBuilder(pageBuilder: (_, __, ___) {
                              return VideoWatchScreen(
                                videoDescp:
                                    videoData1[index].videosDescription ?? '',
                                videoTitle: videoData1[index].videosName ?? '',
                                videoUrl: Get.find<VideoController>()
                                        .videoDetailModel
                                        ?.data
                                        ?.videosFile ??
                                    Get.find<VideoController>()
                                        .videoDetailModel
                                        ?.data
                                        ?.videosLink ??
                                    '',
                                datas: widget.datas,
                                // videoData: widget.videoData,
                                videosId: videoData1[index].id ?? 0,
                              );
                            }));
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
                                  image: videoData1[index].videosImage ?? '',
                                  fit: BoxFit.cover,
                                ),
                                Container(
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.only(
                                    bottom: 25.h,
                                  ),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          stops: const [0.6, 0.75, 0.8],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            AppColors.transparent,
                                            AppColors.black.withOpacity(0.75),
                                            AppColors.black.withOpacity(0.89)
                                          ])),
                                  child: AppTextWidget(
                                    txtTitle:
                                        videoData1[index].videosName ?? '',
                                    txtColor: AppColors.error,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              else
                const Flexible(
                  child: Center(
                    child: AppTextWidget(
                      txtTitle: 'No Data Found !!',
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      txtColor: AppColors.white,
                    ),
                  ),
                ),
              20.verticalSpace,
            ],
          ),
        ),
      ],
    );
  }
}
