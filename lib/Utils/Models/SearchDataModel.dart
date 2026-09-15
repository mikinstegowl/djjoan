import 'package:new_music_app/Utils/Models/VideoCategoryItemModel.dart' as i;
class SearchDataModel {
  bool? success;
  Data? data;
  String? message;

  SearchDataModel({this.success, this.data, this.message});

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<Musics>? musics;
  List<Albums>? albums;
  List<i.Videos>? videos;

  Data({this.musics, this.albums, this.videos});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['musics'] != null) {
      musics = <Musics>[];
      json['musics'].forEach((v) {
        musics!.add(Musics.fromJson(v));
      });
    }
    if (json['albums'] != null) {
      albums = <Albums>[];
      json['albums'].forEach((v) {
        albums!.add(Albums.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <i.Videos>[];
      json['videos'].forEach((v) {
        videos!.add(i.Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (musics != null) {
      data['musics'] = musics!.map((v) => v.toJson()).toList();
    }
    if (albums != null) {
      data['albums'] = albums!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Musics {
  int? id;
  int? menuId;
  String? songName;
  String? songArtist;
  bool? imageStatus;
  String? songImage;
  String? songUrl;
  String? songFile;
  String? songDuration;
  bool? isFavourite;

  Musics(
      {this.id,
        this.menuId,
        this.songName,
        this.songArtist,
        this.imageStatus,
        this.songImage,
        this.songUrl,
        this.songFile,
        this.songDuration,
        this.isFavourite});

  Musics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    imageStatus = json['image_status'];
    songImage = json['song_image'];
    songUrl = json['song_url'];
    songFile = json['song_file'];
    songDuration = json['song_duration'];
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['menu_id'] = menuId;
    data['song_name'] = songName;
    data['song_artist'] = songArtist;
    data['image_status'] = imageStatus;
    data['song_image'] = songImage;
    data['song_url'] = songUrl;
    data['song_file'] = songFile;
    data['song_duration'] = songDuration;
    data['is_favourite'] = isFavourite;
    return data;
  }
}

class Albums {
  int? categoryId;
  String? categoryName;
  String? categoryImage;
  String? categoryFor;
  int? menuId;
  bool? imageStatus;

  Albums(
      {this.categoryId,
        this.categoryName,
        this.categoryImage,
        this.categoryFor,
        this.menuId,
        this.imageStatus});

  Albums.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryFor = json['category_for'];
    menuId = json['menu_id'];
    imageStatus = json['image_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['category_for'] = categoryFor;
    data['menu_id'] = menuId;
    data['image_status'] = imageStatus;
    return data;
  }
}

class Videos {
  int? id;
  String? videosName;
  String? videosDescription;
  String? videosImage;
  bool? imageStatus;

  Videos(
      {this.id,
        this.videosName,
        this.videosDescription,
        this.videosImage,
        this.imageStatus});

  Videos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videosName = json['videos_name'];
    videosDescription = json['videos_description'];
    videosImage = json['videos_image'];
    imageStatus = json['image_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['videos_name'] = videosName;
    data['videos_description'] = videosDescription;
    data['videos_image'] = videosImage;
    data['image_status'] = imageStatus;
    return data;
  }
}
