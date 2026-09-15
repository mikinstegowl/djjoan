class SignInModel {
  int? status;
  String? message;
  List<Data>? data;
  String? token;

  SignInModel({this.status, this.message, this.data, this.token});

  SignInModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  int? userId;
  String? image;
  String? name;
  String? username;
  String? email;
  String? phone;
  String? fcmId;
  String? device;

  Data(
      {this.userId,
      this.image,
      this.name,
      this.username,
      this.email,
      this.phone,
      this.fcmId,
      this.device});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    image = json['image'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    phone = json['phone'];
    fcmId = json['fcm_id'];
    device = json['device'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['image'] = image;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['phone'] = phone;
    data['fcm_id'] = fcmId;
    data['device'] = device;
    return data;
  }
}
