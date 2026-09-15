import 'package:chopper/chopper.dart';
import 'package:new_music_app/Utils/ChopperClientService/AuthChopperService.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Models/AddAndRemoveFavouriteSongModel.dart';
import 'package:new_music_app/Utils/Models/AddSongPlayListModel.dart';
import 'package:new_music_app/Utils/Models/AddSongPlaylistDataModel.dart';
import 'package:new_music_app/Utils/Models/BannerModel.dart';
import 'package:new_music_app/Utils/Models/CategoriesSongDataModel.dart';
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
import 'package:new_music_app/Utils/Models/HomeBannerModel.dart';
import 'package:new_music_app/Utils/Models/HomeDataModel.dart';
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
import 'package:new_music_app/Utils/Models/LoginAndSkipModel.dart';
import 'package:new_music_app/Utils/Models/SkipUserDataModel.dart';
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
import 'package:new_music_app/Utils/Models/WalkthroughDataModel.dart';
import 'Utils/Convertors/JsonToTypeConverter.dart';
import 'Utils/Interceptors/ApplyHeaderInterceptor.dart';
import 'Utils/Interceptors/RequestLogger.dart';
import 'Utils/Interceptors/ResponseLogger.dart';

class AppChopperClient {
  static final AppChopperClient _singleton = AppChopperClient._internal();

  factory AppChopperClient() {
    return _singleton;
  }

  AppChopperClient._internal() {
    createChopperClient();
  }

  ChopperClient? _client;

  T getChopperService<T extends ChopperService>() {
    return _client!.getService<T>();
  }

  void createChopperClient() {
    if (_client != null) {
      return;
    }
    _client = ChopperClient(
        baseUrl: Uri.parse(
            // "https://alajazamusic.com/alajazamusicadmin/api/",
            // "https://djkukysweetsapp.com/kukysweets/api",
            //   'https://pegasusmusicapp.com/pegasusmusicadmin/api/'
            // 'http://35.154.69.160/api'
            // 'https://djjaylyricsapp.com/jaylyricsadmin/api'
            // 'https://djjaylyricsapp.com/api'
            // "https://djsiskoapp.com/api"
          "https://www.djjoanmusic.com/api"

            //     ''
            ),
        services: [
          AuthChopperService.create(),
          HomeChopperService.create(),
        ],
        interceptors: [
          RequestLogger(),
          ResponseLogger(),
          ApplyHeaderInterceptor(),
        ],
        converter: const JsonToTypeConverter(
          jsonConvertorMap: {
            GeneralErrorModel: GeneralErrorModel.fromJson,
            SignInModel: SignInModel.fromJson,
            HomeBannerModel: HomeBannerModel.fromJson,
            HomeDataModel: HomeDataModel.fromJson,
            CategoriesSongDataModel: CategoriesSongDataModel.fromJson,
            VideoCategoryDataModel: VideoCategoryDataModel.fromJson,
            VideoCategoryDataListModel: VideoCategoryDataListModel.fromJson,
            RadioModel: RadioModel.fromJson,
            FavouritesDataModel: FavouritesDataModel.fromJson,
            PlayListDataModel: PlayListDataModel.fromJson,
            MerchandiseDataModel: MerchandiseDataModel.fromJson,
            FavoriteSongListModel: FavoriteSongListModel.fromJson,
            LiveVideoModel: LiveVideoModel.fromJson,
            PlayListSongModel: PlayListSongModel.fromJson,
            ViewAllCategoryDataModel: ViewAllCategoryDataModel.fromJson,
            FavouriteVideoModel: FavouriteVideoModel.fromJson,
            SocialMediaModel: SocialMediaModel.fromJson,
            SkipUserDataModel: SkipUserDataModel.fromJson,
            CreatePlayListModel: CreatePlayListModel.fromJson,
            AddSongPlaylistDataModel: AddSongPlaylistDataModel.fromJson,
            SponsorBannerDataModel: SponsorBannerDataModel.fromJson,
            SearchAlbumDataModel: SearchAlbumDataModel.fromJson,
            SearchVideosDataModel: SearchVideosDataModel.fromJson,
            SearchSongDataModel: SearchSongDataModel.fromJson,
            NotificationDataModel: NotificationDataModel.fromJson,
            WalkthroughDataModel: WalkthroughDataModel.fromJson,
            LoginAndSkipModel: LoginAndSkipModel.fromJson,
            HomeModel: HomeModel.fromJson,
            CategorySongModel: CategorySongModel.fromJson,
            BannerModel: BannerModel.fromJson,
            ViewAllCategoryModel: ViewAllCategoryModel.fromJson,
            VideoCategoryModel: VideoCategoryModel.fromJson,
            VideoCategoryItemModel: VideoCategoryItemModel.fromJson,
            VideoDetailModel: VideoDetailModel.fromJson,
            LiveMediaModel: LiveMediaModel.fromJson,
            GetPlayListModel: GetPlayListModel.fromJson,
            AddSongPlayListModel: AddSongPlayListModel.fromJson,
            GetPlayListSongModel: GetPlayListSongModel.fromJson,
            AddAndRemoveFavouriteSongModel:
                AddAndRemoveFavouriteSongModel.fromJson,
            SongUpdateModel: SongUpdateModel.fromJson,
            LiveVideoLikeModel: LiveVideoLikeModel.fromJson,
            GetFavouriteSongModel: GetFavouriteSongModel.fromJson,
            GetFavouriteVideoModel: GetFavouriteVideoModel.fromJson,
            GetSocialMediaModel: GetSocialMediaModel.fromJson,
            SearchDataModel: SearchDataModel.fromJson,
            GetUserProfileModel: GetUserProfileModel.fromJson,
            GetNotificationModel: GetNotificationModel.fromJson,
            FirebaseAuthModel: FirebaseAuthModel.fromJson,
            SubscriptionStatusModel: SubscriptionStatusModel.fromJson,
            SubscriptionTokenModel: SubscriptionTokenModel.fromJson,
          },
        ),
        errorConverter: const JsonToTypeConverter(
            jsonConvertorMap: {GeneralErrorModel: GeneralErrorModel.fromJson}));
  }
}
// flutter pub run build_runner build --delete-conflicting-outputs
