import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
import 'package:new_music_app/Utils/Widgets/AppTextFormField.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/Dialogs/SelectImageDialog.dart';

class MyProfileScreen extends GetView<MenuPageController> {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.smokeBlack,
          appBar: AppBar(
            backgroundColor: AppColors.smokeBlack,
            leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 25.r,
                color: AppColors.white,
              ),
            ),
            bottom: const PreferredSize(
              preferredSize: Size(double.maxFinite, 0),
              child: Divider(
                color: AppColors.appButton,
              ),
            ),
            centerTitle: false,
            title: const AppTextWidget(
              txtTitle: "Account settings",
              fontSize: 18,
              txtColor: AppColors.white,
            ),
          ),
          body: GetBuilder<MenuPageController>(
              init: controller,
              builder: (controller) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      20.verticalSpace,
                      Stack(
                        children: [
                          Obx(() => CircleAvatar(
                                backgroundColor: AppColors.transparent,
                                maxRadius: 70.h,
                                backgroundImage: Get.find<BaseController>()
                                            .imageUrl
                                            .value ==
                                        ''
                                    ? const AssetImage(AppAssets.alajazaLogo)
                                    : NetworkImage(Get.find<BaseController>()
                                        .imageUrl
                                        .value) as ImageProvider,
                                // : AssetImage(AppAssets.alajazaLogo),
                                // width: 200.w,
                                // padding: EdgeInsets.symmetric(horizontal: 10.w),
                                // child: controller.imageUrl.value == ''
                                //     ? Image.asset(
                                //         AppAssets.alajazaLogo,
                                //         width: 150.w,
                                //       )
                                //     : CachedNetworkImageWidget(
                                //         image: controller.imageUrl.value,
                                //       ),
                              )),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: InkWell(
                              onTap: () {
                                Get.dialog(const UploadImageDialog()

                                    // UploadImageDialog()
                                    );
                              },
                              child: Icon(
                                Icons.edit,
                                size: 40.r,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.verticalSpace,
                      AppTextFormField(
                        hintText: "enter name",
                        titleText: "NAME",
                        textColor: Colors.white,
                        controller: controller.nameController,
                      ),
                      10.verticalSpace,
                      AppTextFormField(
                        textColor: Colors.white,
                        hintText: "enter user name",
                        titleText: "USERNAME",
                        readOnly: true,
                        controller: controller.userNameController,
                      ),
                      10.verticalSpace,
                      AppTextFormField(
                        textColor: Colors.white,
                        controller: controller.emailController,
                        hintText: "",
                        titleText: "EMAIL",
                        readOnly: true,
                      ),
                      10.verticalSpace,
                      AppTextFormField(
                          textColor: Colors.white,
                          controller: controller.phoneController,
                          hintText: "enter your phone number",
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            // Allows only numbers
                            LengthLimitingTextInputFormatter(12),
                            PhoneNumberFormatter(),
                          ],
                          titleText: "PHONE NUMBER"),
                      25.verticalSpace,
                      AppButtonWidget(
                        onPressed: () {
                          controller.updateUserProfile();
                        },
                        btnName: "Save",
                        width: double.maxFinite,
                        borderRadius: 15,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.h,
                        ),
                        btnColor: AppColors.appButton,
                      ),
                      10.verticalSpace,
                      AppButtonWidget(
                        onPressed: () {
                          Get.toNamed(RoutesName.changePasswordScreen);
                        },
                        width: double.maxFinite,
                        borderRadius: 15,
                        btnName: "CHANGE PASSWORD",
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        margin: EdgeInsets.symmetric(horizontal: 20.h),
                        btnColor: AppColors.black,
                      ),
                      5.verticalSpace,
                    ],
                  ),
                );
              }),
        ),
        Obx(() =>
            Visibility(visible: controller.pageLoder.value, child: const AppLoder()))
      ],
    ));
  }
}
