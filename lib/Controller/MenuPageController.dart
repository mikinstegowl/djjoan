import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/FavouriteVideoModel.dart';
import 'package:new_music_app/Utils/Models/GetFavouriteVideoModel.dart';
import 'package:new_music_app/Utils/Models/GetNotificationModel.dart';
import 'package:new_music_app/Utils/Models/GetSocialMediaModel.dart';
import 'package:new_music_app/Utils/Models/GetUserProfileModel.dart';
import 'package:new_music_app/Utils/Models/NotificationDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchAlbumDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchSongDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchVideosDataModel.dart';
import 'package:new_music_app/Utils/Models/SignInModel.dart';
import 'package:new_music_app/Utils/Models/SocialMediaModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';

class MenuPageController extends BaseController {
  TextEditingController globalSearchController = TextEditingController();
  TextEditingController bookingNameController = TextEditingController();
  TextEditingController bookingEmailController = TextEditingController();
  TextEditingController bookingCommentController = TextEditingController();
  TextEditingController bookingPhoneController = TextEditingController();
  RxBool pageLoder = false.obs;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    scrollController.addListener((){
      scrollListener();
    });
    scrollController1.addListener((){
      scrollListener1();
    });
  }
  void showPageLoader(bool value) {
    pageLoder.value = value;
    update();
  }

  late HomeChopperService _homeChopperService;

  MenuPageController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  RxString url = ''.obs;

  Future<String> getMerchandiseApi() async {
    try {
      final response = await _homeChopperService.getMerchandiseApi();
      if (response.isSuccessful) {
        url.value = response.body?.link ?? '';
        update();
        return url.value;
      } else {
        return '';
      }
    } catch (e) {
      log('', name: 'Get Merchandise Api error', error: e.toString());
      return '';
    }
  }

  SignInModel? signInModel;
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  Future<void> getProfileApi() async {
    showPageLoader(true);
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final queryParameters = {'type': 'ProfileDetails'};
      final response = await _homeChopperService.getProfileApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        signInModel = response.body;
        nameController =
            TextEditingController(text: signInModel?.data?[0].name);
        userNameController =
            TextEditingController(text: signInModel?.data?[0].username);
        emailController =
            TextEditingController(text: signInModel?.data?[0].email);
        phoneController =
            TextEditingController(text: signInModel?.data?[0].phone ?? '0');
        Get.find<BaseController>().imageUrl.value =
            signInModel?.data?[0].image ?? '';

        update();
        // showPageLoader(false);
      }

      showPageLoader(false);
    } catch (e) {
      log('', error: e.toString(), name: 'Profile Api Error');
      showPageLoader(false);
    }
  }
  GetUserProfileModel? getUserProfileModel;
  Future<void> getUserProfileApi() async {
    showPageLoader(true);
    try {
      final response = await _homeChopperService.getUserProfile();
      if (response.isSuccessful) {
        getUserProfileModel = response.body;

        nameController =
            TextEditingController(text: getUserProfileModel?.data?.name);
        userNameController =
            TextEditingController(text: getUserProfileModel?.data?.username);
        emailController =
            TextEditingController(text: getUserProfileModel?.data?.email);
        phoneController =
            TextEditingController(text: getUserProfileModel?.data?.phone ?? '0');
        Get.find<BaseController>().imageUrl.value =
            getUserProfileModel?.data?.image ?? '';
        UserPreference.setValue(key: PrefKeys.userId,value: getUserProfileModel?.data?.id);
        UserPreference.setValue(key: PrefKeys.userImage,value: getUserProfileModel?.data?.image);
        UserPreference.setValue(key: PrefKeys.userName,value: getUserProfileModel?.data?.name);
        update();
        // showPageLoader(false);
      }

      showPageLoader(false);
    } catch (e) {
      log('', error: e.toString(), name: 'Profile Api Error');
      showPageLoader(false);
    }
  }
  Future<void> updateUserProfile() async {
    showPageLoader(true);
    try {
      final response =
          Get.find<BaseController>().file?.path.isNotEmpty??false? await _homeChopperService.updateProfile(
        id: UserPreference.getValue(key: PrefKeys.userId).toString(),
          name: nameController.text,
          oldImage: imageUrl.value,
          phone: phoneController.text,
          profileImage: Get.find<BaseController>().file?.path??'',): await _homeChopperService.updateProfile(
            id: UserPreference.getValue(key: PrefKeys.userId).toString(),
            name: nameController.text,
            oldImage: imageUrl.value,
            phone: phoneController.text,);

      if (response.isSuccessful) {
        print("old ${imageUrl.value}");
        getUserProfileApi();
        update();
        Utility.showSnackBar(response.body?.message);
        // showPageLoader(false);
      }
      showPageLoader(false);
    } catch (e) {
      log('', error: e.toString(), name: 'update Profile Api Error');
      showPageLoader(false);
    }
  }












  Rxn<FavouriteVideoModel> favouriteVideoModel = Rxn<FavouriteVideoModel>();


  Rxn<GetFavouriteVideoModel> getFavouriteVideoModel = Rxn<GetFavouriteVideoModel>();


  int page1 = 1;
  int max1 = 1;
  ScrollController scrollController1 = ScrollController();
  Future<void> scrollListener1() async {
    if (scrollController1.hasClients) {

      if (scrollController1.position.pixels ==
          scrollController1.position.maxScrollExtent) {

        if (page1 < max1) {
          page1++;
          await geFavouriteVideoApi();
        }
      }
    }
  }

  Future<void> geFavouriteVideoApi() async {
    try {
      final queryParameters = {
        'limit': 15,
        "page": page1
      };
      final response = await _homeChopperService.getFavouriteVideo(
           queryParameters: queryParameters);
      if (response.isSuccessful) {
            if(page1 ==1)  {
          getFavouriteVideoModel.value = response.body;
          max1 = getFavouriteVideoModel.value?.lastPage??1;
          print(response.statusCode);
          update();
        }else{
              getFavouriteVideoModel.value?.data?.addAll(response.body?.data??[]);
              update();
            }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      log('', name: 'Favourite Video Api error', error: e.toString());
    }
  }


  Rxn<SocialMediaModel> socialMediaModel = Rxn<SocialMediaModel>();
  Rxn<GetSocialMediaModel> getSocialMediaModel = Rxn<GetSocialMediaModel>();

  Future<void> socialMediaApi() async {
    try {
      final param = {
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.socialMediaApi(param: param);
      if (response.isSuccessful) {
        socialMediaModel.value = response.body;
      }
    } catch (e) {
      log('', name: 'SocialMedia Api error', error: e.toString());
    }
  }
  Future<void> socialMedia() async {
    try {
      final param = {
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.getSocialMedia();
      if (response.isSuccessful) {
        getSocialMediaModel.value = response.body;
      }
    } catch (e) {
      log('', name: 'SocialMedia Api error', error: e.toString());
    }
  }

  Rxn<SearchSongDataModel> searchSongResult = Rxn<SearchSongDataModel>();

  Future<void> songSearchApi() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "search": globalSearchController.text,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "type": "songs"
      };
      final queryParameters = {"limit": 50, "page": 1};
      final response = await _homeChopperService.searchSongs(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        searchSongResult.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'search song error api', error: e.toString());
    }
  }

  Rxn<SearchAlbumDataModel> searchAlbumResult = Rxn<SearchAlbumDataModel>();

  Future<void> albumSearchApi() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "search": globalSearchController.text,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "type": "album"
      };
      final queryParameters = {"limit": 50, "page": 1};
      final response = await _homeChopperService.searchAlbum(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        searchAlbumResult.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'search song error api', error: e.toString());
    }
  }

  Rxn<SearchVideosDataModel> searchVideoResult = Rxn<SearchVideosDataModel>();

  Future<void> videoSearchApi() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "search": globalSearchController.text,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "type": "videos"
      };
      final queryParameters = {"limit": 50, "page": 1};
      final response = await _homeChopperService.searchVideos(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        searchVideoResult.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'search song error api', error: e.toString());
    }
  }

  Future<void> bookingApi() async {
    try {
      final param = {
        "comment": bookingCommentController.text,
        "email": bookingEmailController.text,
        "name": bookingNameController.text,
        "phone": bookingPhoneController.text,
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.bookingApi(param: param);
      if (response.isSuccessful) {
        Utility.showSnackBar(response.body?.message);
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Booking Api');
    }
  }

  Rxn<NotificationDataModel> notificationDataModel =
      Rxn<NotificationDataModel>();
  Rxn<GetNotificationModel> getNotificationModel =
      Rxn<GetNotificationModel>();

  Future<void> notificationApi() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final response = await _homeChopperService.notificationApi(param: param);
      if (response.isSuccessful) {
        notificationDataModel.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'Notification Api error');
    }
  }

  int page=1;
  int maxPage=1;
  ScrollController scrollController = ScrollController();
  Future<void> scrollListener() async {
    if (scrollController.hasClients) {

      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {

        if (page < maxPage) {
          page++;
          await getNotificationApi();
        }
      }
    }
  }
  Future<void> getNotificationApi() async {
    try {
      final queryParameters = {
        "page": page,
      };
      final response = await _homeChopperService.getNotification(queryParameters: queryParameters);
      if (response.isSuccessful) {
            if(page ==1) {
          getNotificationModel.value = response.body;
          maxPage = getNotificationModel.value?.lastPage ?? 1;
          update();
        }else{
              getNotificationModel.value?.data?.addAll(response.body?.data??[]);
              update();
            }
      }
    } catch (e) {
      log('', name: 'Notification Api error');
    }
  }
}
