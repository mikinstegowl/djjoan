import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onSearch;
  final Function(String)? onChanged;
  final double? hintFontSize;

  const AppSearchField(
      {super.key,
      this.onChanged,
      required this.controller,
      this.hintFontSize,
      this.onSearch});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 5.h, bottom: 5.h, left: 10.w),
          hintText: 'Search',
          hintStyle:
              TextStyle(color: AppColors.grey, fontSize: hintFontSize ?? 25),
          filled: true,
          fillColor: AppColors.white,
          suffixIcon: InkWell(
            onTap: onSearch,
            child: Padding(
              padding: EdgeInsets.only(top: 5.h, bottom: 5.h, right: 10.w),
              child: Container(
                width: 80.w,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(10.r)),
                child: Center(
                  child: AppTextWidget(
                    txtTitle: 'Search'.toUpperCase(),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    txtColor: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          prefixIcon: InkWell(
            onTap: onSearch,
            child: Padding(
              padding: EdgeInsets.all(10.r),
              child: Image.asset(
                AppAssets.search,
                height: 5.h,
                width: 5.w,
                fit: BoxFit.contain,
              ),
            ),
          ),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(18.r))),
    );
  }
}
