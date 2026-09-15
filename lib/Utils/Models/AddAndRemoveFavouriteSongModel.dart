class AddAndRemoveFavouriteSongModel {
  bool? success;
  Data? data;
  bool? isFavourite;
  int? favouritesCount;
  String? message;
  String? queryKeyType;

  AddAndRemoveFavouriteSongModel(
      {this.success,
      this.data,
      this.isFavourite,
      this.favouritesCount,
      this.message,
      this.queryKeyType});

  AddAndRemoveFavouriteSongModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    isFavourite = json['isFavourite'] ?? json['is_favorite'];
    favouritesCount = json['favouritesCount'];
    message = json['message'];
    queryKeyType = json['queryKeyType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['isFavourite'] = isFavourite;
    data['favouritesCount'] = favouritesCount;
    data['message'] = message;
    data['queryKeyType'] = queryKeyType;
    return data;
  }
}

class Data {
  int? id;
  int? itemId;

  Data({this.id, this.itemId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_id'] = itemId;
    return data;
  }
}
