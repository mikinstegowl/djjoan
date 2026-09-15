import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:new_music_app/Utils/Models/AddAndRemoveFavouriteSongModel.dart';
import 'package:new_music_app/Utils/Models/AddSongPlayListModel.dart';
import 'package:new_music_app/Utils/Models/AddSongPlaylistDataModel.dart';
import 'package:new_music_app/Utils/Models/BannerModel.dart';
import 'package:new_music_app/Utils/Models/CategorySongModel.dart';
import 'package:new_music_app/Utils/Models/CreatePlayListModel.dart';
import 'package:new_music_app/Utils/Models/FIrebaseAuthModel.dart';
import 'package:new_music_app/Utils/Models/FavoritesSongListModel.dart';
import 'package:new_music_app/Utils/Models/FavouriteVideoModel.dart';
import 'package:new_music_app/Utils/Models/FavouritesDataModel.dart';
import 'package:new_music_app/Utils/Models/GeneralErrorModel.dart';
import 'package:new_music_app/Utils/Models/GetFavouriteSongModel.dart';
import 'package:new_music_app/Utils/Models/GetFavouriteVideoModel.dart';
import 'package:new_music_app/Utils/Models/GetNotificationModel.dart';
import 'package:new_music_app/Utils/Models/GetPlayListSongModel.dart';
import 'package:new_music_app/Utils/Models/GetPlaylistModel.dart';
import 'package:new_music_app/Utils/Models/GetSocialMediaModel.dart';
import 'package:new_music_app/Utils/Models/GetUserProfileModel.dart';
import 'package:new_music_app/Utils/Models/HomeModel.dart';
import 'package:new_music_app/Utils/Models/LiveMediaModel.dart';
import 'package:new_music_app/Utils/Models/LiveVideoLikeModel.dart';
import 'package:new_music_app/Utils/Models/LiveVideoModel.dart';
import 'package:new_music_app/Utils/Models/MerchandiseDataModel.dart';
import 'package:new_music_app/Utils/Models/NotificationDataModel.dart';
import 'package:new_music_app/Utils/Models/PlayListDataModel.dart';
import 'package:new_music_app/Utils/Models/PlayListSongModel.dart';
import 'package:new_music_app/Utils/Models/RadioModel.dart';
import 'package:new_music_app/Utils/Models/SearchAlbumDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchSongDataModel.dart';
import 'package:new_music_app/Utils/Models/SearchVideosDataModel.dart';
import 'package:new_music_app/Utils/Models/SignInModel.dart';
import 'package:new_music_app/Utils/Models/SocialMediaModel.dart';
import 'package:new_music_app/Utils/Models/SongUpdateModel.dart';
import 'package:new_music_app/Utils/Models/SponsorBannerDataModel.dart';
import 'package:new_music_app/Utils/Models/SubscriptionStatusModel.dart';
import 'package:new_music_app/Utils/Models/SubscriptionTokenModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataListModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryDataModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryItemModel.dart';
import 'package:new_music_app/Utils/Models/VideoCategoryModel.dart';
import 'package:new_music_app/Utils/Models/VideoDetailModel.dart';
import 'package:new_music_app/Utils/Models/ViewAllCategoryDataModel.dart';
import 'package:new_music_app/Utils/Models/ViewAllCategoryModel.dart';

part 'HomeChopperService.chopper.dart';

@ChopperApi()
abstract class HomeChopperService extends ChopperService {
  static HomeChopperService create({ChopperClient? client}) {
    return _$HomeChopperService(client);
  }

  // @Post(path: 'bannerslider')
  // Future<Response<HomeBannerModel>> bannerSlider(
  //     {@body required Map<String, dynamic> param});
  //
  // @Post(path: 'home')
  // Future<Response<HomeDataModel>> homeDataApi(
  //     {@body required Map<String, dynamic> param,
  //     @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'menuitems')
  Future<Response<VideoCategoryDataModel>> videoCategoryApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'categoryitems')
  Future<Response<VideoCategoryDataListModel>> videoCategoryItemsApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  // @Post(path: 'audiolisting/category_id/{id}')
  // Future<Response<CategoriesSongDataModel>> categoriesSongApi(
  //     {@body required Map<String, dynamic> param,
  //     @Path('id') required int id,
  //     @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'audiosubcategories/{id}')
  Future<Response<ViewAllCategoryDataModel>> viewAllCategoriesApi(
      {@body required Map<String, dynamic> param,
      @Path('id') required int id,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'menuitems')
  Future<Response<RadioModel>> radioAudioApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'menuitems')
  Future<Response<LiveVideoModel>> liveVideoApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlist')
  Future<Response<PlayListDataModel>> getPlayList(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'favourites')
  Future<Response<FavouritesDataModel>> addRemoveFavouritesApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'favouritevideos')
  Future<Response<FavouritesDataModel>> addRemoveFavouritesVideoApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'favourites')
  Future<Response<FavoriteSongListModel>> favoritesSongsApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'profile')
  Future<Response<SignInModel>> getProfileApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlist')
  Future<Response<PlayListDataModel>> getPlayListApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlist')
  Future<Response<GeneralErrorModel>> removePlayList(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlistsongs')
  Future<Response<PlayListSongModel>> playListSongApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'favouritevideos')
  Future<Response<FavouriteVideoModel>> favouriteVideoApi(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlistsongs')
  Future<Response<AddSongPlaylistDataModel>> addSongToPlaylist(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'playlistsongs')
  Future<Response<GeneralErrorModel>> removeSongFromPlaylist(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'search')
  Future<Response<SearchSongDataModel>> searchSongs(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'search')
  Future<Response<SearchAlbumDataModel>> searchAlbum(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: 'search')
  Future<Response<SearchVideosDataModel>> searchVideos(
      {@body required Map<String, dynamic> param,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Get(path: 'merchandise')
  Future<Response<MerchandiseDataModel>> getMerchandiseApi();

  @Get(path: 'sponsor')
  Future<Response<SponsorBannerDataModel>> sponsorBannerApi();

  @Post(path: 'socialmedia')
  Future<Response<SocialMediaModel>> socialMediaApi(
      {@body required Map<String, dynamic> param});

  @Post(path: 'booking')
  Future<Response<GeneralErrorModel>> bookingApi(
      {@body required Map<String, dynamic> param});

  @Post(path: 'notifications')
  Future<Response<NotificationDataModel>> notificationApi(
      {@body required Map<String, dynamic> param});

  /// new Api
  // @Get(path: '/menus-tracks-category')
  // Future<Response<HomeDataModel>> homeDataApi(
  //     @QueryMap() Map<String, dynamic>? queryParameters, // Remove `required`
  //     );

  @Get(path: '/home-menu')
  Future<Response<HomeModel>> homeDataApi(
      {@QueryMap() required Map<String, dynamic> queryParameters});

  @Get(path: '/tracks-category-items/{id}')
  Future<Response<CategorySongModel>> categoriesSongApi(
      {@Path('id') required int id,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Get(path: '/menu-categories/{id}')
  Future<Response<ViewAllCategoryModel>> categoriesViewAllApi(
      {@Path('id') required int id,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Get(path: '/slider/{sliderType}')
  Future<Response<BannerModel>> bannerSlider(
      {@Path('sliderType') required String sliderType});

  @Get(path: '/video-category')
  Future<Response<VideoCategoryModel>> videoCategoryAPi(
      {@QueryMap() required Map<String, dynamic> queryParameters});

  @Get(path: '/videos-category-items/{categoryId}')
  Future<Response<VideoCategoryItemModel>> videoCategoryItemApi(
      {@Path('categoryId') required int categoryId,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Get(path: '/video-details/{videoId}')
  Future<Response<VideoDetailModel>> videoDetails(
      {@Path('videoId') required int videoId});

  @Get(path: '/live-media/{liveMediaType}')
  Future<Response<LiveMediaModel>> liveMediaAPi(
      {@Path('liveMediaType') required String liveMediaType});

  @Post(path: '/playlist')
  Future<Response<CreatePlayListModel>> createPlayListApi(
      {@body required Map<String, dynamic> param});

  @Get(path: '/playlist')
  Future<Response<GetPlayListModel>> getPlaylistAPi(
      {@QueryMap() required Map<String, dynamic> queryParameters});

  // /playlist-songs
  @Post(path: '/playlist-songs')
  Future<Response<AddSongPlayListModel>> addSongToPlayListAPi(
      {@body required Map<String, dynamic> param});

  @Delete(path: '/playlist/{playListId}')
  Future<Response<GeneralErrorModel>> deletePlaylistApi(
      {@Path('playListId') required int playlistId});

  @Get(path: '/playlist-songs/{playListId}')
  Future<Response<GetPlayListSongModel>> getPlayListSong(
      {@Path('playListId') required int playlistId,
      @QueryMap() required Map<String, dynamic> queryParameters});
  //

  @Delete(path: '/delete-playlist-song/{songId}')
  Future<Response<GeneralErrorModel>> deletePlaylistSongApi(
      {@Path('songId') required int songId,
      @QueryMap() required Map<String, dynamic> queryParameters});

  @Post(path: '/favourite/toggle')
  Future<Response<AddAndRemoveFavouriteSongModel>> addRemoveSongFromFavourite(
      {@body required Map<String, dynamic> param});

  @Patch(path: '/song-stats')
  Future<Response<SongUpdateModel>> updateSongStats(
      {@body required Map<String, dynamic> param});

  @Patch(path: '/live-video-like/toggle')
  Future<Response<LiveVideoLikeModel>> liveVideoLikeAPi(
      {@body required Map<String, dynamic> param});

  // favourite/songs
  @Get(path: '/favourite/songs')
  Future<Response<GetFavouriteSongModel>> getFavouriteSong(
      {@QueryMap() required Map<String, dynamic> queryParameters});

  // /favourite/videos?page=1
  @Get(path: '/favourite/videos')
  Future<Response<GetFavouriteVideoModel>> getFavouriteVideo(
      {@QueryMap() required Map<String, dynamic> queryParameters});

  // /social-links
  @Get(path: '/social-links')
  Future<Response<GetSocialMediaModel>> getSocialMedia();



  //


  @Get(path: '/search/{searchText}')
  Future<Response<SearchDataModel>> searchAPi(
      {@Path('searchText') required String searchText});

  @Get(path: '/profile')
  Future<Response<GetUserProfileModel>> getUserProfile();



  @Patch(path: '/profile')
  @multipart
  Future<Response<GeneralErrorModel>> updateProfile(
      {
        @PartFile('imageFile')  String? profileImage,
    @Part('name')  required String name,
    @Part('id')required String id,
    @Part('oldImage')required String oldImage,
    @Part('phone')required String phone,
  });

  // /notifications?page=1
  @Get(path: '/notifications')
  Future<Response<GetNotificationModel>> getNotification({
    @QueryMap() required Map<String, dynamic> queryParameters
});
  @Get(path: '/auth/firebase')
  Future<Response<FirebaseAuthModel>> firebaseAuth();

  @Get(path: '/subscription-session')
  Future<Response<SubscriptionTokenModel>> subscriptionTokenAPi();
  // http://35.154.69.160/subscription-plan?token=subscription-token



  @Get(path: '/subscription-status')
  Future<Response<SubscriptionStatusModel>> subscriptionStatusAPi();
}
