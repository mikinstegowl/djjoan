class SearchAlbumDataModel {
  int? status;
  String? message;
  List<Data>? data;
  String? perPage;
  int? currentPage;
  int? lastPage;

  SearchAlbumDataModel(
      {this.status,
      this.message,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  SearchAlbumDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['last_page'] = lastPage;
    return data;
  }
}

class Data {
  int? categoryId;
  int? menuId;
  String? parentCategoryName;
  String? categoryImage;
  String? categoryName;
  String? categoryFor;
  bool? imageStatus;
  String? createdAt;

  Data(
      {this.categoryId,
      this.menuId,
      this.parentCategoryName,
      this.categoryImage,
      this.categoryName,
      this.categoryFor,
      this.imageStatus,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    menuId = json['menu_id'];
    parentCategoryName = json['parent_category_name'];
    categoryImage = json['category_image'];
    categoryName = json['category_name'];
    categoryFor = json['category_for'];
    imageStatus = json['image_status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['menu_id'] = menuId;
    data['parent_category_name'] = parentCategoryName;
    data['category_image'] = categoryImage;
    data['category_name'] = categoryName;
    data['category_for'] = categoryFor;
    data['image_status'] = imageStatus;
    data['created_at'] = createdAt;
    return data;
  }
}
