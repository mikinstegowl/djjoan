class AddSongPlayListModel {
  bool? success;
  Data? data;
  String? message;

  AddSongPlayListModel({this.success, this.data, this.message});

  AddSongPlayListModel.fromJson(Map<String, dynamic> json) {
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
  int? playlistId;
  int? songId;
  int? menuId;
  int? playListCount;
  String? createdAt;

  Data(
      {this.playListCount,
      this.id,
      this.playlistId,
      this.songId,
      this.menuId,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playlistId = json['playlist_id'];
    songId = json['song_id'];
    menuId = json['menu_id'];
    playListCount = json['playlist_count'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['playlist_id'] = playlistId;
    data['song_id'] = songId;
    data['menu_id'] = menuId;
    data['playlist_count'] = playListCount;
    data['created_at'] = createdAt;
    return data;
  }
}
