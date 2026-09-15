import 'package:new_music_app/Utils/Models/HomeModel.dart';

class CategorySongModel {
  bool? success;
  String? message;
  Data? data;
  int? totalCount;
  int? nextPage;
  int? lastPage;

  CategorySongModel(
      {this.success,
        this.message,
        this.data,
        this.totalCount,
        this.nextPage,
        this.lastPage});

  CategorySongModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    totalCount = json['totalCount'];
    nextPage = json['nextPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['totalCount'] = totalCount;
    data['nextPage'] = nextPage;
    data['lastPage'] = lastPage;
    return data;
  }
}

class Data {
  int? categoryId;
  String? categoryName;
  String? categoryFor;
  bool? imageStatus;
  List<Items>? songs;

  Data(
      {this.categoryId,
        this.categoryName,
        this.categoryFor,
        this.imageStatus,
        this.songs});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryFor = json['category_for'];
    imageStatus = json['image_status'];
    if (json['songs'] != null) {
      songs = <Items>[];
      json['songs'].forEach((v) {
        songs!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_for'] = categoryFor;
    data['image_status'] = imageStatus;
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
  int? favoritesCount;
  int? likesCount;
  int? totalPlayed;
  int? totalShared;
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
        this.favoritesCount,
        this.likesCount,
        this.totalPlayed,
        this.totalShared,
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
    favoritesCount = json['favorites_count'];
    likesCount = json['likes_count'];
    totalPlayed = json['total_played'];
    totalShared = json['total_shared'];
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
    data['favorites_count'] = favoritesCount;
    data['likes_count'] = likesCount;
    data['total_played'] = totalPlayed;
    data['total_shared'] = totalShared;
    data['is_favourite'] = isFavourite;
    return data;
  }
}
