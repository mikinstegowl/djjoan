import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppButtonWidget.dart';

class SongAddToDialog extends StatelessWidget {
  final bool playlistScreen;
  final bool favoritesScreen;
  final Function() onFavorites;
  final Function()? onPlaylist;

  const SongAddToDialog(
      {super.key,
      this.favoritesScreen = false,
      required this.onFavorites,
      required this.onPlaylist,
      this.playlistScreen = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.w),
      child: AlertDialog.adaptive(
        backgroundColor: AppColors.smokeBlack,
        shape: const RoundedRectangleBorder(),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppButtonWidget(
                  width: double.maxFinite,
                  onPressed: onFavorites,
                  txtColor: AppColors.appButton,
                  btnColor: AppColors.transparent,
                  btnName: favoritesScreen
                      ? "Remove Song From Favorites"
                      : "Add To Favorites"),
              const Divider(),
              AppButtonWidget(
                  width: double.maxFinite,
                  onPressed: onPlaylist ?? () {},
                  txtColor: AppColors.appButton,
                  btnColor: AppColors.transparent,
                  btnName: playlistScreen
                      ? "Remove Song From Playlist"
                      : "Add To Playlist"),
              const Divider(),
              AppButtonWidget(
                  width: double.maxFinite,
                  txtColor: AppColors.appButton,
                  btnColor: AppColors.transparent,
                  onPressed: () {
                    Get.back();
                  },
                  btnName: "Cancel"),
            ],
          ),
        ),
      ),
    );
  }
}
