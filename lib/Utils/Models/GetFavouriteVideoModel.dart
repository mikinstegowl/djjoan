class GetFavouriteVideoModel {
  bool? success;
  List<Data>? data;
  String? message;
  int? totalCount;
  int? nextPage;
  int? lastPage;

  GetFavouriteVideoModel(
      {this.success,
        this.data,
        this.message,
        this.totalCount,
        this.nextPage,
        this.lastPage});

  GetFavouriteVideoModel.fromJson(Map<String, dynamic> json) {
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
  int? favouriteId;
  int? id;
  String? videosImage;
  String? videosName;
  String? videosDescription;
  bool? imageStatus;

  Data(
      {this.favouriteId,
        this.id,
        this.videosImage,
        this.videosName,
        this.videosDescription,
        this.imageStatus});

  Data.fromJson(Map<String, dynamic> json) {
    favouriteId = json['favourite_id'];
    id = json['id'];
    videosImage = json['videos_image'];
    videosName = json['videos_name'];
    videosDescription = json['videos_description'];
    imageStatus = json['image_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['favourite_id'] = favouriteId;
    data['id'] = id;
    data['videos_image'] = videosImage;
    data['videos_name'] = videosName;
    data['videos_description'] = videosDescription;
    data['image_status'] = imageStatus;
    return data;
  }
}
