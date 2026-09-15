import 'dart:developer';
import 'dart:io';
import 'package:carousel_slider/carousel_controller.dart' as i;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/AuthChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/WalkthroughDataModel.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';

class AuthController extends BaseController {
  // RxString imageUrl = ''.obs;
  RxBool checkBox = false.obs;
  RxBool showPassword = true.obs;
  RxBool showCurrentPassword = true.obs;
  RxBool showConfirmPassword = true.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController currentPassword = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  i.CarouselSliderController carouselController = i.CarouselSliderController();
  late AuthChopperService _authChopperService;

  AuthController({required AuthChopperService authChopperService}) {
    _authChopperService = authChopperService;
  }

  // Future<void> signUp(BuildContext context) async {
  //   UserPreference.setValue(
  //       key: PrefKeys.deviceType,
  //       value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
  //           ? "IOS"
  //           : "android");
  //   final param = {
  //     "name": nameController.text,
  //     "username": userNameController.text,
  //     "email": emailController.text,
  //     "phone": phoneNumberController.text,
  //     "password": passwordController.text,
  //     "confirm_password": confirmPasswordController.text,
  //     // "fcm_id": "null",
  //     // "device": Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
  //     //     ? "iOS"
  //     //     : "Android",
  //     "image": imageUrl.value
  //   };
  //   try {
  //     final response = await _authChopperService.signUpApi(param: param);
  //     if (response.body?.statusCode == 200) {
  //       clearController();
  //       AppConst.currentTabIndex = 0;
  //       Get.offNamed(RoutesName.loginScreen);
  //       Utility.showSnackBar(
  //         response.body?.message,
  //       );
  //     } else {
  //       Utility.showSnackBar(response.body?.message, isError: true);
  //     }
  //   } catch (e) {
  //     log('', error: e.toString(), name: 'Sign Up Api error');
  //   }
  // }

  //
  // Future<void> signUpUserAPi(BuildContext context) async {
  //   // UserPreference.setValue(
  //   //     key: PrefKeys.deviceType,
  //   //     value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
  //   //         ? "IOS"
  //   //         : "android");
  //   final param = {
  //     "name": nameController.text,
  //     "username": userNameController.text,
  //     "email": emailController.text,
  //     "phone": phoneNumberController.text,
  //     "password": passwordController.text,
  //     "confirm_password": confirmPasswordController.text,
  //     // "fcm_id": "null",
  //     // "device": Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
  //     //     ? "iOS"
  //     //     : "Android",
  //     "image": imageUrl.value
  //   };
  //   try {
  //     final response = await _authChopperService.signUpUserAPi(param: param);
  //     if (response.body?.success == true) {
  //       clearController();
  //       AppConst.currentTabIndex = 0;
  //       Get.offNamed(RoutesName.loginScreen);
  //       Utility.showSnackBar(
  //         response.body?.message,
  //       );
  //     } else {
  //       Utility.showSnackBar(response.body?.message, isError: true);
  //     }
  //   } catch (e) {
  //     log('', error: e.toString(), name: 'Sign Up Api error');
  //   }
  // }

  Future<void> signUpUserAPi(BuildContext context) async {
    try {
      File? imageFile;
      if (imageUrl.value.isNotEmpty) {
        imageFile = File(imageUrl.value); // Convert path to File if not empty
      }

      final fcm = Platform.isAndroid
          ? await FirebaseMessaging.instance.getToken()
          : await FirebaseMessaging.instance.getToken();

      final response = await _authChopperService.signUpUserAPi(
          name: nameController.text,
          username: userNameController.text,
          email: emailController.text,
          phone: phoneNumberController.text,
          password: passwordController.text,
          confirmPassword: confirmPasswordController.text,
          fcm: fcm,
          // image: imageFile, // Optional image file
          deviceType: Platform.isAndroid ? 'Android' : 'Ios');

      print({
        'name': nameController.text,
        'username': userNameController.text,
        'email': emailController.text,
        'phone': phoneNumberController.text,
        'password': passwordController.text,
        'confirmPassword': confirmPasswordController.text,
        'fcm': fcm,
      });
      if (response.isSuccessful && response.body?.success == true) {
        clearController();
        AppConst.currentTabIndex = 0;
        Get.offNamed(RoutesName.loginScreen);
        Utility.showSnackBar(response.body?.message);
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
      }
    } catch (e) {
      log('Sign Up API Error', error: e.toString());
    }
  }

  // Future<void> signIn(BuildContext context) async {
  //   UserPreference.setValue(
  //       key: PrefKeys.deviceType,
  //       value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
  //           ? "IOS"
  //           : "android");
  //   try {
  //     final param = {
  //       "username": userNameController.text,
  //       "password": passwordController.text,
  //       "device": UserPreference.getValue(key: PrefKeys.deviceType),
  //       "fcm_id": "null"
  //     };
  //     final response = await _authChopperService.signInApi(param: param);
  //     if (response.body?.status == 200) {
  //       UserPreference.setValue(
  //           key: PrefKeys.logInToken, value: response.body?.token);
  //       UserPreference.setValue(
  //           key: PrefKeys.email, value: response.body?.data?[0].email);
  //       UserPreference.setValue(
  //           key: PrefKeys.userId, value: response.body?.data?[0].userId);
  //       UserPreference.setValue(
  //           key: PrefKeys.password, value: passwordController.text);
  //       Get.offNamed(RoutesName.homeScreen);
  //       update();
  //     } else {
  //       Utility.showSnackBar(response.body?.message, isError: true);
  //     }
  //   } catch (e) {
  //     log('', error: e.toString(), name: "Login error");
  //   }
  // }
  Future<void> logInAPi(BuildContext context) async {
    // UserPreference.setValue(
    //     key: PrefKeys.deviceType,
    //     value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
    //         ? "IOS"
    //         : "android");
    try {
      final fcm = Platform.isAndroid
          ? await FirebaseMessaging.instance.getToken()
          : await FirebaseMessaging.instance.getToken();

      final param = {
        // "username": userNameController.text,
        "username": userNameController.text,
        "password": passwordController.text,
        "device_type": Platform.isAndroid ? 'Android' : 'Ios',
        "fcm": fcm,
      };
      print("this is FCM$fcm");
      final response = await _authChopperService.logInAPi(param: param);
      if (response.body?.success == true) {
        UserPreference.setValue(
            key: PrefKeys.logInToken, value: response.body?.data?.token);
        UserPreference.setValue(
            key: PrefKeys.email, value: userNameController.value.text);
        Get.offNamed(RoutesName.homeScreen);
        update();
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
      }
    } catch (e) {
      log('', error: e.toString(), name: "Login error");
      Utility.showSnackBar(e.toString(), isError: true);
    }
  }

  // Future<void> skipUser(BuildContext context, [bool liveVideo = false]) async {
  //   UserPreference.setValue(
  //       key: PrefKeys.deviceType,
  //       value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
  //           ? "IOS"
  //           : "android");
  //   showLoader(true);
  //   try {
  //     final param = {
  //       "fcm_id": "null",
  //       "device": UserPreference.getValue(key: PrefKeys.deviceType)
  //     };
  //     final response = await _authChopperService.skipUserApi(param: param);
  //     if (response.isSuccessful) {
  //       print(response.statusCode);
  //       UserPreference.setValue(
  //           key: PrefKeys.logInToken, value: response.body?.token);
  //       UserPreference.setValue(
  //           key: PrefKeys.userId, value: response.body?.userId);
  //       update();
  //       showLoader(false);
  //       if (liveVideo) {
  //         AppConst.currentTabIndex = 1;
  //         Get.offNamed(RoutesName.homeScreen);
  //       } else {
  //         AppConst.currentTabIndex = 0;
  //         Get.offNamed(RoutesName.homeScreen);
  //       }
  //     } else {
  //       showLoader(false);
  //       Utility.showSnackBar(response.body?.message);
  //     }
  //   } catch (e) {
  //     showLoader(false);
  //     log('', name: 'Skip User Api', error: e.toString());
  //   }
  // }

  Future<void> skipAPi(BuildContext context,
      {bool liveVideo = false, bool homeScreen = false}) async {
    // UserPreference.setValue(
    //     key: PrefKeys.deviceType,
    //     value: Theme.of(Get.context ?? context).platform == TargetPlatform.iOS
    //         ? "IOS"
    //         : "android");
    showLoader(true);
    try {
      final fcm = Platform.isAndroid
          ? await FirebaseMessaging.instance.getToken()
          : await FirebaseMessaging.instance.getToken();
      final param = {
        "fcm_id": fcm,
        "device_type": Platform.isAndroid ? 'Android' : "Ios"
      };
      // print("this is FCM$"fcm"");
      final response = await _authChopperService.skipAPi(param: param);
      if (response.body?.success == true) {
        print(response.statusCode);
        UserPreference.setValue(
            key: PrefKeys.logInToken, value: response.body?.data?.token);
        // UserPreference.setValue(
        //     key: PrefKeys.userId, value: response.body?.userId);
        update();
        log('', name: 'Response Success', error: response.body?.message ?? "");
        showLoader(false);
        if (liveVideo) {
          AppConst.currentTabIndex = 1;
          Get.offNamed(RoutesName.homeScreen);
        } else {
          if (homeScreen == false) {
            AppConst.currentTabIndex = 0;
            Get.offNamed(RoutesName.homeScreen);
          }
        }
      } else {
        showLoader(false);
        Utility.showSnackBar(response.body?.message, isError: true);
      }
    } catch (e) {
      showLoader(false);
      log('', name: 'Skip Api', error: e.toString());
    }
  }

  WalkthroughDataModel? walkthroughDataModel;
  RxInt pageIndex = 0.obs;

  Future<void> walkthroughApi() async {
    try {
      final response = await _authChopperService.walkthroughApi();
      if (response.isSuccessful) {
        walkthroughDataModel = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'Walkthrough Api Error', error: e.toString());
    }
  }

  Future<void> changePasswordAPi(
      {required String currentPassword, newPassword}) async {
    try {
      showLoader(true);
      final param = {
        "currentPassword": currentPassword,
        "newPassword": newPassword
      };
      final response =
          await _authChopperService.changePasswordAPi(param: param);
      if (response.isSuccessful) {
        Utility.showSnackBar(response.body?.message);
        showLoader(false);
        update();
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
        showLoader(false);
        update();
      }
    } catch (e) {
      log('', name: 'change Pass Api Error', error: e.toString());
    }
  }

  void clearController() {
    nameController.clear();
    userNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }
}
