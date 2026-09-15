import 'dart:developer';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/RadioController.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Constants/AppConst.dart';
import 'package:new_music_app/Utils/Constants/AppExtension.dart';
import 'package:new_music_app/Utils/Constants/CustomSnackBar.dart';
import 'package:new_music_app/Utils/Models/AddAndRemoveFavouriteSongModel.dart';
import 'package:new_music_app/Utils/Models/CategorySongModel.dart';
import 'package:new_music_app/Utils/Models/FavouritesDataModel.dart';
import 'package:new_music_app/Utils/Models/GetFavouriteSongModel.dart' as i;
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
import 'package:new_music_app/Utils/Models/HomeModel.dart';
import 'package:new_music_app/Utils/Models/SongUpdateModel.dart';
import 'package:new_music_app/Utils/Models/ViewAllCategoryDataModel.dart';
import 'package:new_music_app/Utils/Models/ViewAllCategoryModel.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:new_music_app/View/HomeScreen/CategoryViewList.dart';
import 'package:share_plus/share_plus.dart';

class HomeController extends BaseController {
  late HomeChopperService _homeChopperService;
  late AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();

  // Rxn<HomeBannerModel> banner = Rxn<HomeBannerModel>();
  Rxn<HomeDataModel> homeData = Rxn<HomeDataModel>();
  Rxn<HomeModel> homeModel = Rxn<HomeModel>();
  int paginationInt = 1;
  int maxPages = 0;

  HomeController({required HomeChopperService homeChopperService}) {
    _homeChopperService = homeChopperService;
  }

  ScrollController scrollController = ScrollController();
  TextEditingController favoritesController = TextEditingController();

  RxInt bannerIndex = 0.obs;

  @override
  onInit() async {
    super.onInit();
    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: ["71777c03-19f7-45d7-9180-7ca6266beabb"]));
    if (audioPlayer.current.hasValue) {
      audioPlayer.pause();
    }
    if (Get.find<RadioController>().audioPlayer.current.hasValue) {
      Get.find<RadioController>().audioPlayer.pause();
    }
    await homeDataApi();
    await getBannerSliders(
        sliderType: 'home', homeChopperService: _homeChopperService);

    scrollController.addListener(() {
      scrollListener();
    });
    scrollControllerForCategorySong.addListener(() {
      scrollListenerForCategorySong();
    });
    scrollControllerForViewAllCategoryModel.addListener(() {
      scrollControllerForViewAllCategoryModel1();
    });
    scrollControllerForFavSong.addListener(() {
      scrollListenerFor();
    });
  }

  @override
  Future<void> scrollListener() async {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (paginationInt < maxPages) {
          paginationInt = paginationInt + 1;
          await homeDataApi();
        }
      }
    }
  }

  Future<void> shareSong({
    required String songName,
    required String artistName,
    required String songUrl,
    required int songId,
    required String action,
    required int currentIndex,
  }) async {
    try {
      await Share.share(
          "Song Name: $songName \n Song URL: $songUrl \n Artist Name: $artistName \n App Name: Jay Lyrics");
      songUpdateAPi(songId: songId, action: action, currentIndex: currentIndex);
      update();
    } catch (e) {
      log('', name: 'Share Song Error');
    }
  }

  SongUpdateModel? songUpdateModel;

  Future<void> songUpdateAPi(
      {required int songId, required String action, int? currentIndex}) async {
    showLoader(true);
    try {
      final Map<String, dynamic> param = {
        "songId": songId,
        "action": action,
      };
      final response = await _homeChopperService.updateSongStats(param: param);
      if (response.isSuccessful) {
        songUpdateModel = response.body;
        print("this is${songUpdateModel?.data?.isFavorite}");
        assetsSongs[currentIndex ?? 0].totalShared =
            songUpdateModel?.data?.totalShared;
        assetsSongs[currentIndex ?? 0].totalPlayed =
            songUpdateModel?.data?.totalPlayed;
        assetsSongs[currentIndex ?? 0].favoritesCount =
            songUpdateModel?.data?.favoritesCount;
        assetsSongs[currentIndex ?? 0].playListCount =
            songUpdateModel?.data?.playListCount;
        assetsSongs[currentIndex ?? 0].isFavourite =
            songUpdateModel?.data?.isFavorite;
        update();
        showLoader(false);
      }
      showLoader(false);
    } catch (e) {
      log('', name: 'Home Data Api', error: e.toString());
    }
  }

  // Future<void> homeDataApi() async {
  //   showLoader(true);
  //   try {
  //     final Map<String, dynamic> param = {
  //       "device": UserPreference.getValue(key: PrefKeys.deviceType),
  //       "token": UserPreference.getValue(key: PrefKeys.logInToken),
  //     };
  //
  //     final Map<String, dynamic> queryParameters = {
  //       'limit': 3,
  //       'page': paginationInt
  //     };
  //     print(paginationInt);
  //     final response = await _homeChopperService.homeDataApi(
  //         queryParameters: queryParameters, param: param);
  //     if (response.isSuccessful) {
  //       if (homeData.value != null) {
  //         homeData.value?.data?.addAll(response.body?.data ?? []);
  //       } else {
  //         homeData.value = response.body;
  //         maxPages = response.body?.lastPage ?? 1;
  //       }
  //       print("homeData ${homeData.value}");
  //       update();
  //       showLoader(false);
  //     }
  //     showLoader(false);
  //   } catch (e) {
  //     log('', name: 'Home Data Api', error: e.toString());
  //   }
  // }

  // HomeModel? homeModel;
  Future<void> homeDataApi() async {
    showLoader(true);
    try {
      // final Map<String, dynamic> param = {
      //   "device": UserPreference.getValue(key: PrefKeys.deviceType),
      //   "token": UserPreference.getValue(key: PrefKeys.logInToken),
      // };

      final Map<String, dynamic> queryParameters = {
        'limit': 3,
        'page': paginationInt
      };
      print(paginationInt);
      final response = await _homeChopperService.homeDataApi(
          queryParameters: queryParameters);
      if (response.isSuccessful) {
        if (homeModel.value != null) {
          homeModel.value?.data?.addAll(response.body?.data ?? []);
        } else {
          homeModel.value = response.body;
          maxPages = response.body?.lastPage ?? 1;
        }
        print("homeModel ${homeModel.value}");
        update();
        showLoader(false);
      }
      showLoader(false);
    } catch (e) {
      log('', name: 'Home Data Api', error: e.toString());
    }
  }

  Audio _audioFromSourceWithMetas(
    String url, {
    String? title,
    String? artist,
    String? image,
    int? favCount,
    int? playListCount,
  }) {
    final trimmedUrl = url.trim();
    final metas = Metas(
        title: title ?? 'Unknown Title',
        artist: artist ?? 'Unknown Artist',
        image: (image?.isNotEmpty ?? false)
            ? MetasImage.network(image!)
            : const MetasImage.asset('assets/default.jpg'),
        extra: {
          "favCount": favCount,
          "playListCount": playListCount,
        }
        // Fallback image
        );

    return trimmedUrl.startsWith('http')
        ? Audio.network(trimmedUrl, metas: metas)
        : Audio.file(trimmedUrl, metas: metas);
  }

  RxList<Items> assetsSongs = <Items>[].obs;
  RxInt? currentSongIndex = 0.obs;

  Future<void> playSong(
      {required List<Items> assests, required int index}) async {
    showLoader(true);
    try {
      assetsSongs.replaceRange(0, assetsSongs.length, assests.toList());
      currentSongIndex?.value = index;

      disposeMethod();
      Get.find<BaseController>().stopAndClearVideo();

      Get.find<BaseController>().mainStreamController.sink.add(true);
      AppConst.bottomDisplay = BottomDisplay.song;
      updateButton(button: BottomDisplay.song);

      Playlist playlist = Playlist();

      // Log all items for debugging
      for (int i = 0; i < assests.length; i++) {
        print('🔍 Index $i:');
        print('  songUrl: ${assests[i].songUrl}');
        print('  songFile: ${assests[i].songFile}');
        print('  songName: ${assests[i].songName}');
        print('  songArtist: ${assests[i].songArtist}');
        print('  favoritesCount: ${assests[i].favoritesCount}');
        print('  playListCount: ${assests[i].playListCount}');
      }

      // Add valid songs to playlist
      for (int i = 0; i < assests.length; i++) {
        final rawUrl = (assests[i].songUrl?.isNotEmpty ?? false)
            ? assests[i].songUrl
            : assests[i].songFile;

        final url = rawUrl?.trim() ?? '';

        if (url.isEmpty || !url.startsWith('http')) {
          print('❌ Skipping invalid URL at index $i: "$url"');
          continue;
        }

        final audio = _audioFromSourceWithMetas(url,
            title: assests[i].songName,
            artist: assests[i].songArtist,
            image: assests[i].songImage,
            favCount: assests[i].favoritesCount,
            playListCount: assests[i].playListCount);

        playlist.add(audio);
      }

      // Handle current song
      final rawCurrentUrl = (assetsSongs[index].songUrl?.isNotEmpty ?? false)
          ? assetsSongs[index].songUrl
          : assetsSongs[index].songFile;

      final currentUrl = rawCurrentUrl?.trim() ?? '';

      if (currentUrl.isEmpty || !currentUrl.startsWith('http')) {
        print("❌ Invalid currentUrl at index $index: '$currentUrl'");
        throw Exception("Invalid song URL at index $index");
      }

      playlist.removeAtIndex(index); // Remove from current position
      final currentAudio = _audioFromSourceWithMetas(currentUrl,
          title: assetsSongs[index].songName,
          artist: assetsSongs[index].songArtist,
          image: assetsSongs[index].songImage,
          favCount: assetsSongs[index].favoritesCount,
          playListCount: assetsSongs[index].playListCount);
      playlist.insert(0, currentAudio); // Insert current song at top

      print('✅ Opening audio for: $currentUrl');

      await audioPlayer.open(
        playlist,
        autoStart: true,
        audioFocusStrategy: const AudioFocusStrategy.request(
          resumeOthersPlayersAfterDone: true,
        ),
        playInBackground: PlayInBackground.enabled,
        notificationSettings: NotificationSettings(
          stopEnabled: false,
          playPauseEnabled: true,
          nextEnabled: true,
          prevEnabled: true,
          customNextAction: (player) =>
              player.next(keepLoopMode: true, stopIfLast: false),
          customPrevAction: (player) => player.previous(),
          seekBarEnabled: true,
        ),
        showNotification: true,
      );

      update();
      showLoader(false);
    } catch (e) {
      showLoader(false);
      log('Audio play error', name: 'playSong', error: e.toString());
      Utility.showSnackBar("Error playing song: ${e.toString()}",
          isError: true);
    }
  }

  FavouritesDataModel? favouritesDataModel;

  Future<bool?> addRemoveFavourites(
      {required int menuId, required int songId, int? assestsDataIndex}) async {
    try {
      final param = {
        "device": UserPreference.getValue(key: PrefKeys.deviceType),
        "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "menu_id": menuId,
        "song_id": songId
      };
      final queryParameters = {'type': 'AddRemoveSong'};
      final response = await _homeChopperService.addRemoveFavouritesApi(
          param: param, queryParameters: queryParameters);

      if (response.isSuccessful) {
        favouritesDataModel = response.body;
        if (assetsSongs.isNotEmpty) {
          // assetsSongs[currentSongIndex?.value ?? 0].favouritesCount =
          //     favouritesDataModel?.favouritesCount;
          // assetsSongs[currentSongIndex?.value ?? 0].favouritesStatus =
          //     favouritesDataModel?.favouritesStatus;

          Utility.showSnackBar(
            response.body?.message,
          );
          update();
          return favouritesDataModel?.favouritesStatus;
        } else {
          homeData.value?.data?[assestsDataIndex ?? 0].assests
              ?.firstWhere((element) => element.songId == songId)
              .favouritesStatus = response.body?.favouritesStatus;

          Utility.showSnackBar(
            response.body?.message,
          );
          update();
          return response.body?.favouritesStatus;
        }
        Utility.showSnackBar(
          response.body?.message,
        );
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Add and remove Favourites Api Error');
    }
    return null;
  }

  AddAndRemoveFavouriteSongModel? addAndRemoveFavouriteSongModel;

  Future<void> addSongToPlaylistAPi(
      {required int menuId,
      required int songId,
      int? assestsDataIndex,
      required int playlistId}) async {
    try {
      final param = {
        // "device": UserPreference.getValue(key: PrefKeys.deviceType),
        // "token": UserPreference.getValue(key: PrefKeys.logInToken),
        "menu_id": menuId,
        "song_id": songId,

        "playlist_id": playlistId
      };
      // final queryParameters = {'type': 'AddPlaylistSongs'};
      final response =
          await _homeChopperService.addSongToPlayListAPi(param: param);
      if (response.body?.success == true) {
        if (assetsSongs.isNotEmpty && assetsSongs.length > (assestsDataIndex ?? 0)) {
          assetsSongs[assestsDataIndex ?? 0].playListCount =
              response.body?.data?.playListCount ?? 0;
        }

        if (Get.isDialogOpen == true) {
          Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
        } else {
          Get.back();
        }
        Utility.showSnackBar(response.body?.message);
        update();
      } else {
        if (Get.isDialogOpen == true) {
          Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
        } else {
          Get.back();
        }
        Utility.showSnackBar(response.body?.message);
        update();
      }
    } catch (e) {
      if (Get.isDialogOpen == true) {
        Navigator.of(Get.overlayContext!, rootNavigator: true).pop();
      } else {
        Get.back();
      }
      Utility.showSnackBar("Something went wrong");
      log('', name: 'Add Playlist Song Api error', error: e.toString());
    }
  }

  Future<bool?> addRemoveSongFromFavourites(
      {int? menuId,
      required int songId,
      int? assestsDataIndex,
      String? type}) async {
    try {
      final param = {
        "id": songId,
        "menuId": menuId,
        "type": type == 'song' ? 'song' : 'video'
      };
      final response =
          await _homeChopperService.addRemoveSongFromFavourite(param: param);

      if (response.isSuccessful) {
        addAndRemoveFavouriteSongModel = response.body;
        if (type == 'song') {
          print(assetsSongs.length);
          if (assetsSongs.isNotEmpty) {
            // assetsSongs[currentSongIndex?.value ?? 0].favouritesCount =
            //     favouritesDataModel?.favouritesCount;
            // assetsSongs[currentSongIndex?.value ?? 0].favouritesStatus =
            //     favouritesDataModel?.favouritesStatus;
            // homeModel.value?.data?[assestsDataIndex ?? 0].items
            //     ?.firstWhere((element) => element.id == songId)
            //     .isFavourite = response.body?.isFavourite;
            assetsSongs[assestsDataIndex ?? 0].isFavourite =
                response.body?.isFavourite;
            assetsSongs[assestsDataIndex ?? 0].favoritesCount =
                response.body?.favouritesCount;
            Utility.showSnackBar(
              response.body?.message,
            );
            update();
            return addAndRemoveFavouriteSongModel?.isFavourite;
          } else {
            // homeModel.value?.data?[assestsDataIndex ?? 0].items
            //     ?.firstWhere((element) => element.id == songId)
            //     .isFavourite = response.body?.isFavourite;
            assetsSongs[assestsDataIndex ?? 0].isFavourite =
                response.body?.isFavourite;
            assetsSongs[assestsDataIndex ?? 0].favoritesCount =
                response.body?.favouritesCount;
            // paginationInt =  1;
            // homeDataApi();

            Utility.showSnackBar(
              response.body?.message,
            );
            update();
            return response.body?.isFavourite;
          }
        } else {
          // if(Get.find<VideoController>().videoDetailModel?.data?.id == songId){
          Get.find<VideoController>().videoDetailModel?.data?.isFavourite =
              response.body?.isFavourite;
          Get.find<VideoController>().videoDetailAPi(videoId: songId);
          Get.find<VideoController>().update();

          // };
          return response.body?.isFavourite;
        }
        Utility.showSnackBar(
          response.body?.message,
        );
        update();
      }
    } catch (e) {
      log('', error: e.toString(), name: 'Add and remove Favourites Api Error');
    }
    return null;
  }

  Rxn<i.GetFavouriteSongModel> getFavouriteSongModel =
      Rxn<i.GetFavouriteSongModel>();

  int pageInt = 1;
  int maxInt = 1;
  ScrollController scrollControllerForFavSong = ScrollController();

  Future<void> scrollListenerFor() async {
    if (scrollControllerForFavSong.hasClients) {
      if (scrollControllerForFavSong.position.pixels ==
          scrollControllerForFavSong.position.maxScrollExtent) {
        if (pageInt < maxInt) {
          pageInt++;
          await getFavoritesSong();
        }
      }
    }
  }

  Future<void> getFavoritesSong() async {
    try {
      final queryParameters = {'limit': 15, 'page': pageInt};

      final response = await _homeChopperService.getFavouriteSong(
          queryParameters: queryParameters);
      if (response.isSuccessful) {
        if (pageInt == 1) {
          getFavouriteSongModel.value = response.body;
          maxInt = getFavouriteSongModel.value?.lastPage ?? 1;
          update();
        } else {
          getFavouriteSongModel.value?.data?.addAll(response.body?.data ?? []);
          update();
        }
      }
    } catch (e) {
      log('', name: 'Get Favorite Song List Api error', error: e.toString());
    }
  }

  List<Items>? filterList;

  void searchFavorites(String value) async {
    filterList ??= getFavouriteSongModel.value?.data;
    if (favoritesController.text != '') {
      getFavouriteSongModel.value?.data = getFavouriteSongModel.value?.data
          ?.where((element) =>
              element.songName
                  ?.toLowerCase()
                  .toString()
                  .contains(value.toString().toLowerCase()) ??
              false)
          .toList();
      update();
    } else {
      getFavouriteSongModel.value = null;
      getFavoritesSong();
    }
  }

//get category songs listing
  ScrollController scrollControllerForCategorySong = ScrollController();

  Future<void> scrollListenerForCategorySong() async {
    if (scrollControllerForCategorySong.hasClients) {
      if (scrollControllerForCategorySong.position.pixels ==
          scrollControllerForCategorySong.position.maxScrollExtent) {
        if (page < maxPage) {
          page++;
          await getCategorySongList(
            id: id1 ?? 0,
            title: title1 ?? "",
            // context:context!,
          );
        }
      }
    }
  }

  CategorySongModel? categorySongModel;
  int page = 1;
  int maxPage = 1;
  int? id1;
  String? title1;
  BuildContext? context;

  Future<void> getCategorySongList(
      {required int id,
      required String title,
      BuildContext? context,
      bool isViewAll = false}) async {
    try {
      print(UserPreference.getValue(key: PrefKeys.email));
      final queryParameters = {"page": page};
      final response = await _homeChopperService.categoriesSongApi(
          queryParameters: queryParameters, id: id);
      if (response.isSuccessful) {
        // categoriesSongDataModel = response.body;
        if (page == 1) {
          categorySongModel = response.body;
          maxPage = categorySongModel?.lastPage ?? 1;
          id1 = id;
          title1 = title;
          update();
          if (!isViewAll) {
            UserPreference.setValue(key: PrefKeys.categoryName, value: title);
            Scaffold.of(context!).openEndDrawer();
          }
        } else {
          categorySongModel?.data?.songs
              ?.addAll(response.body?.data?.songs ?? []);
          // print("this is length${categorySongModel?.data?.songs?.length}");
          // maxPage = response.body?.nextPage ?? 1;
          // page = response.body?.nextPage??1;
          // print("this is max${maxPage}");
          update();
        }
      }
    } catch (e) {
      log("", error: e.toString(), name: 'get category song error api');
    }
  }

  ViewAllCategoryDataModel? viewAllCategoryDataModel;

  ViewAllCategoryModel? viewAllCategoryModel;
  int pagination = 1;
  int maxPageForCategory = 1;
  int? menuId;
  ScrollController scrollControllerForViewAllCategoryModel = ScrollController();

  Future<void> scrollControllerForViewAllCategoryModel1() async {
    if (scrollControllerForViewAllCategoryModel.hasClients) {
      if (scrollControllerForViewAllCategoryModel.position.pixels ==
          scrollControllerForViewAllCategoryModel.position.maxScrollExtent) {
        if (pagination < maxPageForCategory) {
          pagination++;
          await getCategoryList(
            id: menuId ?? 0,
            // context:context!,
          );
        }
      }
    }
  }

  Future<void> getCategoryList({required int id, BuildContext? context}) async {
    try {
      final queryParameters = {"limit": 15, "page": pagination};

      final response = await _homeChopperService.categoriesViewAllApi(
          id: id, queryParameters: queryParameters);
      if (response.isSuccessful) {
        if (pagination == 1) {
          viewAllCategoryModel = response.body;
          maxPageForCategory = viewAllCategoryModel?.lastPage ?? 1;
          menuId = id;
          Navigator.push(
              context!,
              PageRouteBuilder(
                  pageBuilder: (_, __, ___) => const CategoryViewList()));
          update();
        } else {
          viewAllCategoryModel?.data?.categories
              ?.addAll(response.body?.data?.categories ?? []);
          update();
        }
      }
    } catch (e) {
      log("", error: e.toString(), name: "Get all category");
    }
  }
}
