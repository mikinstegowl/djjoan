import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:new_music_app/Utils/Constants/AppAssets.dart';
import 'package:video_player/video_player.dart';

class LiveVideoWidget extends StatefulWidget {
  final String videoUrl;

  const LiveVideoWidget({
    super.key,
    required this.videoUrl,
  });

  @override
  State<LiveVideoWidget> createState() => _LiveVideoWidgetState();
}

class _LiveVideoWidgetState extends State<LiveVideoWidget>
    with WidgetsBindingObserver {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.pause();
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    try {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
      // ..initialize().then((value) {
      //   setState(() {});
      // });

      Future.wait([
        _videoPlayerController.initialize().then((value) => setState(() {
              _videoPlayerController.play();
            }))
      ]);

      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController,
        autoPlay: true,
        aspectRatio: null,
        looping: false,
        allowFullScreen: false,
        isLive: true,
        hideControlsTimer: const Duration(seconds: 1),
      );
      setState(() {});
      WidgetsBinding.instance.addObserver(this);
    } catch (e) {
      log('', name: 'video play error', error: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print("this is ${widget.videoUrl}");
    return Center(
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(
              controller: _chewieController!,
            )
          : Image.asset(AppAssets.currentlyOffline),
    );
  }
}
