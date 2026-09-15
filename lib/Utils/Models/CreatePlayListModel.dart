// class CreatePlayListModel {
//   int? status;
//   String? message;
//   int? playlistId;
//   int? userId;
//   String? playlistName;
//
//   CreatePlayListModel(
//       {this.status,
//       this.message,
//       this.playlistId,
//       this.userId,
//       this.playlistName});
//
//   CreatePlayListModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     playlistId = json['playlist_id'];
//     userId = json['user_id'];
//     playlistName = json['playlist_name'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     data['playlist_id'] = this.playlistId;
//     data['user_id'] = this.userId;
//     data['playlist_name'] = this.playlistName;
//     return data;
//   }
// }
class CreatePlayListModel {
  bool? success;
  Data? data;
  String? message;

  CreatePlayListModel({this.success, this.data, this.message});

  CreatePlayListModel.fromJson(Map<String, dynamic> json) {
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
  String? playlistName;
  String? createdAt;

  Data({this.id, this.playlistName, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playlistName = json['playlist_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['playlist_name'] = playlistName;
    data['created_at'] = createdAt;
    return data;
  }
}
