import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/CachedNetworkImageWidget.dart';

class SongListWidget extends StatelessWidget {
  final Function()? onTap;
  final Function()? onDelete;
  final Function()? onOptionTap;
  final bool gifWidget;
  final String imageUrl;
  final String title;
  final String subTitle;
  final bool isPlayList;

  const SongListWidget(
      {super.key,
      this.onTap,
      this.onOptionTap,
      this.onDelete,
      this.isPlayList = false,
      required this.imageUrl,
      required this.title,
      required this.subTitle,
      this.gifWidget = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 45.h,
          child: Center(
            child: ListTile(
              onTap: onTap,
              minLeadingWidth: isPlayList ? 0 : 50.h,
              leading: isPlayList
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 45.h,
                      width: 45.h,
                      child: CachedNetworkImageWidget(
                        image: imageUrl,
                      ),
                    ),
              contentPadding: EdgeInsets.only(left: 10.w),
              title: AppTextWidget(
                  txtTitle: title,
                  maxLine: 1,
                  overflow: TextOverflow.ellipsis,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                  txtColor: AppColors.white),
              subtitle: isPlayList
                  ? null
                  : AppTextWidget(
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
                      txtTitle: subTitle,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      txtColor: Colors.red,
                    ),
              trailing: isPlayList
                  ? InkWell(
                      onTap: onDelete,
                      child: Icon(
                        Icons.delete,
                        size: 30.r,
                        color: AppColors.appButton,
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        gifWidget
                            ? Image.asset(
                                AppAssets.playGif,
                                height: 30.h,
                                width: 30.w,
                                fit: BoxFit.fill,
                              )
                            : Icon(
                                Icons.play_arrow,
                                color: AppColors.white,
                                size: 30.r,
                              ),
                        InkWell(
                          onTap: onOptionTap ?? () {},
                          child: Icon(
                            weight: 15,
                            Icons.more_vert,
                            color: AppColors.white,
                            size: 30.r,
                          ),
                        )
                      ],
                    ),
              minVerticalPadding: 1,
            ),
          ),
        ),
        10.verticalSpace,
      ],
    );
  }
}
