import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/PlayListController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class ExistingPlayListDialog extends StatelessWidget {
  final int menuId;
  final int songId;

  const ExistingPlayListDialog({
    super.key,
    required this.menuId,
    required this.songId,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.smokeBlack,
      insetPadding: EdgeInsets.symmetric(horizontal: 15.w),
      title: const Center(
        child: AppTextWidget(
          txtTitle: 'Choose Playlist',
          fontWeight: FontWeight.w600,
          fontSize: 18,
          txtColor: AppColors.white,
        ),
      ),
      content: Container(
        // height: MediaQuery.sizeOf(context).height,
        width: double.maxFinite,
        constraints: BoxConstraints(
          maxHeight: 400.h,
        ),
        child: GetBuilder<PlayListController>(
            init: Get.find<PlayListController>(),
            initState: (state) {
              Get.find<PlayListController>().getPlayListAPi();
            },
            builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: ListView.builder(
                        itemCount: Get.find<PlayListController>()
                                .getPlayListModel
                                .value
                                ?.data
                                ?.length ??
                            0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              AppButtonWidget(
                                onPressed: () {
                                  final playlistId =
                                      Get.find<PlayListController>()
                                          .getPlayListModel
                                          .value
                                          ?.data?[index]
                                          .id;

                                  if (playlistId != null) {
                                    Get.find<HomeController>()
                                        .addSongToPlaylistAPi(
                                      menuId: menuId,
                                      songId: songId,
                                      playlistId: playlistId,
                                    );
                                  } else {
                                    Get.snackbar(
                                        "Error", "Playlist ID not found");
                                  }
                                },
                                width: double.maxFinite,
                                btnColor: AppColors.black,
                                btnName: Get.find<PlayListController>()
                                        .getPlayListModel
                                        .value
                                        ?.data?[index]
                                        .playlistName ??
                                    '',
                              ),
                              if (Get.find<PlayListController>()
                                      .getPlayListModel
                                      .value
                                      ?.data
                                      ?.length !=
                                  index + 1)
                                const Divider()
                            ],
                          );
                        }),
                  )
                ],
              );
            }),
      ),
      actions: [
        AppButtonWidget(
          onPressed: () {
            Get.back();
          },
          btnName: 'Cancel',
          btnColor: AppColors.appButton,
          width: double.maxFinite,
        )
      ],
    );
  }
}
