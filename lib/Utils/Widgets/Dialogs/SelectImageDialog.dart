
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class UploadImageDialog extends StatelessWidget {
  const UploadImageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(BaseController());
    return AlertDialog.adaptive(
      backgroundColor: AppColors.smokeBlack,
      title: const Center(
        child: AppTextWidget(
          txtColor: AppColors.white,
          txtTitle: 'Select the Action',
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: EdgeInsets.zero,
      actions: [
        Column(
          children: [
            AppButtonWidget(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              onPressed: () async {
                await Get.find<BaseController>().getFile();
                Get.back();
              },
              btnName: "Select Photo From Gallery",
              txtColor: AppColors.appButton,
            ),
            AppButtonWidget(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              onPressed: () async {
                await Get.find<BaseController>().getCameraImage();
                Get.back();
              },
              btnName: "Capture Photo From Camera",
              txtColor: AppColors.appButton,
            ),
            AppButtonWidget(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                onPressed: () {
                  Get.back();
                },
                txtColor: AppColors.appButton,
                btnName: "Cancel"),
          ],
        ),
      ],
    );
  }
}
