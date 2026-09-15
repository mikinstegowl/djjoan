import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Bindings/AuthBinding.dart';
import 'package:new_music_app/Bindings/HomeBindings.dart';
import 'package:new_music_app/Bindings/MenuPageBinding.dart';
import 'package:new_music_app/Bindings/RadioBinding.dart';
import 'package:new_music_app/Bindings/VideoBinding.dart';
import 'package:new_music_app/SplashScreen.dart';
import 'package:new_music_app/Utils/Router/RouteName.dart';
import 'package:new_music_app/Utils/Widgets/AppNavigationScreen.dart';
import 'package:new_music_app/View/AuthScreens/CreateProfileScreen.dart';
import 'package:new_music_app/View/AuthScreens/ForgotPasswordScreen.dart';
import 'package:new_music_app/View/AuthScreens/LoginScreen.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/ChangePasswordScreen.dart';
import 'package:new_music_app/View/MenuScreen/SubScreens/MyProfileScreen.dart';
import 'package:new_music_app/View/VideoScreen/VideoListScreen.dart';
import 'package:new_music_app/View/WalkthroughScreen/WalkthroughScreen.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RoutesName.loginScreen:
      return getPageRoutes(
          routeName: RoutesName.loginScreen,
          page: () => const LoginScreen(),
          settings: settings,
          bindings: [AuthBinding()]);
    case RoutesName.createProfileScreen:
      return getPageRoutes(
          routeName: RoutesName.createProfileScreen,
          page: () => const CreateProfileScreen(),
          settings: settings,
          bindings: [AuthBinding()]);
    case RoutesName.forgotPasswordScreen:
      return getPageRoutes(
          routeName: RoutesName.forgotPasswordScreen,
          page: () => const ForgotPasswordScreen(),
          settings: settings,
          bindings: []);
    case RoutesName.homeScreen:
      return getPageRoutes(
          routeName: RoutesName.homeScreen,
          page: () => const AppNavigationScreen(),
          settings: settings,
          bindings: [
            AuthBinding(),
            HomeBindings(),
            RadioBindings(),
            VideoBinding(),
            MenuPageBinding()
          ]);
    case RoutesName.splashScreen:
      return getPageRoutes(
          routeName: RoutesName.splashScreen,
          page: () => const SplashScreen(),
          settings: settings,
          bindings: []);
    case RoutesName.changePasswordScreen:
      return getPageRoutes(
          routeName: RoutesName.changePasswordScreen,
          page: () => const ChangePasswordScreen(),
          settings: settings,
          bindings: [AuthBinding()]);
    case RoutesName.videoListScreen:
      return getPageRoutes(
          routeName: RoutesName.videoListScreen,
          page: () => const VideoListScreen(),
          settings: settings,
          bindings: [
            VideoBinding(),
          ]);
    case RoutesName.profileScreen:
      return getPageRoutes(
          routeName: RoutesName.songPage,
          page: () => const MyProfileScreen(),
          settings: settings,
          bindings: []);
    case RoutesName.walkthroughScreen:
      return getPageRoutes(
          routeName: RoutesName.walkthroughScreen,
          page: () => const WalkthroughScreen(),
          settings: settings,
          bindings: [AuthBinding()]);

    default:
      return getPageRoutes(
          routeName: RoutesName.loginScreen,
          page: () => const LoginScreen(),
          settings: settings,
          bindings: [AuthBinding()]);
  }
}

PageRoute getPageRoutes(
    {required String routeName,
    required Function page,
    required RouteSettings settings,
    List<Bindings>? bindings}) {
  return GetPageRoute(
      page: () => page(),
      routeName: routeName,
      settings: settings,
      bindings: bindings);
}
