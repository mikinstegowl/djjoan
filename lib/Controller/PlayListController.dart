import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/CreatePlayListModel.dart';
import 'package:new_music_app/Utils/Models/GetPlayListSongModel.dart';
import 'package:new_music_app/Utils/Models/GetPlaylistModel.dart' as i;
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Models/PlayListDataModel.dart' as data;
import 'package:new_music_app/Utils/Models/PlayListSongModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';

class PlayListController extends BaseController {
  late HomeChopperService _homeChopperService;

  PlayListController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  TextEditingController playListController = TextEditingController();
  TextEditingController createPlayListController = TextEditingController();
  TextEditingController playListSongController = TextEditingController();
  Rxn<data.PlayListDataModel> playListModel = Rxn<data.PlayListDataModel>();
  Rxn<i.GetPlayListModel> getPlayListModel = Rxn<i.GetPlayListModel>();

  @override
  void onInit() {
    // TODO: implement onInit
    scrollController.addListener(() {
      scrollListener();
    });
    scrollControllerFor1.addListener(() {
      scrollListenerFor1();
    });
    super.onInit();
  }

  Future<void> getPlayList() async {
    try {
      final queryParameters = {'type': 'PlaylistList'};
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
      };
      final response = await _homeChopperService.getPlayListApi(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        playListModel.value = response.body;
        update();
      }
    } catch (e) {
      log('', name: 'Get PlayList  Api error', error: e.toString());
    }
  }

  int page = 1;
  int maxPage = 1;
  ScrollController scrollController = ScrollController();

  Future<void> scrollListener() async {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (page < maxPage) {
          page++;
          await getPlayListAPi();
        }
      }
    }
  }

  Future<void> getPlayListAPi() async {
    try {
      final queryParameters = {'page': page};
      // final param = {
      //   "device": UserPreference.getValue(key: PrefKeys.deviceType),
      //   "token": UserPreference.getValue(key: PrefKeys.logInToken),
      // };
      final response = await _homeChopperService.getPlaylistAPi(
          queryParameters: queryParameters);
      if (response.isSuccessful) {
        if (page == 1) {
          getPlayListModel.value = response.body;
          maxPage = getPlayListModel.value?.lastPage ?? 1;
          update();
        } else {
          getPlayListModel.value?.data?.addAll(response.body?.data ?? []);
          update();
        }
      }
    } catch (e) {
      log('', name: 'Get PlayList  Api error', error: e.toString());
    }
  }

  Rxn<CreatePlayListModel> createPlayListModel = Rxn<CreatePlayListModel>();

  List<i.Data>? filterPlaylist;

  void searchPlaylist(String value) {
    if (filterPlaylist == []) {
      filterPlaylist = getPlayListModel.value?.data;
    }
    if (playListController.text != '') {
      getPlayListModel.value?.data = getPlayListModel.value?.data
          ?.where((element) =>
              element.playlistName
                  ?.toLowerCase()
                  .toString()
                  .contains(value.toString().toLowerCase()) ??
              false)
          .toList();
      update();
    } else {
      playListModel.value = null;
      getPlayList();
    }
  }

  List<AssestsSong>? filterPlaylistSong;

  void searchPlaylistSong(String value, int id) {
    if (filterPlaylistSong == []) {
      filterPlaylistSong = playListSongModel.value?.data ?? [];
    }
    if (playListSongController.text != '') {
      playListSongModel.value?.data = playListSongModel.value?.data
          ?.where((element) =>
              element.songName
                  ?.toLowerCase()
                  .toString()
                  .contains(value.toString().toLowerCase()) ??
              false)
          .toList();
      update();
    } else {
      playListSongModel.value = null;
      // playListSongApi(id);
    }
  }

  Future<bool> createPlayList() async {
    try {
      showLoader(true);

      final param = {"playlist_name": createPlayListController.text};

      final response =
          await _homeChopperService.createPlayListApi(param: param);

      showLoader(false); // moved up for safety

      if (response.body?.success == true) {
        createPlayListModel.value = response.body;
        update(); // triggers GetBuilder if used

        createPlayListController.clear();

        // Close dialog if needed
        Get.back(); // Close create playlist dialog
        Get.back(); // If dialog was stacked
        Utility.showSnackBar(response.body?.message);
        return true;
      } else {
        createPlayListController.clear();
        Utility.showSnackBar(response.body?.message, isError: true);
        return false;
      }
    } catch (e) {
      showLoader(false);
      log('Create PlayList Api error: $e');
      return false; // << Needed to avoid future hanging
    }
  }

  Future<void> deletePlayList(int id) async {
    try {
      final queryParameters = {'type': 'PlaylistRemove'};
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "playlist_id": id
      };
      final response = await _homeChopperService.removePlayList(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        playListModel.value?.data
            ?.removeWhere((element) => element.playlistId == id);
        Get.back();
        Utility.showSnackBar(response.body?.message);

        print(response.body?.message);
        update();
      }
    } catch (e) {
      log('', name: 'Delete PlayList Api', error: e.toString());
    }
  }

  Future<void> deletePlayListAPi(int id) async {
    try {
      final response =
          await _homeChopperService.deletePlaylistApi(playlistId: id);
      if (response.isSuccessful) {
        getPlayListModel.value?.data
            ?.removeWhere((element) => element.id == id);
        Get.back();
        Utility.showSnackBar(response.body?.message);

        print(response.body?.message);
        update();
      }
    } catch (e) {
      log('', name: 'Delete PlayList Api', error: e.toString());
    }
  }

  Rxn<PlayListSongModel> playListSongModel = Rxn<PlayListSongModel>();

  Rxn<GetPlayListSongModel> getPlayListSongModel = Rxn<GetPlayListSongModel>();

  int pages = 1;

  int maxes = 1;
  int? id1;
  ScrollController scrollControllerFor1 = ScrollController();

  Future<void> scrollListenerFor1() async {
    if (scrollControllerFor1.hasClients) {
      if (scrollControllerFor1.position.pixels ==
          scrollControllerFor1.position.maxScrollExtent) {
        if (pages < maxes) {
          pages++;
          await getPlayListSongApi(id1 ?? 0);
        }
      }
    }
  }

  Future<void> getPlayListSongApi(int id) async {
    try {
      final queryParameters = {'limit': 15, "page": pages};
      final response = await _homeChopperService.getPlayListSong(
          playlistId: id, queryParameters: queryParameters);
      if (response.isSuccessful) {
        if (pages == 1) {
          getPlayListSongModel.value = response.body;
          maxes = getPlayListSongModel.value?.lastPage ?? 1;
          id1 = id;
          print(response.statusCode);
          update();
        } else {
          getPlayListSongModel.value?.data?.songs
              ?.addAll(response.body?.data?.songs ?? []);
          update();
        }
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      log('', name: 'Song List Api error', error: e.toString());
    }
  }

  Future<void> addSongToPlaylist(
      {required int menuId,
      required int songId,
      required int playlistId}) async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "menu_id": menuId,
        "song_id": songId,
        "playlist_id": playlistId
      };
      final queryParameters = {'type': 'AddPlaylistSongs'};
      final response = await _homeChopperService.addSongToPlaylist(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        Get.back();
        Utility.showSnackBar(response.body?.message);
      }
    } catch (e) {
      log('', name: 'Add Playlist Song Api error', error: e.toString());
    }
  }

  Future<void> removeSongFromPlaylist(
      {required int playlistId, required int songId}) async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "playlist_id": playlistId,
        "song_id": songId
      };
      final queryParameters = {'type': 'RemovePlaylistSongs'};
      final response = await _homeChopperService.removeSongFromPlaylist(
          param: param, queryParameters: queryParameters);
      if (response.isSuccessful) {
        Get.back();
        // playListSongApi(playlistId);

        Utility.showSnackBar(response.body?.message);
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
      }
    } catch (e) {
      log('', name: 'remove song from playlist error', error: e.toString());
    }
  }

  Future<void> deleteSongFromPlaylist(
      {required int playlistId, required int songId}) async {
    try {
      final queryParameters = {'playlistId': playlistId};
      final response = await _homeChopperService.deletePlaylistSongApi(
          songId: songId, queryParameters: queryParameters);
      if (response.isSuccessful) {
        Get.back();
        getPlayListSongApi(playlistId);

        Utility.showSnackBar(response.body?.message);
      } else {
        Utility.showSnackBar(response.body?.message, isError: true);
      }
    } catch (e) {
      log('', name: 'remove song from playlist error', error: e.toString());
    }
  }
}
