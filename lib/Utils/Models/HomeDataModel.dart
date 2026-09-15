class HomeDataModel {
  int? status;
  String? message;
  List<VideoData>? videoData;
  List<Data>? data;
  String? perPage;
  int? currentPage;
  int? lastPage;

  HomeDataModel(
      {this.status,
      this.message,
      this.videoData,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['video_data'] != null) {
      videoData = <VideoData>[];
      json['video_data'].forEach((v) {
        videoData!.add(VideoData.fromJson(v));
      });
    }
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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
    if (videoData != null) {
      data['video_data'] = videoData!.map((v) => v.toJson()).toList();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    return data;
  }
}

class VideoData {
  int? categoryId;
  String? categoryName;
  List<Assests>? assests;

  VideoData({this.categoryId, this.categoryName, this.assests});

  VideoData.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    if (json['assests'] != null) {
      assests = <Assests>[];
      json['assests'].forEach((v) {
        assests!.add(Assests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    if (assests != null) {
      data['assests'] = assests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Assests {
  int? categoryId;
  int? videoId;
  int? menuId;
  String? videosImage;
  String? videosName;
  String? videosDescription;
  bool? imageStatus;
  String? createdAt;
  int? urlType;

  Assests(
      {this.categoryId,
      this.videoId,
      this.menuId,
      this.videosImage,
      this.videosName,
      this.videosDescription,
      this.imageStatus,
      this.createdAt,
      this.urlType});

  Assests.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    videoId = json['video_id'];
    menuId = json['menu_id'];
    videosImage = json['videos_image'];
    videosName = json['videos_name'];
    videosDescription = json['videos_description'];
    imageStatus = json['image_status'];
    createdAt = json['created_at'];
    urlType = json['url_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['video_id'] = videoId;
    data['menu_id'] = menuId;
    data['videos_image'] = videosImage;
    data['videos_name'] = videosName;
    data['videos_description'] = videosDescription;
    data['image_status'] = imageStatus;
    data['created_at'] = createdAt;
    data['url_type'] = urlType;
    return data;
  }
}

class Data {
  int? categoryId;
  String? type;
  String? name;
  List<AssestsSong>? assests;

  Data({this.categoryId, this.type, this.name, this.assests});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    type = json['type'];
    name = json['name'];
    if (json['assests'] != null) {
      assests = <AssestsSong>[];
      json['assests'].forEach((v) {
        assests!.add(AssestsSong.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['type'] = type;
    data['name'] = name;
    if (assests != null) {
      data['assests'] = assests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssestsSong {
  var categoryId;
  int? menuId;
  int? songId;
  String? songName;
  String? songArtist;
  String? songImage;
  String? song;
  String? songDuration;
  String? categoryImage;
  String? categoryName;
  String? categoryFor;
  bool? imageStatus;
  int? likesCount;
  bool? likesStatus;
  int? favouritesCount;
  bool? favouritesStatus;
  int? totalPlayed;
  int? totalShared;
  String? createdAt;

  AssestsSong(
      {this.categoryId,
      this.categoryImage,
      this.categoryName,
      this.categoryFor,
      this.imageStatus,
      this.menuId,
      this.songId,
      this.songName,
      this.songArtist,
      this.songImage,
      this.song,
      this.songDuration,
      this.likesCount,
      this.likesStatus,
      this.favouritesCount,
      this.favouritesStatus,
      this.totalPlayed,
      this.totalShared,
      this.createdAt});

  AssestsSong.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    categoryFor = json['category_for'];
    imageStatus = json['image_status'];
    menuId = json['menu_id'];
    songId = json['song_id'];
    songName = json['song_name'];
    songArtist = json['song_artist'];
    songImage = json['song_image'];
    song = json['song'];
    songDuration = json['song_duration'];
    likesCount = json['likes_count'];
    likesStatus = json['likes_status'];
    favouritesCount = json['favourites_count'];
    favouritesStatus = json['favourites_status'];
    totalPlayed = json['total_played'];
    totalShared = json['total_shared'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['menu_id'] = menuId;
    data['song_id'] = songId;
    data['song_name'] = songName;
    data['song_artist'] = songArtist;
    data['song_image'] = songImage;
    data['song'] = song;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['category_for'] = categoryFor;
    data['image_status'] = imageStatus;
    data['song_duration'] = songDuration;
    data['likes_count'] = likesCount;
    data['likes_status'] = likesStatus;
    data['favourites_count'] = favouritesCount;
    data['favourites_status'] = favouritesStatus;
    data['total_played'] = totalPlayed;
    data['total_shared'] = totalShared;
    data['created_at'] = createdAt;
    return data;
  }
}

