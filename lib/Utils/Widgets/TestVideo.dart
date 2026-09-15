import 'dart:developer';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Styling/AppColors.dart';
import 'package:new_music_app/Utils/Widgets/AppTextWidget.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class TestViewWidget extends StatefulWidget {
  const TestViewWidget({super.key});

  @override
  State<TestViewWidget> createState() => _TestViewWidgetState();
}

class _TestViewWidgetState extends State<TestViewWidget>
    with WidgetsBindingObserver {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  YoutubePlayerController? _youtubeController;
  bool isError = false;
  String? _currentLoadedUrl;
  bool _isYoutube = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final url = _getCurrentUrl();
    if (url.isNotEmpty) {
      _currentLoadedUrl = url;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _initializePlayer(url);
        }
      });
    }
  }

  String _getCurrentUrl() {
    final active = Get.find<BaseController>().currentActiveVideo;
    if (active != null && active.videoUrl.isNotEmpty) {
      return active.videoUrl;
    }
    return AppConst.LiveUrl;
  }

  bool _checkIsYouTube(String url) =>
      url.contains('youtube.com') ||
      url.contains('youtu.be') ||
      url.contains('youtube-nocookie.com');

  String _extractYoutubeId(String url) {
    final uri = Uri.parse(url);
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.isNotEmpty ? uri.pathSegments.first : '';
    } else if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v']!;
    } else if (url.contains('embed/')) {
      return url.split('embed/').last;
    }
    return '';
  }

  void _disposeControllers() {
    _videoPlayerController?.pause();
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
    _chewieController?.dispose();
    _chewieController = null;
    _youtubeController = null;
  }

  Future<void> _initializePlayer(String videoUrl) async {
    _disposeControllers();
    isError = false;

    if (videoUrl.isEmpty) {
      if (mounted) setState(() {});
      return;
    }

    if (_checkIsYouTube(videoUrl)) {
      _isYoutube = true;
      final videoId = _extractYoutubeId(videoUrl);
      if (videoId.isNotEmpty) {
        _youtubeController = YoutubePlayerController.fromVideoId(
          videoId: videoId,
          autoPlay: true,
          params: const YoutubePlayerParams(
            showControls: true,
            showFullscreenButton: false,
          ),
        );
        if (mounted) setState(() {});
      }
      return;
    }

    _isYoutube = false;
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(videoUrl));

      await _videoPlayerController!.initialize();
      _videoPlayerController!.play();

      final isLiveStream = Get.find<BaseController>().currentActiveVideo?.type ==
              VideoSourceType.live ||
          videoUrl == AppConst.LiveUrl;

      _chewieController = ChewieController(
        materialProgressColors:
            ChewieProgressColors(bufferedColor: AppColors.appButton),
        cupertinoProgressColors: ChewieProgressColors(
          bufferedColor: AppColors.appButton,
        ),
        allowMuting: true,
        autoInitialize: true,
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        allowPlaybackSpeedChanging: !isLiveStream,
        aspectRatio: null,
        looping: false,
        allowFullScreen: false,
        isLive: isLiveStream,
        hideControlsTimer: const Duration(seconds: 1),
      );

      if (mounted) {
        setState(() {
          isError = false;
        });
      }
    } catch (e) {
      log('', name: 'video play error', error: e.toString());
      if (mounted) {
        setState(() {
          isError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final baseController = Get.find<BaseController>();
    final activeVideo = baseController.currentActiveVideo;
    final currentUrl = _getCurrentUrl();

    if (currentUrl.isNotEmpty && currentUrl != _currentLoadedUrl) {
      _currentLoadedUrl = currentUrl;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _initializePlayer(currentUrl);
        }
      });
    }

    final isMiniPlayer = AppConst.bottomDisplay == BottomDisplay.video &&
        AppConst.currentTabIndex != 1;

    if (isMiniPlayer) {
      return InkWell(
        onTap: () {
          baseController.restoreVideoScreen(context);
        },
        child: Container(
          color: AppColors.appButton,
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Container(
                  color: AppColors.black,
                  height: 88.h,
                  width: 130.w,
                  child: AbsorbPointer(
                    absorbing: true,
                    child: videoPlayer(context),
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(
                      txtTitle: activeVideo?.videoTitle ??
                          (activeVideo?.type == VideoSourceType.live
                              ? 'Live TV'
                              : 'Video Playing'),
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      txtColor: AppColors.black,
                      maxLine: 2,
                    ),
                    4.verticalSpace,
                    if (activeVideo?.type == VideoSourceType.live ||
                        currentUrl == AppConst.LiveUrl)
                      Row(
                        children: [
                          Container(
                            width: 8.r,
                            height: 8.r,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          4.horizontalSpace,
                          const AppTextWidget(
                            txtTitle: "LIVE",
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            txtColor: Colors.red,
                          ),
                        ],
                      )
                    else if (activeVideo?.videoDescp != null &&
                        activeVideo!.videoDescp!.isNotEmpty)
                      AppTextWidget(
                        txtTitle: activeVideo.videoDescp!,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        txtColor: AppColors.black,
                        maxLine: 1,
                      ),
                  ],
                ),
              ),
              if (!_isYoutube && _videoPlayerController != null) ...[
                IconButton(
                  icon: Icon(
                    (_videoPlayerController?.value.isPlaying ?? false)
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: AppColors.black,
                    size: 30.r,
                  ),
                  onPressed: () {
                    if (_videoPlayerController != null) {
                      if (_videoPlayerController!.value.isPlaying) {
                        _videoPlayerController!.pause();
                      } else {
                        _videoPlayerController!.play();
                      }
                      setState(() {});
                    }
                  },
                ),
                IconButton(
                  icon: Icon(
                    (_videoPlayerController?.value.volume ?? 1.0) > 0
                        ? Icons.volume_up
                        : Icons.volume_off,
                    color: AppColors.black,
                    size: 24.r,
                  ),
                  onPressed: () {
                    if (_videoPlayerController != null) {
                      if (_videoPlayerController!.value.volume > 0) {
                        _videoPlayerController!.setVolume(0);
                      } else {
                        _videoPlayerController!.setVolume(1);
                      }
                      setState(() {});
                    }
                  },
                ),
              ],
              IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppColors.black,
                  size: 24.r,
                ),
                onPressed: () {
                  baseController.stopAndClearVideo();
                },
              ),
            ],
          ),
        ),
      );
    }

    return videoPlayer(context);
  }

  Widget videoPlayer(BuildContext context) {
    if (_isYoutube && _youtubeController != null) {
      return YoutubePlayerControllerProvider(
        controller: _youtubeController!,
        child: YoutubePlayer(
          controller: _youtubeController!,
          aspectRatio: 16 / 9,
        ),
      );
    }

    if (isError) {
      return Image.asset(AppAssets.currentlyOffline);
    }

    if (_chewieController != null &&
        _videoPlayerController != null &&
        _videoPlayerController!.value.isInitialized) {
      return Chewie(controller: _chewieController!);
    }

    return const Center(
      child: CircularProgressIndicator(color: AppColors.appButton),
    );
  }
}
