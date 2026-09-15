// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HomeChopperService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$HomeChopperService extends HomeChopperService {
  _$HomeChopperService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = HomeChopperService;

  @override
  Future<Response<VideoCategoryDataModel>> videoCategoryApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('menuitems');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client
        .send<VideoCategoryDataModel, VideoCategoryDataModel>($request);
  }

  @override
  Future<Response<VideoCategoryDataListModel>> videoCategoryItemsApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('categoryitems');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client
        .send<VideoCategoryDataListModel, VideoCategoryDataListModel>($request);
  }

  @override
  Future<Response<ViewAllCategoryDataModel>> viewAllCategoriesApi({
    required Map<String, dynamic> param,
    required int id,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('audiosubcategories/${id}');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client
        .send<ViewAllCategoryDataModel, ViewAllCategoryDataModel>($request);
  }

  @override
  Future<Response<RadioModel>> radioAudioApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('menuitems');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<RadioModel, RadioModel>($request);
  }

  @override
  Future<Response<LiveVideoModel>> liveVideoApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('menuitems');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<LiveVideoModel, LiveVideoModel>($request);
  }

  @override
  Future<Response<PlayListDataModel>> getPlayList({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlist');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<PlayListDataModel, PlayListDataModel>($request);
  }

  @override
  Future<Response<FavouritesDataModel>> addRemoveFavouritesApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('favourites');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<FavouritesDataModel, FavouritesDataModel>($request);
  }

  @override
  Future<Response<FavouritesDataModel>> addRemoveFavouritesVideoApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('favouritevideos');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<FavouritesDataModel, FavouritesDataModel>($request);
  }

  @override
  Future<Response<FavoriteSongListModel>> favoritesSongsApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('favourites');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<FavoriteSongListModel, FavoriteSongListModel>($request);
  }

  @override
  Future<Response<SignInModel>> getProfileApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('profile');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SignInModel, SignInModel>($request);
  }

  @override
  Future<Response<PlayListDataModel>> getPlayListApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlist');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<PlayListDataModel, PlayListDataModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> removePlayList({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlist');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<PlayListSongModel>> playListSongApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlistsongs');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<PlayListSongModel, PlayListSongModel>($request);
  }

  @override
  Future<Response<FavouriteVideoModel>> favouriteVideoApi({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('favouritevideos');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<FavouriteVideoModel, FavouriteVideoModel>($request);
  }

  @override
  Future<Response<AddSongPlaylistDataModel>> addSongToPlaylist({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlistsongs');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client
        .send<AddSongPlaylistDataModel, AddSongPlaylistDataModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> removeSongFromPlaylist({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('playlistsongs');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<SearchSongDataModel>> searchSongs({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('search');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SearchSongDataModel, SearchSongDataModel>($request);
  }

  @override
  Future<Response<SearchAlbumDataModel>> searchAlbum({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('search');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SearchAlbumDataModel, SearchAlbumDataModel>($request);
  }

  @override
  Future<Response<SearchVideosDataModel>> searchVideos({
    required Map<String, dynamic> param,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('search');
    final Map<String, dynamic> $params = queryParameters;
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      parameters: $params,
    );
    return client.send<SearchVideosDataModel, SearchVideosDataModel>($request);
  }

  @override
  Future<Response<MerchandiseDataModel>> getMerchandiseApi() {
    final Uri $url = Uri.parse('merchandise');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<MerchandiseDataModel, MerchandiseDataModel>($request);
  }

  @override
  Future<Response<SponsorBannerDataModel>> sponsorBannerApi() {
    final Uri $url = Uri.parse('sponsor');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<SponsorBannerDataModel, SponsorBannerDataModel>($request);
  }

  @override
  Future<Response<SocialMediaModel>> socialMediaApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('socialmedia');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SocialMediaModel, SocialMediaModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> bookingApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('booking');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<NotificationDataModel>> notificationApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('notifications');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<NotificationDataModel, NotificationDataModel>($request);
  }

  @override
  Future<Response<HomeModel>> homeDataApi(
      {required Map<String, dynamic> queryParameters}) {
    final Uri $url = Uri.parse('/home-menu');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<HomeModel, HomeModel>($request);
  }

  @override
  Future<Response<CategorySongModel>> categoriesSongApi({
    required int id,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('/tracks-category-items/${id}');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<CategorySongModel, CategorySongModel>($request);
  }

  @override
  Future<Response<ViewAllCategoryModel>> categoriesViewAllApi({
    required int id,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('/menu-categories/${id}');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<ViewAllCategoryModel, ViewAllCategoryModel>($request);
  }

  @override
  Future<Response<BannerModel>> bannerSlider({required String sliderType}) {
    final Uri $url = Uri.parse('/slider/${sliderType}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<BannerModel, BannerModel>($request);
  }

  @override
  Future<Response<VideoCategoryModel>> videoCategoryAPi(
      {required Map<String, dynamic> queryParameters}) {
    final Uri $url = Uri.parse('/video-category');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<VideoCategoryModel, VideoCategoryModel>($request);
  }

  @override
  Future<Response<VideoCategoryItemModel>> videoCategoryItemApi({
    required int categoryId,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('/videos-category-items/${categoryId}');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<VideoCategoryItemModel, VideoCategoryItemModel>($request);
  }

  @override
  Future<Response<VideoDetailModel>> videoDetails({required int videoId}) {
    final Uri $url = Uri.parse('/video-details/${videoId}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<VideoDetailModel, VideoDetailModel>($request);
  }

  @override
  Future<Response<LiveMediaModel>> liveMediaAPi(
      {required String liveMediaType}) {
    final Uri $url = Uri.parse('/live-media/${liveMediaType}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<LiveMediaModel, LiveMediaModel>($request);
  }

  @override
  Future<Response<CreatePlayListModel>> createPlayListApi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('/playlist');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<CreatePlayListModel, CreatePlayListModel>($request);
  }

  @override
  Future<Response<GetPlayListModel>> getPlaylistAPi(
      {required Map<String, dynamic> queryParameters}) {
    final Uri $url = Uri.parse('/playlist');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<GetPlayListModel, GetPlayListModel>($request);
  }

  @override
  Future<Response<AddSongPlayListModel>> addSongToPlayListAPi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('/playlist-songs');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AddSongPlayListModel, AddSongPlayListModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> deletePlaylistApi(
      {required int playlistId}) {
    final Uri $url = Uri.parse('/playlist/${playlistId}');
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<GetPlayListSongModel>> getPlayListSong({
    required int playlistId,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('/playlist-songs/${playlistId}');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<GetPlayListSongModel, GetPlayListSongModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> deletePlaylistSongApi({
    required int songId,
    required Map<String, dynamic> queryParameters,
  }) {
    final Uri $url = Uri.parse('/delete-playlist-song/${songId}');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<AddAndRemoveFavouriteSongModel>> addRemoveSongFromFavourite(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('/favourite/toggle');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<AddAndRemoveFavouriteSongModel,
        AddAndRemoveFavouriteSongModel>($request);
  }

  @override
  Future<Response<SongUpdateModel>> updateSongStats(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('/song-stats');
    final $body = param;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<SongUpdateModel, SongUpdateModel>($request);
  }

  @override
  Future<Response<LiveVideoLikeModel>> liveVideoLikeAPi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('/live-video-like/toggle');
    final $body = param;
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LiveVideoLikeModel, LiveVideoLikeModel>($request);
  }

  @override
  Future<Response<GetFavouriteSongModel>> getFavouriteSong(
      {required Map<String, dynamic> queryParameters}) {
    final Uri $url = Uri.parse('/favourite/songs');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<GetFavouriteSongModel, GetFavouriteSongModel>($request);
  }

  @override
  Future<Response<GetFavouriteVideoModel>> getFavouriteVideo(
      {required Map<String, dynamic> queryParameters}) {
    final Uri $url = Uri.parse('/favourite/videos');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client
        .send<GetFavouriteVideoModel, GetFavouriteVideoModel>($request);
  }

  @override
  Future<Response<GetSocialMediaModel>> getSocialMedia() {
    final Uri $url = Uri.parse('/social-links');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetSocialMediaModel, GetSocialMediaModel>($request);
  }

  @override
  Future<Response<SearchDataModel>> searchAPi({required String searchText}) {
    final Uri $url = Uri.parse('/search/${searchText}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<SearchDataModel, SearchDataModel>($request);
  }

  @override
  Future<Response<GetUserProfileModel>> getUserProfile() {
    final Uri $url = Uri.parse('/profile');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<GetUserProfileModel, GetUserProfileModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> updateProfile({
    String? profileImage,
    required String name,
    required String id,
    required String oldImage,
    required String phone,
  }) {
    final Uri $url = Uri.parse('/profile');
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'name',
        name,
      ),
      PartValue<String>(
        'id',
        id,
      ),
      PartValue<String>(
        'oldImage',
        oldImage,
      ),
      PartValue<String>(
        'phone',
        phone,
      ),
      PartValueFile<String?>(
        'imageFile',
        profileImage,
      ),
    ];
    final Request $request = Request(
      'PATCH',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<GetNotificationModel>> getNotification(
      {required Map<String, dynamic> queryParameters}) {
    final Uri $url = Uri.parse('/notifications');
    final Map<String, dynamic> $params = queryParameters;
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<GetNotificationModel, GetNotificationModel>($request);
  }

  @override
  Future<Response<FirebaseAuthModel>> firebaseAuth() {
    final Uri $url = Uri.parse('/auth/firebase');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<FirebaseAuthModel, FirebaseAuthModel>($request);
  }

  @override
  Future<Response<SubscriptionTokenModel>> subscriptionTokenAPi() {
    final Uri $url = Uri.parse('/subscription-session');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<SubscriptionTokenModel, SubscriptionTokenModel>($request);
  }

  @override
  Future<Response<SubscriptionStatusModel>> subscriptionStatusAPi() {
    final Uri $url = Uri.parse('/subscription-status');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client
        .send<SubscriptionStatusModel, SubscriptionStatusModel>($request);
  }
}
