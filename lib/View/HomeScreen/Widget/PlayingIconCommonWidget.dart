import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class PlayingIconCommonWidget extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final String? image;
  final bool isIcon;
  final String? subTitle;
  final double? iconSize;
  final double? imageHeight;
  final double? imageWidth;
  final Color? iconColor;
  final Color? imageColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final bool liked;
  final Function()? onTap;

  const PlayingIconCommonWidget(
      {super.key,
      this.title,
      this.onTap,
      this.icon,
      this.image,
      this.isIcon = false,
      this.liked = false,
      this.subTitle,
      this.iconSize,
      this.imageHeight,
      this.imageWidth,
      this.iconColor,
      this.imageColor,
      this.titleColor,
      this.subTitleColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap ?? () {},
          child: isIcon
              ? Icon(
                  icon,
                  size: iconSize?.r ?? 30.r,
                  color: liked ? AppColors.appButton : AppColors.white,
                )
              : Image.asset(
                  image ?? '',
                  height: imageHeight?.h,
                  width: imageWidth?.w,
                  color: imageColor,
                ),
        ),
        AppTextWidget(
          txtTitle: title ?? '',
          txtColor: titleColor ?? AppColors.white,
        ),
        AppTextWidget(
          txtTitle: subTitle ?? '0',
          txtColor: subTitleColor ?? AppColors.white,
        ),
      ],
    );
  }
}
