class NotificationDataModel {
  int? status;
  String? message;
  List<Data>? data;
  int? perPage;
  int? currentPage;
  int? lastPage;

  NotificationDataModel(
      {this.status,
      this.message,
      this.data,
      this.perPage,
      this.currentPage,
      this.lastPage});

  NotificationDataModel.fromJson(Map<String, dynamic> json) {
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
  int? notificationsId;
  String? title;
  String? message;
  String? createdAt;

  Data({this.notificationsId, this.title, this.message, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    notificationsId = json['notifications_id'];
    title = json['title'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notifications_id'] = notificationsId;
    data['title'] = title;
    data['message'] = message;
    data['created_at'] = createdAt;
    return data;
  }
}
