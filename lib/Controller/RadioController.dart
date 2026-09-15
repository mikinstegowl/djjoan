import 'dart:developer';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Models/LiveMediaModel.dart';
import 'package:new_music_app/Utils/Models/RadioModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';

class RadioController extends BaseController {
  late AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();
  late HomeChopperService _homeChopperService;

  RadioController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  Rxn<RadioModel> radioModel = Rxn<RadioModel>();
  Rxn<LiveMediaModel> liveMediaModel = Rxn<LiveMediaModel>();

  Future<void> getRadioAudio() async {
    try {
      print("this is radio  ${audioPlayer.current.hasValue}");
      disposeMethod();
      if (Get.isRegistered<BaseController>()) {
        Get.find<BaseController>().stopAndClearVideo();
      }
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final queryParameters = {"menu_id": 32, "menu_type": "Radio"};
      final response = await _homeChopperService.radioAudioApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        radioModel.value = response.body;
        if (Get.isRegistered<BaseController>()) {
          Get.find<BaseController>().updateButton(button: BottomDisplay.none);
          Get.find<BaseController>().notifyStream();
        }
        await audioPlayer.open(
          Audio.liveStream("https://radio4.domint.net:9072/stream",
              metas: Metas(
                  title: radioModel.value?.data?[0].songName,
                  artist: radioModel.value?.data?[0].songName,
                  image: MetasImage(
                      path: radioModel.value?.data?[0].songImage ?? '',
                      type: ImageType.network))),
          autoStart: true,
          notificationSettings: const NotificationSettings(
              nextEnabled: false, prevEnabled: false, stopEnabled: false),
          showNotification: true,
        );
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Radio Api error');
    }
  }

  Future<void> liveRadioAPi() async {
    try {
      print("this is radio  ${audioPlayer.current.hasValue}");
      disposeMethod();
      if (Get.isRegistered<BaseController>()) {
        Get.find<BaseController>().stopAndClearVideo();
      }
      final response =
          await _homeChopperService.liveMediaAPi(liveMediaType: 'radio');
      if (response.isSuccessful) {
        liveMediaModel.value = response.body;
        if (Get.isRegistered<BaseController>()) {
          Get.find<BaseController>().updateButton(button: BottomDisplay.none);
          Get.find<BaseController>().notifyStream();
        }
        await audioPlayer.open(
          Audio.liveStream(
              liveMediaModel.value?.data?.url ??
                  "https://radio4.domint.net:9072/stream",
              metas: Metas(
                  title: liveMediaModel.value?.data?.title,
                  // artist: liveMediaModel.value?.data?.title,
                  image: MetasImage(
                      path: liveMediaModel.value?.data?.image ?? '',
                      type: ImageType.network))),
          autoStart: true,
          notificationSettings: const NotificationSettings(
              nextEnabled: false, prevEnabled: false, stopEnabled: false),
          showNotification: true,
        );
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Radio Api error');
    }
  }
}
