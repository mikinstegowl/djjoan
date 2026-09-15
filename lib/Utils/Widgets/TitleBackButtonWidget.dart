import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class TitleBackButtonWidget extends StatelessWidget {
  final String? title;
  final bool iconShow;
  final Widget? customTitle;
  final bool? contactUs;
  final Function()? onTap;

  const TitleBackButtonWidget(
      {super.key,
      this.title,
      this.onTap,
      this.contactUs = true,
      this.iconShow = true,
      this.customTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: InkWell(
        onTap: onTap ??
            () {
              Get.back();
            },
        child: iconShow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    color: AppColors.appButton,
                    AppAssets.backIcon,
                    height: 20.h,
                  ),
                  10.horizontalSpace,
                  AppTextWidget(
                    txtTitle: title ?? '',
                    fontSize: 16,
                    txtColor:
                        contactUs ?? false ? AppColors.white : AppColors.black,
                  )
                ],
              )
            : customTitle,
      ),
    );
  }
}
