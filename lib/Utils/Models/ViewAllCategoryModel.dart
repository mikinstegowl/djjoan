class ViewAllCategoryModel {
  bool? success;
  Data? data;
  String? message;
  int? totalCount;
  int? nextPage;
  int? lastPage;

  ViewAllCategoryModel(
      {this.success,
        this.data,
        this.message,
        this.totalCount,
        this.nextPage,
        this.lastPage});

  ViewAllCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    totalCount = json['totalCount'];
    nextPage = json['nextPage'];
    lastPage = json['lastPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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
  String? menuName;
  String? menuType;
  bool? visibleStatus;
  List<Categories>? categories;

  Data(
      {this.menuId,
        this.menuName,
        this.menuType,
        this.visibleStatus,
        this.categories});

  Data.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    menuName = json['menu_name'];
    menuType = json['menu_type'];
    visibleStatus = json['visible_status'];
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['menu_name'] = menuName;
    data['menu_type'] = menuType;
    data['visible_status'] = visibleStatus;
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  int? categoryId;
  int? menuId;
  String? categoryName;
  String? categoryImage;
  bool? imageStatus;

  Categories(
      {this.categoryId,
        this.menuId,
        this.categoryName,
        this.categoryImage,
        this.imageStatus});

  Categories.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    menuId = json['menu_id'];
    categoryName = json['category_name'];
    categoryImage = json['category_image'];
    imageStatus = json['image_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_id'] = categoryId;
    data['menu_id'] = menuId;
    data['category_name'] = categoryName;
    data['category_image'] = categoryImage;
    data['image_status'] = imageStatus;
    return data;
  }
}
