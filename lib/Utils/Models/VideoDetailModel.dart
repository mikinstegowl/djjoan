class VideoDetailModel {
  bool? success;
  Data? data;
  String? message;

  VideoDetailModel({this.success, this.data, this.message});

  VideoDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? videosName;
  String? videosDescription;
  String? videosFile;
  String? videosLink;
  bool? livetvStatus;
  String? videosImage;
  bool? popupVideoStatus;
  bool? imageStatus;
  List<Favourites>? favourites;
  bool? isFavourite;

  Data(
      {this.id,
        this.videosName,
        this.videosDescription,
        this.videosFile,
        this.videosLink,
        this.livetvStatus,
        this.videosImage,
        this.popupVideoStatus,
        this.imageStatus,
        this.favourites,
        this.isFavourite});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videosName = json['videos_name'];
    videosDescription = json['videos_description'];
    videosFile = json['videos_file'];
    videosLink = json['videos_link'];
    livetvStatus = json['livetv_status'];
    videosImage = json['videos_image'];
    popupVideoStatus = json['popup_video_status'];
    imageStatus = json['image_status'];
    if (json['favourites'] != null) {
      favourites = <Favourites>[];
      json['favourites'].forEach((v) {
        favourites!.add(Favourites.fromJson(v));
      });
    }
    isFavourite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['videos_name'] = videosName;
    data['videos_description'] = videosDescription;
    data['videos_file'] = videosFile;
    data['videos_link'] = videosLink;
    data['livetv_status'] = livetvStatus;
    data['videos_image'] = videosImage;
    data['popup_video_status'] = popupVideoStatus;
    data['image_status'] = imageStatus;
    if (favourites != null) {
      data['favourites'] = favourites!.map((v) => v.toJson()).toList();
    }
    data['is_favourite'] = isFavourite;
    return data;
  }
}

class Favourites {
  int? id;
  int? videoId;

  Favourites({this.id, this.videoId});

  Favourites.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    videoId = json['video_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['video_id'] = videoId;
    return data;
  }
}
