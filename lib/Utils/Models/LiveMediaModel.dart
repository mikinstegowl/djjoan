class LiveMediaModel {
  bool? success;
  Data? data;
  String? message;

  LiveMediaModel({this.success, this.data, this.message});

  LiveMediaModel.fromJson(Map<String, dynamic> json) {
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
  bool? imageStatus;
  String? title;
  String? description;
  String? image;
  String? url;
  int? likesCount;
  bool? isLiked;

  Data(
      {this.id,
        this.imageStatus,
        this.title,
        this.description,
        this.image,
        this.url,
        this.likesCount,
        this.isLiked});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageStatus = json['image_status'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    url = json['url'];
    likesCount = json['likesCount'];
    isLiked = json['isLiked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_status'] = imageStatus;
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    data['url'] = url;
    data['likesCount'] = likesCount;
    data['isLiked'] = isLiked;
    return data;
  }
}
