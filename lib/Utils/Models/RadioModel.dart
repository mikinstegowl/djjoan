class RadioModel {
  int? status;
  String? message;
  List<Data>? data;

  RadioModel({this.status, this.message, this.data});

  RadioModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? categoryitemsId;
  String? categoryId;
  int? menuId;
  int? songId;
  String? songName;
  String? songImage;
  String? song;
  String? createdAt;

  Data(
      {this.categoryitemsId,
      this.categoryId,
      this.menuId,
      this.songId,
      this.songName,
      this.songImage,
      this.song,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    categoryitemsId = json['categoryitems_id'];
    categoryId = json['category_id'];
    menuId = json['menu_id'];
    songId = json['song_id'];
    songName = json['song_name'];
    songImage = json['song_image'];
    song = json['song'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryitems_id'] = categoryitemsId;
    data['category_id'] = categoryId;
    data['menu_id'] = menuId;
    data['song_id'] = songId;
    data['song_name'] = songName;
    data['song_image'] = songImage;
    data['song'] = song;
    data['created_at'] = createdAt;
    return data;
  }
}
