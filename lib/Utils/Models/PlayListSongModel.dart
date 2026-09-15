import 'package:new_music_app/Utils/Models/HomeDataModel.dart';

class PlayListSongModel {
  int? status;
  String? message;
  List<AssestsSong>? data;
  int? perPage;
  int? currentPage;
  int? lastPage;

  PlayListSongModel(
      {this.status,
      this.message,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  PlayListSongModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AssestsSong>[];
      json['data'].forEach((v) {
        data!.add(AssestsSong.fromJson(v));
      });
    }
    perPage = json['per_page'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    return data;
  }
}

class Data {
  String? favouritesId;
  int? playlistId;
  int? playlistsongsId;
  int? menuId;
  String? categoryId;
  String? categoryitemsId;
  int? songId;
  String? songImage;
  String? songName;
  String? songArtist;
  String? song;
  String? songDuration;
  bool? likesStatus;
  int? likesCount;
  bool? favouritesStatus;
  int? favouritesCount;
  int? totalPlayed;
  int? totalShared;
  bool? totalSharedStatus;
  bool? playlistStatus;
  int? playlistStatusCount;
  String? createdAt;

  Data(
      {this.favouritesId,
      this.playlistId,
      this.playlistsongsId,
      this.menuId,
      this.categoryId,
      this.categoryitemsId,
      this.songId,
      this.songImage,
      this.songName,
      this.songArtist,
      this.song,
      this.songDuration,
      this.likesStatus,
      this.likesCount,
      this.favouritesStatus,
      this.favouritesCount,
      this.totalPlayed,
      this.totalShared,
      this.totalSharedStatus,
      this.playlistStatus,
      this.playlistStatusCount,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    favouritesId = json['favourites_id'];
    playlistId = json['playlist_id'];
    playlistsongsId = json['playlistsongs_id'];
    menuId = json['menu_id'];
    categoryId = json['category_id'];
    categoryitemsId = json['categoryitems_id'];
    songId = json['song_id'];
    songImage = json['song_image'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    song = json['song'];
    songDuration = json['song_duration'];
    likesStatus = json['likes_status'];
    likesCount = json['likes_count'];
    favouritesStatus = json['favourites_status'];
    favouritesCount = json['favourites_count'];
    totalPlayed = json['total_played'];
    totalShared = json['total_shared'];
    totalSharedStatus = json['total_shared_status'];
    playlistStatus = json['playlist_status'];
    playlistStatusCount = json['playlist_status_count'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favourites_id'] = favouritesId;
    data['playlist_id'] = playlistId;
    data['playlistsongs_id'] = playlistsongsId;
    data['menu_id'] = menuId;
    data['category_id'] = categoryId;
    data['categoryitems_id'] = categoryitemsId;
    data['song_id'] = songId;
    data['song_image'] = songImage;
    data['song_name'] = songName;
    data['song_artist'] = songArtist;
    data['song'] = song;
    data['song_duration'] = songDuration;
    data['likes_status'] = likesStatus;
    data['likes_count'] = likesCount;
    data['favourites_status'] = favouritesStatus;
    data['favourites_count'] = favouritesCount;
    data['total_played'] = totalPlayed;
    data['total_shared'] = totalShared;
    data['total_shared_status'] = totalSharedStatus;
    data['playlist_status'] = playlistStatus;
    data['playlist_status_count'] = playlistStatusCount;
    data['created_at'] = createdAt;
    return data;
  }
}
