import 'package:new_music_app/Utils/Models/HomeModel.dart';

class GetFavouriteSongModel {
  bool? success;
  List<Items>? data;
  String? message;
  int? totalCount;
  Null nextPage;
  int? lastPage;

  GetFavouriteSongModel(
      {this.success,
      this.data,
      this.message,
      this.totalCount,
      this.nextPage,
      this.lastPage});

  GetFavouriteSongModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Items>[];
      json['data'].forEach((v) {
        data!.add(Items.fromJson(v));
      });
    }
    message = json['message'];
    totalCount = json['totalCount'];
    nextPage = json['nextPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['totalCount'] = totalCount;
    data['nextPage'] = nextPage;
    data['lastPage'] = lastPage;
    return data;
  }
}

class Data {
  int? favouriteId;
  int? id;
  bool? imageStatus;
  int? menuId;
  String? songName;
  String? songArtist;
  String? songImage;
  String? songUrl;
  String? songFile;
  String? songDuration;
  bool? isFavourite;

  Data(
      {this.favouriteId,
      this.id,
      this.imageStatus,
      this.menuId,
      this.songName,
      this.songArtist,
      this.songImage,
      this.songUrl,
      this.songFile,
      this.songDuration,
      this.isFavourite});

  Data.fromJson(Map<String, dynamic> json) {
    favouriteId = json['favourite_id'];
    id = json['id'];
    imageStatus = json['image_status'];
    menuId = json['menu_id'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    songImage = json['song_image'];
    songUrl = json['song_url'];
    songFile = json['song_file'];
    songDuration = json['song_duration'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favourite_id'] = favouriteId;
    data['id'] = id;
    data['image_status'] = imageStatus;
    data['menu_id'] = menuId;
    data['song_name'] = songName;
    data['song_artist'] = songArtist;
    data['song_image'] = songImage;
    data['song_url'] = songUrl;
    data['song_file'] = songFile;
    data['song_duration'] = songDuration;
    data['is_favourite'] = isFavourite;
    return data;
  }
}
