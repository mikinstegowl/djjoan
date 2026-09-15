import 'dart:async';
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataListModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryItemModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryModel.dart';
import 'package:new_music_app/Utils/Models/VideoDetailModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class VideoController extends BaseController {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;
  late DatabaseReference messagesRef;
  StreamSubscription<DatabaseEvent>? messagesSubscription;
  late HomeChopperService _homeChopperService;
  int paginationInt = 1;
  Rxn<VideoCategoryDataModel> videoCategoryDataModel =
      Rxn<VideoCategoryDataModel>();
  Rxn<VideoCategoryModel> videoCategoryModel = Rxn<VideoCategoryModel>();

  VideoController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  @override
  onInit() async {
    super.onInit();
    await videoCategoryAPi();
    scrollControllerForVideoCategory.addListener(() {
      scrollControllerForVideoCategory1();
    });
    scrollControllerForVideoCategoryItem.addListener(() {
      scrollControllerForVideoCategoryItem1();
    });
  }

  // Future<void> videoCategoryApi() async {
  //   showLoader(true);
  //   try {
  //     final param = {
  //       "device": UserPreference.getValue(key: PrefKeys.deviceType),
  //       "token": UserPreference.getValue(key: PrefKeys.logInToken)
  //     };
  //     final queryParameters = {
  //       'menu_id': AppConst.menuId,
  //       "menu_type": AppConst.menuType,
  //       "limit": 7,
  //       'page': paginationInt
  //     };
  //     final response = await _homeChopperService.videoCategoryApi(
  //         param: param, queryParameters: queryParameters);
  //     if (response.isSuccessful) {
  //       videoCategoryDataModel.value = response.body;
  //       update();
  //     }
  //     showLoader(false);
  //   } catch (e) {
  //     showLoader(false);
  //     log('', error: e.toString(), name: 'Video Category Api Error');
  //   }
  // }

  Future<void> scrollControllerForVideoCategory1() async {
    if (scrollControllerForVideoCategory.hasClients) {
      if (scrollControllerForVideoCategory.position.pixels ==
          scrollControllerForVideoCategory.position.maxScrollExtent) {
        if (paginationInt < maxPage) {
          paginationInt++;
          await videoCategoryAPi();
        }
      }
    }
  }

  int maxPage = 1;
  ScrollController scrollControllerForVideoCategory = ScrollController();

  Future<void> videoCategoryAPi() async {
    showLoader(true);
    try {
      final queryParameters = {
        // 'menu_id': AppConst.menuId,
        // "menu_type": AppConst.menuType,
        // "limit": 7,
        'page': paginationInt
      };
      final response = await _homeChopperService.videoCategoryAPi(
          queryParameters: queryParameters);
      if (response.isSuccessful) {
        if (paginationInt == 1) {
          videoCategoryModel.value = response.body;
          maxPage = videoCategoryModel.value?.lastPage ?? 1;
          update();
        } else {
          videoCategoryModel.value?.data?.addAll(response.body?.data ?? []);
          update();
        }
      }
      showLoader(false);
    } catch (e) {
      showLoader(false);
      log('', error: e.toString(), name: 'Video Category Api Error');
    }
  }

  Rxn<VideoCategoryDataListModel> videoCategoryDataListModel =
      Rxn<VideoCategoryDataListModel>();
  Rxn<VideoCategoryItemModel> videoCategoryItemModel =
      Rxn<VideoCategoryItemModel>();

  // Future<void> videoCategoryListApi({required int categoryId}) async {
  //   try {
  //     final param = {
  //       "device": UserPreference.getValue(key: PrefKeys.deviceType),
  //       "token": UserPreference.getValue(key: PrefKeys.logInToken)
  //     };
  //     final queryParameters = {
  //       'menu_id': AppConst.menuId,
  //       'category_id': categoryId,
  //       'category_for': 'Videos',
  //       'limit': 15,
  //       'page': 1
  //     };
  //     final response = await _homeChopperService.videoCategoryItemsApi(
  //         param: param, queryParameters: queryParameters);
  //     if (response.isSuccessful) {
  //       videoCategoryDataListModel.value = response.body;
  //       update();
  //     }
  //   } catch (e) {
  //     log('', error: e.toString(), name: 'Video Category List Api error');
  //   }
  // }

  int page = 1;
  int max = 1;
  int? categoryId1;

  Future<void> scrollControllerForVideoCategoryItem1() async {
    if (scrollControllerForVideoCategoryItem.hasClients) {
      if (scrollControllerForVideoCategoryItem.position.pixels ==
          scrollControllerForVideoCategoryItem.position.maxScrollExtent) {
        if (page < max) {
          page++;
          await videoCategoryListApi(categoryId: categoryId1 ?? 0);
        }
      }
    }
  }

  ScrollController scrollControllerForVideoCategoryItem = ScrollController();

  Future<void> videoCategoryListApi({required int categoryId}) async {
    try {
      final queryParameters = {
        // 'menu_id': AppConst.menuId,
        // 'category_id': categoryId,
        // 'category_for': 'Videos',
        'limit': 15,
        'page': page
      };
      final response = await _homeChopperService.videoCategoryItemApi(
          queryParameters: queryParameters, categoryId: categoryId);
      if (response.isSuccessful) {
        if (page == 1) {
          videoCategoryItemModel.value = response.body;
          max = videoCategoryItemModel.value?.lastPage ?? 1;
          categoryId1 = videoCategoryItemModel.value?.data?.categoryId;
          update();
        } else {
          videoCategoryItemModel.value?.data?.videos
              ?.addAll(response.body?.data?.videos ?? []);
          update();
        }
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Video Category List Api error');
    }
  }

  VideoDetailModel? videoDetailModel;

  Future<void> videoDetailAPi({required int videoId}) async {
    try {
      showLoader(true);
      final response = await _homeChopperService.videoDetails(videoId: videoId);
      if (response.isSuccessful) {
        videoDetailModel = response.body;
        showLoader(false);
        update();
      }
      showLoader(false);
    } catch (e) {
      log('', error: e.toString(), name: 'Video Category List Api error');
    }
  }

  Future<bool?> addRemoveFavoriteVideoApi(
      {dynamic menuId, int? videoId}) async {
    try {
      final queryParameters = {'type': 'AddRemoveFavouriteVideos'};
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "menu_id": menuId,
        "videos_id": videoId
      };
      final response = await _homeChopperService.addRemoveFavouritesVideoApi(
          param: param, queryParameters: queryParameters);
      if (response.body?.status == 200) {
        Utility.showSnackBar(response.body?.message, isError: false);
        return response.body?.favouritesStatus ?? false;
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
        return null;
      }
    } catch (e) {
      log('', name: 'Add Remove Favorite Video', error: e.toString());
      rethrow;
    }
  }
}
