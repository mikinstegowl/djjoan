//
// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:get/get.dart';
// import 'package:new_music_app/Controller/VideoController.dart';
// import 'package:new_music_app/Utils/Constants/AppAssets.dart';
// import 'package:new_music_app/Utils/Styling/AppColors.dart';
// import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
// import 'package:video_player/video_player.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//   final bool isLive;
//   final bool canDispose;
//
//   const VideoPlayerWidget({
//     required this.videoUrl,
//     this.isLive = false,
//     super.key,
//     this.canDispose = false,
//   });
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget>  with WidgetsBindingObserver{
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;
//   late String videoUrl;
//   YoutubePlayerController _controller = YoutubePlayerController();
//   WebViewController? _webViewController;
//
//   @override
//   void initState() {
//     super.initState();
//
//
//     videoUrl = widget.videoUrl;
//
//     if (isYouTubeUrl(videoUrl)) {
//       _controller = YoutubePlayerController(
//         params: YoutubePlayerParams(
//           mute: false,
//           showControls: true,
//           showFullscreenButton: false,
//         ),
//       );
//
//       _controller.loadVideoByUrl(mediaContentUrl: videoUrl);
//       setState(() {});
//       // _webViewController = WebViewController()
//       //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       //   ..loadRequest(Uri.parse(getYouTubeEmbedUrl(videoUrl)));
//     } else {
//       initializePlayer();
//     }
//
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     // TODO: implement didChangeAppLifecycleState
//     super.didChangeAppLifecycleState(state);
//     if(state == AppLifecycleState.paused|| state == AppLifecycleState.inactive){
//       enablePiP();
//     }
//   }
//   @override
//   void dispose() {
//     _videoPlayerController?.dispose();
//     _chewieController?.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   bool isYouTubeUrl(String url) {
//     return url.contains("youtube.com") || url.contains("youtu.be");
//   }
//
//   String getYouTubeEmbedUrl(String url) {
//     return url.replaceAll("watch?v=", "embed/");
//   }
//
//   Future<void> initializePlayer() async {
//     try {
//       _videoPlayerController =
//           VideoPlayerController.networkUrl(Uri.parse(videoUrl));
//       await _videoPlayerController!.initialize();
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController!,
//         autoPlay: true,
//         looping: false,
//         placeholder: AppLoder(),
//       );
//       setState(() {});
//     } catch (e) {
//       print('Video play error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (isYouTubeUrl(videoUrl)) {
//       return YoutubePlayer(
//         controller: _controller,
//         aspectRatio: 16 / 9,
//       );
//       // return WebViewWidget(controller: _webViewController!);
//     }
//
//     return Center(
//       child: _chewieController != null &&
//               _videoPlayerController!.value.isInitialized
//           ? Chewie(controller: _chewieController!)
//           : widget.isLive
//               ? Image.asset(AppAssets.currentlyOffline)
//               : const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator.adaptive(
//                         backgroundColor: AppColors.appButton),
//                     SizedBox(height: 20),
//                     Text('Loading'),
//                   ],
//                 ),
//     );
//   }
//   Future<void> enablePiP() async {
//     await FlutterOverlayWindow.requestPermission();
//     await FlutterOverlayWindow.showOverlay(
//       enableDrag: true,
//       overlayTitle: "Floating Video",
//       overlayContent: "Your video is playing in PiP mode.",
//       flag: OverlayFlag.defaultFlag,
//       height: 300,
//       width: 300,
//     );
//   }
// }
// //
//
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:floating/floating.dart'; // Import floating package
// import 'package:get/get.dart';
// import 'package:new_music_app/Controller/VideoController.dart';
// import 'package:new_music_app/Utils/Constants/AppAssets.dart';
// import 'package:new_music_app/Utils/Styling/AppColors.dart';
// import 'package:new_music_app/Utils/Widgets/AppLoder.dart';
// import 'package:video_player/video_player.dart';
// // import 'package:youtube_player_iframe/youtube_player_iframe.dart';
//
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//   final bool isLive;
//   final bool canDispose;
//
//   const VideoPlayerWidget({
//     required this.videoUrl,
//     this.isLive = false,
//     super.key,
//     this.canDispose = false,
//   });
//
//   @override
//   State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
//     with WidgetsBindingObserver {
//   VideoPlayerController? _videoPlayerController;
//   ChewieController? _chewieController;
//
//   // YoutubePlayerController? _youtubeController;
//   final Floating floating = Floating(); // Floating package instance
//
//   @override
//   void initState() {
//     super.initState();
//
//     // if (isYouTubeUrl(widget.videoUrl)) {
//     // _youtubeController = YoutubePlayerController(
//     //   params: const YoutubePlayerParams(
//     //     mute: false,
//     //     showControls: true,
//     //     showFullscreenButton: false,
//     //   ), initialVideoId:  widget.videoUrl,
//     // );
//     // _youtubeController.loadVideoByUrl(mediaContentUrl: widget.videoUrl);
//     // }
//     // else {
//     initializePlayer();
//     // }
//
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.inactive ||
//         state == AppLifecycleState.hidden) {
//       // enablePip(context); // Enable PiP when the app goes to background
//     }
//   }
//
//   @override
//   void dispose() {
//     _videoPlayerController?.dispose();
//     _chewieController?.dispose();
//     // _youtubeController?.close();
//     // floating.close(); // Close floating window
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   bool isYouTubeUrl(String url) {
//     return url.contains("youtube.com") || url.contains("youtu.be");
//   }
//
//   Future<void> initializePlayer() async {
//     try {
//       _videoPlayerController =
//           VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
//       await _videoPlayerController!.initialize();
//       _chewieController = ChewieController(
//         videoPlayerController: _videoPlayerController!,
//         autoPlay: true,
//         looping: false,
//         // placeholder: AppLoder(),
//       );
//       setState(() {});
//     } catch (e) {
//       print('Video play error: $e');
//     }
//   }
//
//   Future<void> enablePip(
//     BuildContext context, {
//     bool autoEnable = false,
//   }) async {
//     final rational = Rational.landscape();
//     final screenSize =
//         MediaQuery.of(context).size * MediaQuery.of(context).devicePixelRatio;
//     final height = screenSize.width ~/ rational.aspectRatio;
//
//     final arguments = autoEnable
//         ? OnLeavePiP(
//             aspectRatio: rational,
//             sourceRectHint: Rectangle<int>(
//               0,
//               (screenSize.height ~/ 2) - (height ~/ 2),
//               screenSize.width.toInt(),
//               height,
//             ),
//           )
//         : ImmediatePiP(
//             aspectRatio: rational,
//             sourceRectHint: Rectangle<int>(
//               0,
//               (screenSize.height ~/ 2) - (height ~/ 2),
//               screenSize.width.toInt(),
//               height,
//             ),
//           );
//
//     final status = await floating.enable(arguments);
//     debugPrint('PiP enabled? $status');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // if (isYouTubeUrl(widget.videoUrl)) {
//     //   return YoutubePlayer(
//     //     controller: _youtubeController,
//     //     aspectRatio: 16 / 9,
//     //   );
//     // }
//     return Center(
//       child: _chewieController != null &&
//               _chewieController!.videoPlayerController.value.isInitialized
//           ? Chewie(controller: _chewieController!)
//           : widget.isLive
//               ? Image.asset(AppAssets.currentlyOffline)
//               : const Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     CircularProgressIndicator.adaptive(
//                         backgroundColor: AppColors.appButton),
//                     // SizedBox(height: 20),
//                     // Text('Loading'),
//                   ],
//                 ),
//     );
//   }
// }


import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool isLive;
  final bool canDispose;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrl,
    this.isLive = false,
    required this.canDispose,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget>
    with WidgetsBindingObserver, AutomaticKeepAliveClientMixin {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isInitialized = false;
  late final YoutubePlayerController _youtubeController;

  bool get isYouTube =>
      widget.videoUrl.contains('youtube.com') ||
      widget.videoUrl.contains('youtu.be') ||
      widget.videoUrl.contains('youtube-nocookie.com');

  String get videoId {
    final uri = Uri.parse(widget.videoUrl);
    if (uri.host.contains('youtu.be')) {
      return uri.pathSegments.first;
    } else if (uri.queryParameters.containsKey('v')) {
      return uri.queryParameters['v']!;
    } else if (widget.videoUrl.contains('embed/')) {
      return widget.videoUrl.split('embed/').last;
    }
    return '';
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    if (isYouTube && videoId.isNotEmpty) {
      _youtubeController = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: true,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
        ),
      );
    } else {
      initializeMp4Player();
    }
  }

  Future<void> initializeMp4Player() async {
    if (_isInitialized) return;

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    await _videoPlayerController!.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      autoPlay: true,
      looping: false,
    );

    _isInitialized = true;
    setState(() {});
  }

  @override
  void dispose() {
    if (widget.canDispose) {
      _videoPlayerController?.dispose();
      _chewieController?.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (isYouTube && videoId.isNotEmpty) {
      return YoutubePlayerControllerProvider(
        controller: _youtubeController,
        child: YoutubePlayerScaffold(
          controller: _youtubeController,
          aspectRatio: 16 / 9,
          builder: (context, player) => SizedBox(
            width: MediaQuery.of(context).size.width,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: player,
            ),
          ),
        ),
      );
    }

    return Center(
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: _chewieController!)
          : widget.isLive
              ? const Text("Currently Offline")
              : const CircularProgressIndicator(),
    );
  }
}
