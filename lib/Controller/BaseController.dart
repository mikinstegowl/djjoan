import 'dart:async';
import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Controller/RadioController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/BannerModel.dart';
import 'package:new_music_app/Utils/Models/MerchandiseDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchDataModel.dart';
import 'package:new_music_app/View/CameraScreen.dart';
import 'package:new_music_app/View/Favorites/FavoritesScreen.dart';
import 'package:new_music_app/View/HomeScreen/HomeScreen.dart';
import 'package:new_music_app/View/LiveVideoScreen/LiveVideoScreen.dart';
import 'package:new_music_app/View/MenuScreen/MenuScreen.dart';
import 'package:new_music_app/View/PlayListScreen/PlaylistScreen.dart';
import 'package:new_music_app/View/RadioScreen/RadioScreen.dart';
import 'package:new_music_app/View/VideoScreen/VideoListScreen.dart';

import 'package:new_music_app/Utils/Models/VideoCategoryItemModel.dart' as vci;
import 'package:new_music_app/View/VideoScreen/VideoWatchScreen.dart';

import 'dart:io';
import 'package:permission_handler/permission_handler.dart';

enum VideoSourceType { live, vod }

class ActiveVideoData {
  final VideoSourceType type;
  final String videoUrl;
  final int? videoId;
  final String? videoTitle;
  final String? videoDescp;
  final dynamic videoData;
  final List<vci.Videos>? datas;

  ActiveVideoData({
    required this.type,
    required this.videoUrl,
    this.videoId,
    this.videoTitle,
    this.videoDescp,
    this.videoData,
    this.datas,
  });
}

class BaseController extends GetxController {
  late CameraController cameraController;
  StreamController<bool> mainStreamController = StreamController.broadcast();
  StreamController<bool> backGroundStreamController =
      StreamController.broadcast();
  MiniplayerController miniplayerController = MiniplayerController();

  ActiveVideoData? currentActiveVideo;

  void playLiveVideo({required String url, String? title}) {
    if (Get.isRegistered<HomeController>()) {
      final home = Get.find<HomeController>();
      if (home.audioPlayer.isPlaying.value) {
        home.audioPlayer.pause();
      }
    }
    if (Get.isRegistered<RadioController>()) {
      final radio = Get.find<RadioController>();
      if (radio.audioPlayer.isPlaying.value) {
        radio.audioPlayer.pause();
      }
    }
    AppConst.LiveUrl = url;
    currentActiveVideo = ActiveVideoData(
      type: VideoSourceType.live,
      videoUrl: url,
      videoTitle: title ?? 'Live TV',
    );
    AppConst.bottomDisplay = BottomDisplay.video;
    notifyStream();
    update();
  }

  void playVodVideo({
    required String videoUrl,
    required int videoId,
    String? videoTitle,
    String? videoDescp,
    dynamic videoData,
    List<vci.Videos>? datas,
  }) {
    if (Get.isRegistered<HomeController>()) {
      final home = Get.find<HomeController>();
      if (home.audioPlayer.isPlaying.value) {
        home.audioPlayer.pause();
      }
    }
    if (Get.isRegistered<RadioController>()) {
      final radio = Get.find<RadioController>();
      if (radio.audioPlayer.isPlaying.value) {
        radio.audioPlayer.pause();
      }
    }
    currentActiveVideo = ActiveVideoData(
      type: VideoSourceType.vod,
      videoUrl: videoUrl,
      videoId: videoId,
      videoTitle: videoTitle,
      videoDescp: videoDescp,
      videoData: videoData,
      datas: datas,
    );
    AppConst.bottomDisplay = BottomDisplay.video;
    notifyStream();
    update();
  }

  void notifyStream() {
    if (!mainStreamController.isClosed) {
      mainStreamController.sink.add(true);
    }
  }

  void stopAndClearVideo() {
    currentActiveVideo = null;
    if (AppConst.bottomDisplay == BottomDisplay.video) {
      AppConst.bottomDisplay = BottomDisplay.none;
    }
    notifyStream();
    update();
  }

  void restoreVideoScreen(BuildContext context) {
    if (currentActiveVideo == null) return;

    if (currentActiveVideo!.type == VideoSourceType.live) {
      AppConst.currentTabIndex = 1;
      update();
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const LiveVideoScreen(),
        ),
      );
    } else if (currentActiveVideo!.type == VideoSourceType.vod) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => VideoWatchScreen(
            videoUrl: currentActiveVideo!.videoUrl,
            videosId: currentActiveVideo!.videoId ?? 0,
            videoTitle: currentActiveVideo!.videoTitle,
            videoDescp: currentActiveVideo!.videoDescp,
            videoData: currentActiveVideo!.videoData is vci.Data
                ? currentActiveVideo!.videoData as vci.Data
                : null,
            datas: currentActiveVideo!.datas ?? <vci.Videos>[],
          ),
        ),
      );
    }
  }

  updateButton({required BottomDisplay button}) {
    AppConst.bottomDisplay = button;
    update();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    backGroundStreamController.sink.add(false);
  }

  void disposeMethod() {
    if (Get.find<HomeController>().audioPlayer.current.hasValue) {
      Get.find<HomeController>().audioPlayer.pause();
      Get.find<HomeController>().audioPlayer.dispose();
      Get.find<HomeController>().audioPlayer = AssetsAudioPlayer();
    }
    if (Get.find<RadioController>().audioPlayer.current.hasValue) {
      Get.find<RadioController>().audioPlayer.pause();
      Get.find<RadioController>().audioPlayer.dispose();
      Get.find<RadioController>().audioPlayer = AssetsAudioPlayer();
    }
  }

  RxString imageUrl = ''.obs;
  RxBool bottomBar = false.obs;
  RxBool loader = false.obs;

  void showLoader(bool value) {
    loader.value = value;
    update();
  }

  double bottomSheetHeight = 0.04;
  bool isLiveOn = false;

  RxInt currentTabIndex = 0.obs;
  final List<Widget> tabs = [
    const HomeScreen(),
    const LiveVideoScreen(),
    const RadioScreen(),
    const VideoListScreen(),
    const FavoritesScreen(),
    const PlayListScreen(),
    const MenuScreen(),
  ];
  File? file;
  MerchandiseDataModel? merchandiseDataModel;

  // Future<void> imageUpload() async {
  //   try {
  //     if (file?.path != null) {
  //       final response = http.MultipartRequest(
  //           "POST",
  //           Uri.parse(
  //               "https://alajazamusic.com/alajazamusicadmin/api/uploads"));
  //       response.files.add(await http.MultipartFile.fromPath(
  //         'image',
  //         file?.path ?? '',
  //       ));
  //       final streamedResponse = await response.send();
  //       if (streamedResponse.statusCode == 200) {
  //         final responseString =
  //             await streamedResponse.stream.transform(utf8.decoder).join();
  //         final decodedBody = jsonDecode(responseString);
  //         merchandiseDataModel = MerchandiseDataModel.fromJson(decodedBody);
  //         imageUrl.value = merchandiseDataModel?.link ?? decodedBody['url'];
  //         print("image ${imageUrl.value}");
  //         update();
  //
  //         print(decodedBody);
  //       }
  //     } else {
  //       Get.back();
  //       Utility.showSnackBar('Something went wrong in Upload Image',
  //           isError: true);
  //     }
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  Future<void> getFile() async {
    var status = await Permission.mediaLibrary.status;
    if (status.isDenied) {
      status = await Permission.mediaLibrary.request();
    }
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.image, withData: true);

    if (result != null) {
      File files = File(result.files.single.path ?? '');

      final croppedFile = await ImageCropper().cropImage(
          sourcePath: files.path ?? '',
          //     aspectRatioPresets: [
          //   CropAspectRatioPreset.square,
          //   CropAspectRatioPreset.ratio3x2,
          //   CropAspectRatioPreset.original,
          //   CropAspectRatioPreset.ratio4x3,
          //   CropAspectRatioPreset.ratio16x9
          // ],
          uiSettings: [
            AndroidUiSettings(lockAspectRatio: false),
          ]);
      file = File(croppedFile?.path ?? '');
      await Get.find<MenuPageController>().updateUserProfile();
      // imageUrl.value = file?.path??'';
      print(file);
      update();
    } else {
      // User canceled the picker
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      // ignore: use_build_context_synchronously
      Utility.showSnackBar("error in picking file", isError: true);
    }
  }

  Future<void> getCameraImage() async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    // FilePickerResult? result = await FilePicker.platform
    //     .pickFiles(type: FileType.image, withData: true);
    XFile? result = await ImagePicker.platform.getImageFromSource(
      source: ImageSource.camera,
    );
    print(result);
    if (result != null) {
      File files = File(result.path ?? '');

      final croppedFile = await ImageCropper().cropImage(
          sourcePath: files.path ?? '',
          //     aspectRatioPresets: [
          //   CropAspectRatioPreset.square,
          //   CropAspectRatioPreset.ratio3x2,
          //   CropAspectRatioPreset.original,
          //   CropAspectRatioPreset.ratio4x3,
          //   CropAspectRatioPreset.ratio16x9
          // ],
          uiSettings: [
            AndroidUiSettings(lockAspectRatio: false),
          ]);
      file = File(croppedFile?.path ?? '');
      // imageUrl.value = file?.path??'';
      await Get.find<MenuPageController>().updateUserProfile();
      print(file);
      update();
    } else {
      // User canceled the picker
      // You can show snackbar or fluttertoast
      // here like this to show warning to user
      // ignore: use_build_context_synchronously
      Utility.showSnackBar("error in picking file", isError: true);
    }
  }

  Future<void> getCameraFile(BuildContext context) async {
    List<CameraDescription> cameras = await availableCameras();
    CameraDescription frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    CameraDescription backCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);

    PermissionStatus status = await Permission.camera.status;
    status = await Permission.camera.request();

    if (status.isDenied) {
      status = await Permission.camera.request();
    }
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => TakePictureScreen(
                  frontCamera: frontCamera,
                  rearCamera: backCamera,
                )));

    // PickedFile? result = await ImagePicker.platform.pickImage(
    //     source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
  }

  Future<void> takeCameraPicture(String path) async {
    File files = File(path ?? '');

    final croppedFile = await ImageCropper().cropImage(
        sourcePath: files.path ?? '',
        //     aspectRatioPresets: [
        //   CropAspectRatioPreset.square,
        //   CropAspectRatioPreset.ratio3x2,
        //   CropAspectRatioPreset.original,
        //   CropAspectRatioPreset.ratio4x3,
        //   CropAspectRatioPreset.ratio16x9
        // ],
        uiSettings: [
          AndroidUiSettings(lockAspectRatio: false),
        ]);
    file = File(croppedFile?.path ?? '');
    await Get.find<MenuPageController>().updateUserProfile();
    // imageUrl.value = file?.path??'';
    Get.back();
    print(file);
    update();
    }

  Rxn<BannerModel> banner = Rxn<BannerModel>();

  Future<void> getBannerSliders(
      {required String sliderType,
      required HomeChopperService homeChopperService}) async {
    try {
      final response =
          await homeChopperService.bannerSlider(sliderType: sliderType);
      if (response.isSuccessful) {
        banner.value = response.body;
        log(banner.value?.data.toString() ?? '');
        update();
      }
    } catch (e) {
      log('', name: 'Home Banner error', error: e.toString());
    }
  }

  Rxn<SearchDataModel> searchDataModel = Rxn<SearchDataModel>();

  Future<void> searchAPi(
      {required HomeChopperService homeChopperService,
      required String searchText}) async {
    try {
      showLoader(true);
      final response =
          await homeChopperService.searchAPi(searchText: searchText);
      if (response.body?.success == true) {
        searchDataModel.value = response.body;
        showLoader(false);
        update();
      } else {
        Utility.showSnackBar(response.body?.message, isError: false);
        showLoader(false);
        update();
      }
    } catch (e) {
      log('', name: 'search error', error: e.toString());
    }
  }
}
