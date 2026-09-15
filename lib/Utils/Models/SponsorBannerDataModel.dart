class SponsorBannerDataModel {
  int? status;
  String? message;
  List<Data>? data;

  SponsorBannerDataModel({this.status, this.message, this.data});

  SponsorBannerDataModel.fromJson(Map<String, dynamic> json) {
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
  int? sponsorId;
  String? image;
  String? link;
  String? createdAt;

  Data({this.sponsorId, this.image, this.link, this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    sponsorId = json['sponsor_id'];
    image = json['image'];
    link = json['link'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sponsor_id'] = sponsorId;
    data['image'] = image;
    data['link'] = link;
    data['created_at'] = createdAt;
    return data;
  }
}
