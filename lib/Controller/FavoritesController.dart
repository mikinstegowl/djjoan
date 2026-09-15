import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Models/PlayListDataModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';

class FavoritesController extends BaseController {
  late HomeChopperService _homeChopperService;

  FavoritesController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  Rxn<PlayListDataModel> playListDataModel = Rxn<PlayListDataModel>();

  Future<void> getPlayList() async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken)
      };
      final queryParameters = {"type": "PlaylistList"};
      final response = await _homeChopperService.getPlayList(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        playListDataModel.value = response.body;
      }
    } catch (e) {}
  }
}
