import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/AuthController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class ChangePasswordScreen extends GetView<AuthController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.smokeBlack,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(0.h),
          child: const Divider(
            color: AppColors.appButton,
          ),
        ),
        toolbarHeight: 70.h,
        leadingWidth: 70.w,
        backgroundColor: AppColors.smokeBlack,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 20.r,
                color: AppColors.white,
              ),
            ),
            const AppTextWidget(
              txtTitle: 'Back',
              txtColor: AppColors.white,
              fontSize: 16,
            )
          ],
        ),
        centerTitle: true,
        title: const AppTextWidget(
          txtTitle: "Change Password",
          fontSize: 18,
          txtColor: AppColors.white,
        ),
      ),
      body: GetBuilder<AuthController>(
          init: controller,
          builder: (context) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        30.verticalSpace,
                        Image.asset(
                          AppAssets.alajazaLogo,
                          width: 300.w,
                          height: 100.h,
                        ),
                        50.verticalSpace,
                        AppTextFormField(
                          controller: controller.currentPassword,
                          hintText: 'Enter Current Password',
                          titleText: "Current Password".toUpperCase(),
                          titleTextColor: AppColors.white.withOpacity(0.6),
                          hintTextColor: AppColors.textFormFieldTextColor,
                          obscureText: Get.find<AuthController>()
                              .showCurrentPassword
                              .value,
                          suffixWidget: InkWell(
                            onTap: () {
                              Get.find<AuthController>()
                                      .showCurrentPassword
                                      .value =
                                  !Get.find<AuthController>()
                                      .showCurrentPassword
                                      .value;
                              Get.find<AuthController>().update();
                            },
                            child: Get.find<AuthController>()
                                    .showCurrentPassword
                                    .value
                                ? Transform.flip(
                                    flipX: true,
                                    child: Icon(Icons.visibility_off,
                                        size: 35.r,
                                        color:
                                            AppColors.textFormFieldTextColor),
                                  )
                                : Icon(Icons.remove_red_eye,
                                    size: 35.r,
                                    color: AppColors.textFormFieldTextColor),
                          ),
                        ),
                        30.verticalSpace,
                        AppTextFormField(
                          textColor: Colors.white,
                          controller:
                              Get.find<AuthController>().passwordController,
                          textInputAction: TextInputAction.done,
                          hintText: "Enter New password",
                          titleText: 'NEW PASSWORD',
                          titleTextColor: AppColors.white.withOpacity(0.6),
                          obscureText:
                              Get.find<AuthController>().showPassword.value,
                          hintTextColor: AppColors.textFormFieldTextColor,
                          suffixWidget: InkWell(
                            onTap: () {
                              Get.find<AuthController>().showPassword.value =
                                  !Get.find<AuthController>()
                                      .showPassword
                                      .value;
                              Get.find<AuthController>().update();
                            },
                            child: Get.find<AuthController>().showPassword.value
                                ? Transform.flip(
                                    flipX: true,
                                    child: Icon(Icons.visibility_off,
                                        size: 35.r,
                                        color:
                                            AppColors.textFormFieldTextColor),
                                  )
                                : Icon(Icons.remove_red_eye,
                                    size: 35.r,
                                    color: AppColors.textFormFieldTextColor),
                          ),
                        ),
                        30.verticalSpace,
                        AppTextFormField(
                          textColor: Colors.white,
                          controller: Get.find<AuthController>()
                              .confirmPasswordController,
                          textInputAction: TextInputAction.done,
                          hintText: "Enter Confirm password",
                          titleText: 'Confirm PASSWORD'.toUpperCase(),
                          titleTextColor: AppColors.white.withOpacity(0.6),
                          obscureText: Get.find<AuthController>()
                              .showConfirmPassword
                              .value,
                          hintTextColor: AppColors.textFormFieldTextColor,
                          suffixWidget: InkWell(
                            onTap: () {
                              Get.find<AuthController>()
                                      .showConfirmPassword
                                      .value =
                                  !Get.find<AuthController>()
                                      .showConfirmPassword
                                      .value;
                              Get.find<AuthController>().update();
                            },
                            child: Get.find<AuthController>().showPassword.value
                                ? Transform.flip(
                                    flipX: true,
                                    child: Icon(Icons.visibility_off,
                                        size: 35.r,
                                        color:
                                            AppColors.textFormFieldTextColor),
                                  )
                                : Icon(Icons.remove_red_eye,
                                    size: 35.r,
                                    color: AppColors.textFormFieldTextColor),
                          ),
                        ),
                        60.verticalSpace,
                        AppButtonWidget(
                          onPressed: () {
                            if (Get.find<AuthController>()
                                        .confirmPasswordController
                                        .text ==
                                    Get.find<AuthController>()
                                        .passwordController
                                        .text &&
                                Get.find<AuthController>()
                                        .confirmPasswordController
                                        .text !=
                                    '' &&
                                Get.find<AuthController>()
                                        .passwordController
                                        .text !=
                                    '' &&
                                controller.currentPassword.text != '') {
                              controller.changePasswordAPi(
                                  currentPassword:
                                      controller.currentPassword.text,
                                  newPassword: Get.find<AuthController>()
                                      .confirmPasswordController
                                      .text);
                            } else {
                              Utility.showSnackBar('Password Does Not Match',
                                  isError: true);
                            }
                          },
                          btnName: "Submit",
                          width: double.maxFinite,
                          borderRadius: 12,
                          margin: EdgeInsets.symmetric(horizontal: 20.h),
                          btnColor: AppColors.appButton,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(visible: controller.loader.value, child: const AppLoder())
              ],
            );
          }),
    ));
  }
}
