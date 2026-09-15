import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class NoExistingPlayListFoundDialog extends StatelessWidget {
  final Function() onCreateNew;

  const NoExistingPlayListFoundDialog({super.key, required this.onCreateNew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: AlertDialog.adaptive(
        insetPadding: EdgeInsets.zero,
        backgroundColor: AppColors.smokeBlack,
        content: const SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppTextWidget(
                txtTitle: 'No Existing Playlist Found !!',
                fontWeight: FontWeight.w500,
                txtColor: AppColors.white,
                fontSize: 18,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButtonWidget(
                onPressed: onCreateNew,
                btnName: "Create New",
                btnColor: AppColors.appButton,
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              ),
              AppButtonWidget(
                onPressed: () {
                  Get.back();
                },
                btnName: "Cancel",
                width: 100.w,
                btnColor: AppColors.appButton,
                margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              )
            ],
          ),
        ],
      ),
    );
  }
}
