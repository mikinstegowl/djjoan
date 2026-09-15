import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/AuthController.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Constants/Validators.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';

class CreateProfileScreen extends GetView<AuthController> {
  const CreateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BaseController());
    GlobalKey<FormState> key = GlobalKey<FormState>();
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          elevation: 0,
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
            preferredSize: Size(double.maxFinite, 0),
            child: Divider(
              color: AppColors.appButton,
            ),
          ),
          backgroundColor: AppColors.smokeBlack,
          leadingWidth: 70.w,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                5.horizontalSpace,
                Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                  size: 20.r,
                ),
                const AppTextWidget(
                  txtTitle: "Back",
                  txtColor: AppColors.white,
                )
              ],
            ),
          ),
        ),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    AppAssets.blackBackgroundScreen,
                  ),
                  fit: BoxFit.cover)),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                children: [
                  64.verticalSpace,
                  // Stack(
                  //   children: [
                  //     // Obx(() => CircleAvatar(
                  //     //       backgroundColor: AppColors.transparent,
                  //     //       maxRadius: 70.h,
                  //     //       backgroundImage:
                  //     //           Get.find<BaseController>().imageUrl.value == ''
                  //     //               ? const AssetImage(AppAssets.alajazaLogo)
                  //     //               : NetworkImage(Get.find<BaseController>()
                  //     //                   .imageUrl
                  //     //                   .value) as ImageProvider,
                  //     //       // : AssetImage(AppAssets.alajazaLogo),
                  //     //       // width: 200.w,
                  //     //       // padding: EdgeInsets.symmetric(horizontal: 10.w),
                  //     //       // child: controller.imageUrl.value == ''
                  //     //       //     ? Image.asset(
                  //     //       //         AppAssets.alajazaLogo,
                  //     //       //         width: 150.w,
                  //     //       //       )
                  //     //       //     : CachedNetworkImageWidget(
                  //     //       //         image: controller.imageUrl.value,
                  //     //       //       ),
                  //     //     )),
                  //     Positioned(
                  //         right: 0,
                  //         top: 0,
                  //         child: InkWell(
                  //           onTap: () {
                  //             Get.dialog(UploadImageDialog()
                  //
                  //                 // UploadImageDialog()
                  //                 );
                  //             // controller.imageUpload();
                  //           },
                  //           child: const Icon(
                  //             Icons.edit,
                  //             color: AppColors.white,
                  //             size: 30,
                  //           ),
                  //         ))
                  //   ],
                  // ),
                  20.verticalSpace,
                  AppTextFormField(
                    controller: controller.nameController,
                    hintText: 'Enter name',
                    titleText: 'NAME',
                    textColor: Colors.white,
                    validator: (value) {
                      return isRequiredField(value: value);
                    },
                    textInputAction: TextInputAction.next,
                    hintTextColor: AppColors.textFormFieldTextColor,
                  ),
                  20.verticalSpace,
                  AppTextFormField(
                    controller: controller.userNameController,
                    hintText: 'Enter username',
                    titleText: 'USERNAME',
                    textColor: Colors.white,
                    validator: (value) {
                      return isRequiredField(value: value);
                    },
                    textInputAction: TextInputAction.next,
                    hintTextColor: AppColors.textFormFieldTextColor,
                  ),
                  20.verticalSpace,
                  AppTextFormField(
                    controller: controller.emailController,
                    hintText: 'Enter email address',
                    titleText: 'EMAIL',
                    textColor: Colors.white,
                    validator: (value) {
                      return validateEmail(value: value);
                    },
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    hintTextColor: AppColors.textFormFieldTextColor,
                  ),
                  20.verticalSpace,
                  AppTextFormField(
                    textColor: Colors.white,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      PhoneNumberFormatter(),
                      LengthLimitingTextInputFormatter(14),
                    ],
                    controller: controller.phoneNumberController,
                    keyboardType: TextInputType.number,
                    hintText: 'Enter phone number',
                    titleText: 'PHONE NUMBER (Optional)',
                    validator: (value) {
                      if (value?.isNotEmpty ?? false) {
                        return mobileNoValidation(value);
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    hintTextColor: AppColors.textFormFieldTextColor,
                  ),
                  20.verticalSpace,
                  Obx(() => AppTextFormField(
                        textColor: Colors.white,
                        controller: controller.passwordController,
                        obscureText: controller.showPassword.value,
                        textInputAction: TextInputAction.done,
                        hintText: "Enter password",
                        titleText: 'PASSWORD',
                        hintTextColor: AppColors.textFormFieldTextColor,
                        validator: (value) {
                          return validatePassword(value);
                        },
                        suffixWidget: InkWell(
                          onTap: () {
                            controller.showPassword.value =
                                !controller.showPassword.value;
                            controller.update();
                          },
                          child: controller.showPassword.value
                              ? Transform.flip(
                                  flipX: true,
                                  child: Icon(Icons.visibility_off,
                                      size: 35.r,
                                      color: AppColors.textFormFieldTextColor),
                                )
                              : Icon(Icons.remove_red_eye,
                                  size: 35.r,
                                  color: AppColors.textFormFieldTextColor),
                        ),
                      )),
                  20.verticalSpace,
                  Obx(() => AppTextFormField(
                        textColor: Colors.white,
                        controller: controller.confirmPasswordController,
                        obscureText: controller.showConfirmPassword.value,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value !=
                              controller.passwordController.text.toString()) {
                            return "Please enter valid confirm password";
                          }
                          return null;
                        },
                        hintText: "Enter confirm password",
                        titleText: 'CONFIRM PASSWORD',
                        hintTextColor: AppColors.textFormFieldTextColor,
                        suffixWidget: InkWell(
                          onTap: () {
                            controller.showConfirmPassword.value =
                                !controller.showConfirmPassword.value;
                            controller.update();
                          },
                          child: controller.showConfirmPassword.value
                              ? Transform.flip(
                                  flipX: true,
                                  child: Icon(Icons.visibility_off,
                                      size: 35.r,
                                      color: AppColors.textFormFieldTextColor),
                                )
                              : Icon(Icons.remove_red_eye,
                                  size: 35.r,
                                  color: AppColors.textFormFieldTextColor),
                        ),
                      )),
                  40.verticalSpace,
                  AppButtonWidget(
                    width: double.maxFinite,
                    onPressed: () {
                      if (key.currentState?.validate() ?? false) {
                        controller.signUpUserAPi(context);
                      }
                    },
                    btnName: 'CREATE PROFILE',
                    fontSize: 14,
                    borderRadius: 10,
                    btnColor: AppColors.appButton,
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                  ),
                  40.verticalSpace,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
