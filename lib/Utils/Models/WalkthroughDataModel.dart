// class WalkthroughDataModel {
//   int? status;
//   String? message;
//   List<WebData>? webData;
//   List<WebData>? appData;
//
//   WalkthroughDataModel({this.status, this.message, this.webData, this.appData});
//
//   WalkthroughDataModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['web_data'] != null) {
//       webData = <WebData>[];
//       json['web_data'].forEach((v) {
//         webData!.add(new WebData.fromJson(v));
//       });
//     }
//     if (json['app_data'] != null) {
//       appData = <WebData>[];
//       json['app_data'].forEach((v) {
//         appData!.add(new WebData.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.webData != null) {
//       data['web_data'] = this.webData!.map((v) => v.toJson()).toList();
//     }
//     if (this.appData != null) {
//       data['app_data'] = this.appData!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class WebData {
//   String? appImage;
//   String? appTitle;
//   String? webImage;
//   String? webTitle;
//   String? createdAt;
//   String? updatedAt;
//
//   WebData(
//       {this.appImage,
//       this.appTitle,
//       this.webImage,
//       this.webTitle,
//       this.createdAt,
//       this.updatedAt});
//
//   WebData.fromJson(Map<String, dynamic> json) {
//     appImage = json['app_image'];
//     appTitle = json['app_title'];
//     webImage = json['web_image'];
//     webTitle = json['web_title'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['app_image'] = this.appImage;
//     data['app_title'] = this.appTitle;
//     data['web_image'] = this.webImage;
//     data['web_title'] = this.webTitle;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
class WalkthroughDataModel {
  bool? success;
  String? message;
  Data? data;

  WalkthroughDataModel({this.success, this.message, this.data});

  WalkthroughDataModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  List<String>? images;

  Data({this.title, this.images});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['images'] = images;
    return data;
  }
}
