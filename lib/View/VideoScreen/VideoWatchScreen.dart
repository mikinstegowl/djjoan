import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryItemModel.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationBar.dart';
import 'package:new_music_app/Utils/Widgets/TitleBackButtonWidget.dart';
import 'package:new_music_app/Utils/Widgets/VideoPlayer.dart';
import 'package:new_music_app/View/VideoScreen/Widgets/DescriptionWidget.dart';

class VideoWatchScreen extends StatefulWidget {
  final String videoUrl;
  final int videosId;
  final String? videoTitle;
  final String? videoDescp;
  final Data? videoData;
  final List<Videos> datas;

  const VideoWatchScreen({
    super.key,
    required this.videoUrl,
    this.videoTitle,
    this.videoDescp,
    this.videoData,
    required this.datas,
    required this.videosId,
  });

  @override
  State<VideoWatchScreen> createState() => _VideoWatchScreenState();
}

class _VideoWatchScreenState extends State<VideoWatchScreen>
    with WidgetsBindingObserver {
  final GlobalKey videoPlayerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Register active video in BaseController
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Get.find<BaseController>().playVodVideo(
          videoUrl: widget.videoUrl,
          videoId: widget.videosId,
          videoTitle: widget.videoTitle,
          videoDescp: widget.videoDescp,
          videoData: widget.videoData,
          datas: widget.datas,
        );
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onBack() {
    AppConst.bottomDisplay = BottomDisplay.video;
    Get.find<BaseController>().playVodVideo(
      videoUrl: widget.videoUrl,
      videoId: widget.videosId,
      videoTitle: widget.videoTitle,
      videoDescp: widget.videoDescp,
      videoData: widget.videoData,
      datas: widget.datas,
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onBack();
        }
      },
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          appBar: AppNavigationBar(defaultAppBar: AppBar()),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.blackBackgroundScreen),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                TitleBackButtonWidget(
                  onTap: _onBack,
                  title: widget.videoTitle ?? '',
                ),
                SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: VideoPlayerWidget(
                    key: videoPlayerKey,
                    videoUrl: widget.videoUrl,
                    canDispose: false,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    child: DescriptionWidget(
                      videoId: widget.videosId,
                      videoData: widget.videoData,
                      videoDescription: widget.videoDescp ?? '',
                      videoTitle: widget.videoTitle,
                      datas: widget.datas,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
