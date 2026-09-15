import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/AuthController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              actions: [
                SizedBox(
                  width: 100.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.textFormFieldTextColor,
                        ),
                        padding: EdgeInsets.only(
                            top: 3.h, bottom: 3.h, left: 5.w, right: 5.h),
                        child: AppButtonWidget(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            controller.signUpUserAPi(context);
                          },
                          btnName: "",
                          child: Image.asset(AppAssets.menu2),
                        ),
                      ),
                      Container(
                        height: 25.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.textFormFieldTextColor,
                        ),
                        padding: EdgeInsets.only(
                            top: 3.h, bottom: 3.h, left: 5.w, right: 5.h),
                        child: AppButtonWidget(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            controller.signUpUserAPi(context);
                          },
                          btnName: '',
                          child: Image.asset(
                            AppAssets.headPhone,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
              bottom: const PreferredSize(
                preferredSize: Size(double.maxFinite, 1),
                child: Divider(
                  color: AppColors.appButton,
                ),
              ),
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: AppColors.transparent,
            ),
            body: Container(
              height: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: 35.w),
              width: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppAssets.blackBackgroundScreen),
                      fit: BoxFit.cover)),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    60.verticalSpace,
                    Image.asset(
                      AppAssets.alajazaLogo,
                      width: 150.w,
                    ),
                    45.verticalSpace,
                    AppTextFormField(
                      controller: controller.userNameController,
                      hintText: "Enter username or email",
                      titleText: 'USERNAME',
                      textColor: Colors.white,
                      hintTextColor: AppColors.textFormFieldTextColor,
                      textInputAction: TextInputAction.next,
                    ),
                    15.verticalSpace,
                    Obx(() => AppTextFormField(
                          controller: controller.passwordController,
                          textInputAction: TextInputAction.done,
                          hintText: "Enter password",
                          titleText: 'PASSWORD',
                          textColor: Colors.white,
                          obscureText: controller.showPassword.value,
                          hintTextColor: AppColors.textFormFieldTextColor,
                          suffixWidget: InkWell(
                            onTap: () {
                              controller.showPassword.value =
                                  !controller.showPassword.value;
                              controller.update();
                            },
                            child: controller.showPassword.value
                                ? Transform.flip(
                                    child: Icon(Icons.visibility_off,
                                        size: 40.r,
                                        color:
                                            AppColors.textFormFieldTextColor),
                                  )
                                : Icon(Icons.remove_red_eye,
                                    size: 40.r,
                                    color: AppColors.textFormFieldTextColor),
                          ),
                        )),
                    20.verticalSpace,
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.appButton,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(() => Checkbox(
                                value: controller.checkBox.value,
                                onChanged: (value) {
                                  controller.checkBox.value = value ?? false;
                                },
                                fillColor:
                                    WidgetStateProperty.all(AppColors.black),
                              )),
                          const AppTextWidget(
                            txtTitle: 'REMEMBER ME',
                            txtColor: AppColors.white,
                            fontSize: 12,
                          ),
                          15.horizontalSpace
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    AppButtonWidget(
                      width: double.maxFinite,
                      onPressed: () {
                        controller.logInAPi(context);
                      },
                      btnName: 'LOGIN',
                      borderRadius: 20,
                      fontSize: 14,
                      btnColor: AppColors.black,
                      borderColor: AppColors.appButton,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                    ),
                    20.verticalSpace,
                    InkWell(
                        onTap: () {
                          Get.toNamed(RoutesName.forgotPasswordScreen);
                        },
                        child: const AppTextWidget(
                          fontSize: 14,
                          txtTitle: "Ooops I Forgot My Password",
                          txtColor: AppColors.white,
                        )),
                    10.verticalSpace,
                    const AppTextWidget(
                      fontSize: 10,
                      txtTitle: "- O -",
                      txtColor: AppColors.white,
                    ),
                    10.verticalSpace,
                    const AppTextWidget(
                      fontSize: 14,
                      txtTitle: "I AM NOT A MEMBER",
                      txtColor: AppColors.white,
                    ),
                    20.verticalSpace,
                    AppButtonWidget(
                      fontSize: 14,
                      width: double.maxFinite,
                      onPressed: () {
                        Get.toNamed(RoutesName.createProfileScreen);
                        controller.clearController();
                      },
                      btnName: 'CREATE A PROFILE',
                      borderRadius: 20,
                      btnColor: AppColors.appButton,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                    ),
                    20.verticalSpace,
                    InkWell(
                      onTap: () {
                        controller.skipAPi(context);
                      },
                      child: const AppTextWidget(
                        txtTitle: "SKIP",
                        txtColor: AppColors.white,
                        fontSize: 12,
                      ),
                    ),
                    25.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        15.horizontalSpace,
                        const AppTextWidget(
                          fontSize: 12,
                          txtTitle: "Please read",
                          txtColor: AppColors.appButton,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                "http://35.154.69.160/privacy-policy"));
                          },
                          child: const AppTextWidget(
                            fontSize: 12,
                            txtTitle: "Privacy",
                            txtColor: AppColors.white,
                          ),
                        ),
                        const AppTextWidget(
                          fontSize: 12,
                          txtTitle: "along with",
                          txtColor: AppColors.appButton,
                        ),
                        InkWell(
                          onTap: () {
                            launchUrl(Uri.parse(
                                "http://35.154.69.160/terms-and-conditions"));
                          },
                          child: const Row(
                            children: [
                              AppTextWidget(
                                fontSize: 12,
                                txtTitle: "Tearm",
                                txtColor: AppColors.white,
                              ),
                              AppTextWidget(
                                fontSize: 12,
                                txtTitle: "and",
                                txtColor: AppColors.appButton,
                              ),
                              AppTextWidget(
                                fontSize: 12,
                                txtTitle: "Condition",
                                txtColor: AppColors.white,
                              ),
                            ],
                          ),
                        ),
                        15.horizontalSpace,
                      ],
                    ),
                    20.verticalSpace
                  ],
                ),
              ),
            ),
          ),
          Obx(() => Visibility(
                visible: controller.loader.value,
                child: const AppLoder(),
              ))
        ],
      ),
    );
  }
}
