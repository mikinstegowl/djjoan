import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/RadioController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:new_music_app/Utils/Widgets/TestVideo.dart';

class AnimatedBottomSheet extends StatefulWidget {
  const AnimatedBottomSheet({super.key});

  @override
  State<AnimatedBottomSheet> createState() => _AnimatedBottomSheetState();
}

class _AnimatedBottomSheetState extends State<AnimatedBottomSheet>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isShow = true;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Get.find<BaseController>().mainStreamController.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (AppConst.currentTabIndex == 1) {
          return const SizedBox.shrink();
        }
        switch (AppConst.bottomDisplay) {
          case BottomDisplay.song:
            return Get.find<HomeController>()
                .audioPlayer
                .builderRealtimePlayingInfos(
                    builder: (context, RealtimePlayingInfos audioPlayer) {
              String songName =
                  audioPlayer.current?.audio.audio.metas.title ?? '';
              String artistName =
                  audioPlayer.current?.audio.audio.metas.artist ?? '';
              return isShow == false && AppConst.liveVideoUrl.value == false
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          isShow = true;
                        });
                        _controller.forward();
                        //
                      },
                      child: Visibility(
                        visible:
                            (AppConst.bottomDisplay == BottomDisplay.song),
                        child: Container(
                            color: AppColors.appButton,
                            width: double.maxFinite,
                            child: const Icon(Icons.keyboard_arrow_up)),
                      ),
                    )
                  : AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Container(
                          height: _animation.value * 235.h,
                          // Adjust height based on animation value
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Center(
                                  child: IconButton(
                                      onPressed: () {
                                        _controller.reverse().whenComplete(() {
                                          setState(() {
                                            isShow = false;
                                          });
                                        });
                                      },
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down, color: Colors.white)),
                                ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: ProgressBar(
                                      barHeight: 2.0,
                                      progressBarColor: AppColors.appButton,
                                      thumbColor: AppColors.error,
                                      baseBarColor: Colors.white,
                                      timeLabelTextStyle:
                                          const TextStyle(color: Colors.white),
                                      progress: audioPlayer.currentPosition ??
                                          Duration.zero,
                                      total:
                                          audioPlayer.duration ?? Duration.zero,
                                      onSeek: Get.find<HomeController>()
                                          .audioPlayer
                                          .seek,
                                    ),
                                  ),
                                ],
                              ),
                              AppTextWidget(
                                txtTitle: songName,
                                txtColor: AppColors.appButton,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              5.verticalSpace,
                              AppTextWidget(
                                txtTitle: artistName,
                                txtColor: AppColors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                              10.verticalSpace,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Get.find<HomeController>()
                                          .audioPlayer
                                          .setLoopMode(audioPlayer.loopMode ==
                                                  LoopMode.none
                                              ? LoopMode.single
                                              : LoopMode.none);
                                    },
                                    child: Image.asset(
                                      AppAssets.replayButton,
                                      height: 20.h,
                                      width: 25.w,
                                      color:
                                          audioPlayer.loopMode == LoopMode.none
                                              ? AppColors.white
                                              : AppColors.appButton,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.find<HomeController>()
                                          .audioPlayer
                                          .previous();
                                      Get.find<HomeController>().update();
                                    },
                                    child: Image.asset(
                                      AppAssets.fastRewindImage,
                                      height: 20.h,
                                      width: 25.w,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (Get.find<RadioController>()
                                          .audioPlayer
                                          .current
                                          .hasValue) {
                                        await Get.find<RadioController>()
                                            .audioPlayer
                                            .stop();
                                      }
                                      await Get.find<HomeController>()
                                          .audioPlayer
                                          .playOrPause();
                                    },
                                    child: Image.asset(
                                      Get.find<HomeController>()
                                              .audioPlayer
                                              .isPlaying
                                              .value
                                          ? AppAssets.playButtonImage
                                          : AppAssets.puaseButtonImage,
                                      height: 40.h,
                                      width: 50.w,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await Get.find<HomeController>()
                                          .audioPlayer
                                          .next();
                                      Get.find<HomeController>().update();
                                    },
                                    child: Image.asset(
                                      AppAssets.fastForwordImage,
                                      height: 20.h,
                                      width: 25.w,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 25.w,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.shuffle,
                                        color: Get.find<HomeController>()
                                                .audioPlayer
                                                .shuffle
                                            ? AppColors.appButton
                                            : AppColors.white,
                                      ),
                                      onPressed: () {
                                        Get.find<HomeController>()
                                            .audioPlayer
                                            .toggleShuffle();
                                        Get.find<HomeController>().update();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
            });
          //             .value
          //             ?.data
          //             ?.description ??
          //         '';
          //     return isShow == false && AppConst.liveVideoUrl.value == false
          //         ? InkWell(
          //             onTap: () {
          //               setState(() {
          //                 isShow = true;
          //               });
          //               _controller.forward();
          //               //
          //             },
          //             child: Visibility(
          //               visible:
          //                   (AppConst.bottomDisplay == BottomDisplay.radio &&
          //                       AppConst.currentTabIndex != 1 &&
          //                       AppConst.currentTabIndex != 2),
          //               child: Container(
          //                   color: AppColors.appButton,
          //                   width: double.maxFinite,
          //                   child: const Icon(Icons.keyboard_arrow_up)),
          //             ),
          //           )
          //         : AnimatedBuilder(
          //             animation: _animation,
          //             builder: (context, child) {
          //               return Container(
          //                 height: _animation.value * 220.h,
          //                 // Adjust height based on animation value
          //                 color: Colors.black,
          //                 padding: EdgeInsets.symmetric(vertical: 16.h),
          //                 child: Column(
          //                   // mainAxisSize: MainAxisSize.min,
          //                   children: <Widget>[
          //                     Center(
          //                       child: IconButton(
          //                           onPressed: () {
          //                             _controller.reverse().whenComplete(() {
          //                               setState(() {
          //                                 isShow = false;
          //                               });
          //                             });
          //                           },
          //                           icon:
          //                               const Icon(Icons.keyboard_arrow_down)),
          //                     ),
          //                     AppTextWidget(
          //                       txtTitle: songName ?? '',
          //                       txtColor: AppColors.appButton,
          //                       fontSize: 18,
          //                       fontWeight: FontWeight.w600,
          //                     ),
          //                     5.verticalSpace,
          //                     AppTextWidget(
          //                       txtTitle: artistName ?? '',
          //                       txtColor: AppColors.white,
          //                       fontSize: 17,
          //                       fontWeight: FontWeight.w600,
          //                     ),
          //                     10.verticalSpace,
          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceEvenly,
          //                       children: <Widget>[
          //                         InkWell(
          //                           onTap: () {
          //                             Get.find<RadioController>()
          //                                 .audioPlayer
          //                                 .playOrPause();
          //                             Get.find<RadioController>().update();
          //                           },
          //                           child: Image.asset(
          //                             Get.find<RadioController>()
          //                                     .audioPlayer
          //                                     .isPlaying
          //                                     .value
          //                                 ? AppAssets.playButtonImage
          //                                 : AppAssets.puaseButtonImage,
          //                             height: 40.h,
          //                             width: 45.w,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ],
          //                 ),
          //               );
          //             },
          //           );
          //   });
          case BottomDisplay.video:
            return const TestViewWidget();
          case BottomDisplay.none:
            return const SizedBox.shrink();
        }
      },
    );
  }
}
