import 'package:new_music_app/Utils/Models/HomeModel.dart';

class GetPlayListSongModel {
  bool? success;
  Data? data;
  String? message;
  int? totalCount;
  int? nextPage;
  int? lastPage;

  GetPlayListSongModel(
      {this.success,
      this.data,
      this.message,
      this.totalCount,
      this.nextPage,
      this.lastPage});

  GetPlayListSongModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    totalCount = json['totalCount'];
    nextPage = json['nextPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['totalCount'] = totalCount;
    data['nextPage'] = nextPage;
    data['lastPage'] = lastPage;
    return data;
  }
}

class Data {
  int? id;
  String? playlistName;
  List<Items>? songs;

  Data({this.id, this.playlistName, this.songs});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playlistName = json['playlist_name'];
    if (json['songs'] != null) {
      songs = <Items>[];
      json['songs'].forEach((v) {
        songs!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['playlist_name'] = playlistName;
    if (songs != null) {
      data['songs'] = songs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Songs {
  int? id;
  int? menuId;
  bool? imageStatus;
  String? songName;
  String? songArtist;
  String? songDuration;
  String? songUrl;
  String? songFile;
  String? songImage;
  bool? isFavourite;

  Songs(
      {this.id,
      this.menuId,
      this.imageStatus,
      this.songName,
      this.songArtist,
      this.songDuration,
      this.songUrl,
      this.songFile,
      this.songImage,
      this.isFavourite});

  Songs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    imageStatus = json['image_status'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    songDuration = json['song_duration'];
    songUrl = json['song_url'];
    songFile = json['song_file'];
    songImage = json['song_image'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['menu_id'] = menuId;
    data['image_status'] = imageStatus;
    data['song_name'] = songName;
    data['song_artist'] = songArtist;
    data['song_duration'] = songDuration;
    data['song_url'] = songUrl;
    data['song_file'] = songFile;
    data['song_image'] = songImage;
    data['is_favourite'] = isFavourite;
    return data;
  }
}
