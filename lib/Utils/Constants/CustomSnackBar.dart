import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

import 'package:new_music_app/Utils/Styling/AppColors.dart';

///Custom SnackBar
class Utility {
  static void showSnackBar(String? msg, {bool isError = false}) {
    if (Get.context != null) {
      final messenger = ScaffoldMessenger.maybeOf(Get.context!);
      if (messenger != null) {
        messenger.clearSnackBars();
        messenger.showSnackBar(
          SnackBar(
            content: AppTextWidget(
                txtTitle: msg ?? '',
                fontWeight: FontWeight.w400,
                fontSize: 14,
                maxLine: 3,
                txtColor: AppColors.white),
            backgroundColor: Color(isError ? 0xffF72A1E : 0xff5BDF6F),
            duration: const Duration(milliseconds: 1000),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(8.r),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        );
        return;
      }
    }
    
    Get.showSnackbar(
      GetSnackBar(
        maxWidth: 600.w,
        messageText: AppTextWidget(
            txtTitle: msg ?? '',
            fontWeight: FontWeight.w400,
            fontSize: 14,
            maxLine: 3,
            txtColor: AppColors.white),
        borderRadius: 10.r,
        duration: const Duration(milliseconds: 1000),
        margin: EdgeInsets.all(8.r),
        dismissDirection: DismissDirection.horizontal,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        backgroundColor: Color(isError ? 0xffF72A1E : 0xff5BDF6F),
      ),
    );
  }
}
