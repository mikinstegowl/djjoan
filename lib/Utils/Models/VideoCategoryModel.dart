class VideoCategoryModel {
  bool? success;
  List<Data>? data;
  String? message;
  int? totalCount;
  int? nextPage;
  int? lastPage;

  VideoCategoryModel(
      {this.success,
        this.data,
        this.message,
        this.totalCount,
        this.nextPage,
        this.lastPage});

  VideoCategoryModel.fromJson(Map<String, dynamic> json) {
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
  int? categoryId;
  int? menuId;
  String? categoryImage;
  String? categoryName;
  bool? imageStatus;

  Data(
      {this.categoryId,
        this.menuId,
        this.categoryImage,
        this.categoryName,
        this.imageStatus});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    menuId = json['menu_id'];
    categoryImage = json['category_image'];
    categoryName = json['category_name'];
    imageStatus = json['image_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['menu_id'] = menuId;
    data['category_image'] = categoryImage;
    data['category_name'] = categoryName;
    data['image_status'] = imageStatus;
    return data;
  }
}
