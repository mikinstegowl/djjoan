import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/PlayListController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/CreateNewPlaylistDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/ExistingPlayListDialog.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/NoExistingPlayListFoundDialog.dart';

class AddPlaylistDialog extends GetView<HomeController> {
  final int menuId;
  final int songId;

  const AddPlaylistDialog(
      {required this.menuId, required this.songId, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: AlertDialog.adaptive(
        backgroundColor: AppColors.smokeBlack,
        shape: const RoundedRectangleBorder(),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButtonWidget(
                  width: double.maxFinite,
                  onPressed: () {
                    Get.dialog(CreateNewPlaylistDialog(
                      menuId: menuId,
                      songId: songId,
                    ));
                  },
                  txtColor: AppColors.appButton,
                  btnColor: AppColors.transparent,
                  btnName: "Create New PlayList"),
              const Divider(),
              AppButtonWidget(
                  width: double.maxFinite,
                  onPressed: () async {
                    Get.back();
                    controller.showLoader(true);
                    await Get.find<PlayListController>().getPlayListAPi();
                    controller.showLoader(false);
                    if (Get.find<PlayListController>()
                            .getPlayListModel
                            .value
                            ?.data
                            ?.isEmpty ??
                        true) {
                      Get.dialog(NoExistingPlayListFoundDialog(
                        onCreateNew: () {
                          Get.dialog(Container(
                              child: CreateNewPlaylistDialog(
                            menuId: menuId,
                            songId: songId,
                          )));
                        },
                      ));
                    } else {
                      Get.dialog(ExistingPlayListDialog(
                        menuId: menuId,
                        songId: songId,
                      ));
                    }
                  },
                  txtColor: AppColors.appButton,
                  btnColor: AppColors.transparent,
                  btnName: "Add To Existing"),
              const Divider(),
              AppButtonWidget(
                  width: double.maxFinite,
                  txtColor: AppColors.appButton,
                  btnColor: AppColors.transparent,
                  onPressed: () {
                    Get.back();
                  },
                  btnName: "Cancel"),
            ],
          ),
        ),
      ),
    );
  }
}
