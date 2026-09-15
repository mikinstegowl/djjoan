class SongUpdateModel {
  bool? success;
  String? message;
  Data? data;

  SongUpdateModel({this.success, this.message, this.data});

  SongUpdateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalShared;
  int? totalPlayed;
  int? favoritesCount;
  int? playListCount;
  bool? isFavorite;

  Data(
      {this.totalShared,
      this.totalPlayed,
      this.favoritesCount,
      this.playListCount,
      this.isFavorite});

  Data.fromJson(Map<String, dynamic> json) {
    totalShared = json['totalShared'];
    totalPlayed = json['totalPlayed'];
    favoritesCount = json['favorites_count'];
    playListCount = json['playlist_count'];
    isFavorite = json['is_favourite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalShared'] = totalShared;
    data['totalPlayed'] = totalPlayed;
    data['favorites_count'] = favoritesCount;
    data['playlist_count'] = playListCount;
    data['is_favourite'] = isFavorite;
    return data;
  }
}
