import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
            size: 30,
          ),
        ),
        centerTitle: true,
        title: const AppTextWidget(
          txtTitle: "Forgot Password",
          fontSize: 18,
          txtColor: AppColors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        width: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(AppAssets.blackBackgroundScreen),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            const Spacer(),
            Image.asset(
              AppAssets.alajazaLogo,
              width: 250.w,
            ),
            100.verticalSpace,
            const AppTextFormField(
              hintText: 'Enter email address',
              titleText: 'EMAIL',
              hintTextColor: AppColors.textFormFieldTextColor,
            ),
            100.verticalSpace,
            AppButtonWidget(
              width: double.maxFinite,
              onPressed: () {},
              btnName: 'SUBMIT',
              borderRadius: 20,
              btnColor: AppColors.appButton,
              padding: EdgeInsets.symmetric(vertical: 20.w),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
