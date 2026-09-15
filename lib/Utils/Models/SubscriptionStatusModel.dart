class SubscriptionStatusModel {
  bool? success;
  Data? data;
  String? message;

  SubscriptionStatusModel({this.success, this.data, this.message});

  SubscriptionStatusModel.fromJson(Map<String, dynamic> json) {
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
  bool? isActive;

  Data({this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isActive'] = isActive;
    return data;
  }
}
