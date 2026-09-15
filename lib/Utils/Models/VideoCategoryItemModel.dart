class VideoCategoryItemModel {
  bool? success;
  String? message;
  Data? data;
  int? totalCount;
  int? nextPage;
  int? lastPage;

  VideoCategoryItemModel(
      {this.success,
        this.message,
        this.data,
        this.totalCount,
        this.nextPage,
        this.lastPage});

  VideoCategoryItemModel.fromJson(Map<String, dynamic> json) {
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
  bool? imageStatus;
  String? categoryName;
  String? categoryFor;
  List<Videos>? videos;

  Data(
      {this.categoryId,
        this.imageStatus,
        this.categoryName,
        this.categoryFor,
        this.videos});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    imageStatus = json['image_status'];
    categoryName = json['category_name'];
    categoryFor = json['category_for'];
    if (json['videos'] != null) {
      videos = <Videos>[];
      json['videos'].forEach((v) {
        videos!.add(Videos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['image_status'] = imageStatus;
    data['category_name'] = categoryName;
    data['category_for'] = categoryFor;
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
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
