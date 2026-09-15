import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class SocialMediaContainer extends StatelessWidget {
  final String icons;
  final String? title;
  final Function()? onTap;

  const SocialMediaContainer(
      {super.key, required this.icons, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.w),
        decoration: BoxDecoration(
            color: AppColors.textFormFieldColor,
            borderRadius: BorderRadius.circular(20.r)),
        padding: EdgeInsets.all(8.r),
        child: ListTile(
            title: AppTextWidget(
              txtTitle: title ?? "",
              fontSize: 18,
              txtColor: Colors.white,
            ),
            leading: Image.asset(
              icons,
              height: 35.h,
              width: 35.h,
            )),
      ),
    );
  }
}
