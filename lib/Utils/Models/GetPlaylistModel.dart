class GetPlayListModel {
  bool? success;
  List<Data>? data;
  String? message;
  int? totalCount;
  int? nextPage;
  int? lastPage;

  GetPlayListModel(
      {this.success,
        this.data,
        this.message,
        this.totalCount,
        this.nextPage,
        this.lastPage});

  GetPlayListModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? playlistName;

  Data({this.id, this.playlistName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    playlistName = json['playlist_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['playlist_name'] = playlistName;
    return data;
  }
}
