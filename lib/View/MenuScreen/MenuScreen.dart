import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/ContectUsScreen.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/MyFavoriteVideosScreen.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/NotificationScreen.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/SearchScreen.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/SocialMediaScreen.dart';

class MenuScreen extends GetView<MenuPageController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppAssets.blackBackgroundScreen,
              ),
              fit: BoxFit.cover)),
      child: GetBuilder<MenuPageController>(
          init: controller,
          initState: (state) {
            controller.socialMedia();
          },
          builder: (controller) {
            return Column(
              children: [
                ListTile(
                  onTap: () {
                    AppConst.liveVideoUrl.value = false;
                    Navigator.push(context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) {
                      return const SearchScreen();
                    }));
                  },
                  leading: Image.asset(
                    AppAssets.search,
                    color: AppColors.white,
                    height: 12.h,
                  ),
                  title: const AppTextWidget(
                    txtTitle: 'Search',
                    fontSize: 14,
                    txtColor: AppColors.white,
                  ),
                  trailing: Icon(
                    Icons.navigate_next_outlined,
                    size: 35.r,
                    weight: 0.5,
                    color: AppColors.white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    AppConst.liveVideoUrl.value = false;
                    Navigator.push(context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) {
                      return const MyFavoriteVideoScreen();
                    }));
                  },
                  leading: Icon(
                    Icons.favorite,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                  title: const AppTextWidget(
                    txtTitle: 'My Favorite Video',
                    fontSize: 14,
                    txtColor: AppColors.white,
                  ),
                  trailing: Icon(
                    Icons.navigate_next_outlined,
                    size: 35.r,
                    weight: 0.5,
                    color: AppColors.white,
                  ),
                ),
                ListTile(
                  onTap: () async {
                    AppConst.liveVideoUrl.value = false;
                    if (UserPreference.getValue(key: PrefKeys.email) != null) {
                      await controller.getUserProfileApi();
                      Get.toNamed(RoutesName.profileScreen);
                    } else {
                      Get.dialog(AlertDialog.adaptive(
                        title: const AppTextWidget(
                          txtTitle: 'Please Login to Continue.',
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          AppButtonWidget(
                            onPressed: () {
                              Get.toNamed(RoutesName.loginScreen);
                            },
                            btnName: "Ok",
                            width: 100.w,
                            btnColor: AppColors.appButton,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                          ),
                          AppButtonWidget(
                            onPressed: () {
                              Get.back();
                            },
                            btnName: "Cancel",
                            width: 100.w,
                            btnColor: AppColors.black,
                            margin: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                          )
                        ],
                      ));
                    }
                  },
                  leading: Icon(
                    Icons.person,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                  title: const AppTextWidget(
                    txtTitle: 'My Profile',
                    fontSize: 14,
                    txtColor: AppColors.white,
                  ),
                  trailing: Icon(
                    Icons.navigate_next_outlined,
                    size: 35.r,
                    weight: 0.5,
                    color: AppColors.white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    AppConst.liveVideoUrl.value = false;
                    Navigator.push(context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) {
                      return const NotificationScreen();
                    }));
                  },
                  leading: Icon(
                    Icons.notifications,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                  title: const AppTextWidget(
                    txtTitle: 'Notifications',
                    fontSize: 14,
                    txtColor: AppColors.white,
                  ),
                  trailing: Icon(
                    Icons.navigate_next_outlined,
                    size: 35.r,
                    weight: 0.5,
                    color: AppColors.white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    AppConst.liveVideoUrl.value = false;
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder: (_, __, ___) => const SocialMediaScreen()));
                  },
                  leading: Icon(
                    CupertinoIcons.globe,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                  title: const AppTextWidget(
                    txtTitle: 'Social Media',
                    fontSize: 14,
                    txtColor: AppColors.white,
                  ),
                  trailing: Icon(
                    Icons.navigate_next_outlined,
                    size: 35.r,
                    weight: 0.5,
                    color: AppColors.white,
                  ),
                ),
                // ListTile(
                //   onTap: () async {
                //     AppConst.liveVideoUrl.value = false;
                //     String url;
                //     url = await controller.getMerchandiseApi();
                //     Navigator.push(context,
                //         PageRouteBuilder(pageBuilder: (_, __, ___) {
                //       return MerchandiseScreen(
                //         url: url,
                //       );
                //     }));
                //   },
                //   leading: Icon(
                //     Icons.shopping_bag_outlined,
                //     color: AppColors.white,
                //     size: 30.r,
                //   ),
                //   title: AppTextWidget(
                //     txtTitle: 'Merchandise',
                //     fontSize: 18,
                //     txtColor: AppColors.white,
                //   ),
                //   trailing: Icon(
                //     Icons.navigate_next_outlined,
                //     size: 35.r,
                //     weight: 0.5,
                //     color: AppColors.white,
                //   ),
                // ),
                ListTile(
                  onTap: () async {
                    AppConst.liveVideoUrl.value = false;
                    Navigator.push(context,
                        PageRouteBuilder(pageBuilder: (_, __, ___) {
                      return ContactUsScreen(
                        url: controller
                                .getSocialMediaModel.value?.data?.formLink ??
                            '',
                      );
                    }));
                  },
                  leading: Icon(
                    Icons.contacts_rounded,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                  title: const AppTextWidget(
                    txtTitle: 'Contact Us',
                    fontSize: 14,
                    txtColor: AppColors.white,
                  ),
                  trailing: Icon(
                    Icons.navigate_next_outlined,
                    size: 35.r,
                    weight: 0.5,
                    color: AppColors.white,
                  ),
                ),
                ListTile(
                  onTap: () {
                    AppConst.liveVideoUrl.value = false;
                    if (UserPreference.getValue(key: PrefKeys.email) == null) {
                      Get.find<BaseController>().imageUrl.value = '';
                      Get.toNamed(RoutesName.loginScreen);
                    } else {
                      UserPreference.clear();
                      Get.find<BaseController>().imageUrl.value = '';
                      Get.toNamed(RoutesName.loginScreen);
                    }
                  },
                  leading: Icon(
                    UserPreference.getValue(key: PrefKeys.email) == null
                        ? Icons.login
                        : Icons.logout,
                    color: AppColors.white,
                    size: 20.r,
                  ),
                  title: AppTextWidget(
                    txtTitle:
                        UserPreference.getValue(key: PrefKeys.email) == null
                            ? 'Login'
                            : "Logout",
                    fontSize: 14,
                    txtColor: AppColors.white,
                  ),
                  trailing: Icon(
                    Icons.navigate_next_outlined,
                    size: 35.r,
                    weight: 0.5,
                    color: AppColors.white,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  AppAssets.alajazaLogo,
                  width: 200.w,
                ),
                const Spacer(),
              ],
            );
          }),
    );
  }
}
