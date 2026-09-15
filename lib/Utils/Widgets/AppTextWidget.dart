import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';

class AppTextWidget extends StatelessWidget {
  const AppTextWidget(
      {super.key,
      required this.txtTitle,
      this.txtColor = AppColors.black,
      this.fontWeight = FontWeight.w400,
      this.fontStyle = FontStyle.normal,
      this.fontSize = 14,
      this.maxLine = 10,
      this.textAlign = TextAlign.left,
      this.overflow = TextOverflow.ellipsis,
      this.decoration = TextDecoration.none,
      this.fontFamily,
      this.letterSpacing});

  final String txtTitle;
  final Color txtColor;
  final FontWeight fontWeight;

  // String fontFamily = AppTheme.robotoRegular,
  final FontStyle fontStyle;
  final double fontSize;
  final int maxLine;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final TextDecoration decoration;
  final String? fontFamily;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Text(
      txtTitle.tr,
      maxLines: maxLine,
      style: TextStyle(
        letterSpacing: letterSpacing,
        color: txtColor,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontSize: fontSize.sp,
        decoration: decoration,
        decorationColor: AppColors.white,
        decorationThickness: 2,
        fontFamily: fontFamily,
      ),
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}
