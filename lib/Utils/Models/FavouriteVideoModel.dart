import 'package:new_music_app/Utils/Models/VideoCategoryDataListModel.dart'
    as datas;

class FavouriteVideoModel {
  int? status;
  String? message;
  List<datas.Data>? data;
  String? perPage;
  int? currentPage;
  int? lastPage;

  FavouriteVideoModel(
      {this.status,
      this.message,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  FavouriteVideoModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <datas.Data>[];
      json['data'].forEach((v) {
        data!.add(datas.Data.fromJson(v));
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

class Datas {
  String? categoryitemsId;
  String? menuId;
  String? categoryId;
  int? videosId;
  String? videosImage;
  String? videosName;
  String? videosDescription;
  String? videosLink;
  String? livetvStatus;
  bool? videoLikeStatus;
  int? videoLikeCount;
  bool? popupVideoStatus;
  bool? favouritesStatus;
  int? favouritesCount;
  String? date;
  String? time;
  int? urlType;

  Datas(
      {this.categoryitemsId,
      this.menuId,
      this.categoryId,
      this.videosId,
      this.videosImage,
      this.videosName,
      this.videosDescription,
      this.videosLink,
      this.livetvStatus,
      this.videoLikeStatus,
      this.videoLikeCount,
      this.popupVideoStatus,
      this.favouritesStatus,
      this.favouritesCount,
      this.date,
      this.time,
      this.urlType});

  Datas.fromJson(Map<String, dynamic> json) {
    categoryitemsId = json['categoryitems_id'];
    menuId = json['menu_id'];
    categoryId = json['category_id'];
    videosId = json['videos_id'];
    videosImage = json['videos_image'];
    videosName = json['videos_name'];
    videosDescription = json['videos_description'];
    videosLink = json['videos_link'];
    livetvStatus = json['livetv_status'];
    videoLikeStatus = json['video_like_status'];
    videoLikeCount = json['video_like_count'];
    popupVideoStatus = json['popup_video_status'];
    favouritesStatus = json['favourites_status'];
    favouritesCount = json['favourites_count'];
    date = json['date'];
    time = json['time'];
    urlType = json['url_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryitems_id'] = categoryitemsId;
    data['menu_id'] = menuId;
    data['category_id'] = categoryId;
    data['videos_id'] = videosId;
    data['videos_image'] = videosImage;
    data['videos_name'] = videosName;
    data['videos_description'] = videosDescription;
    data['videos_link'] = videosLink;
    data['livetv_status'] = livetvStatus;
    data['video_like_status'] = videoLikeStatus;
    data['video_like_count'] = videoLikeCount;
    data['popup_video_status'] = popupVideoStatus;
    data['favourites_status'] = favouritesStatus;
    data['favourites_count'] = favouritesCount;
    data['date'] = date;
    data['time'] = time;
    data['url_type'] = urlType;
    return data;
  }
}
