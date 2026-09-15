class HomeModel {
  bool? success;
  List<Data>? data;
  String? message;
  int? totalCount;
  int? nextPage;
  int? lastPage;

  HomeModel(
      {this.success,
      this.data,
      this.message,
      this.totalCount,
      this.nextPage,
      this.lastPage});

  HomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
  int? menuId;
  String? type;
  String? name;
  bool? visibleStatus;
  List<Items>? items;

  Data({this.menuId, this.type, this.name, this.visibleStatus, this.items});

  Data.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    type = json['type'];
    name = json['name'];
    visibleStatus = json['visible_status'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['type'] = type;
    data['name'] = name;
    data['visible_status'] = visibleStatus;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? categoryId;
  int? menuId;
  String? categoryImage;
  String? categoryName;
  String? categoryFor;
  bool? imageStatus;
  int? id;
  String? songName;
  String? songArtist;
  String? songImage;
  String? songUrl;
  String? songFile;
  String? songDuration;
  bool? isFavourite;
  int? playListCount;
  int? favoritesCount;
  int? likesCount;
  int? totalPlayed;
  int? totalShared;

  Items(
      {this.categoryId,
      this.menuId,
      this.categoryImage,
      this.categoryName,
      this.categoryFor,
      this.imageStatus,
      this.id,
      this.playListCount,
      this.songName,
      this.songArtist,
      this.songImage,
      this.songUrl,
      this.songFile,
      this.songDuration,
      this.isFavourite,
      this.favoritesCount,
      this.likesCount,
      this.totalPlayed,
      this.totalShared});

  Items.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    menuId = json['menu_id'];
    categoryImage = json['category_image'];
    categoryName = json['category_name'];
    categoryFor = json['category_for'];
    imageStatus = json['image_status'];
    id = json['id'];
    playListCount = json['playlist_count'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    songImage = json['song_image'];
    songUrl = json['song_url'];
    songFile = json['song_file'];
    songDuration = json['song_duration'];
    isFavourite = json['is_favourite'] ?? json['isFavourite'];
    favoritesCount = json['favorites_count'];
    likesCount = json['likes_count'];
    totalPlayed = json['total_played'];
    totalShared = json['total_shared'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['menu_id'] = menuId;
    data['playlist_count'] = playListCount;
    data['category_image'] = categoryImage;
    data['category_name'] = categoryName;
    data['category_for'] = categoryFor;
    data['image_status'] = imageStatus;
    data['id'] = id;
    data['song_name'] = songName;
    data['song_artist'] = songArtist;
    data['song_image'] = songImage;
    data['song_url'] = songUrl;
    data['song_file'] = songFile;
    data['song_duration'] = songDuration;
    data['is_favourite'] = isFavourite;
    data['favorites_count'] = favoritesCount;
    data['likes_count'] = likesCount;
    data['total_played'] = totalPlayed;
    data['total_shared'] = totalShared;
    return data;
  }
}
