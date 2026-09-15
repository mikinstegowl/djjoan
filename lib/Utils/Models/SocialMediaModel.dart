class SocialMediaModel {
  int? status;
  String? message;
  List<Data>? data;

  SocialMediaModel({this.status, this.message, this.data});

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
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
  String? instagramLink;
  String? twitterLink;
  String? facebookLink;
  String? otherLink;
  String? formLink;

  Data(
      {this.instagramLink,
      this.twitterLink,
      this.facebookLink,
      this.otherLink,
      this.formLink});

  Data.fromJson(Map<String, dynamic> json) {
    instagramLink = json['instagram_link'];
    twitterLink = json['twitter_link'];
    facebookLink = json['facebook_link'];
    otherLink = json['other_link'];
    formLink = json['form_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instagram_link'] = instagramLink;
    data['twitter_link'] = twitterLink;
    data['facebook_link'] = facebookLink;
    data['other_link'] = otherLink;
    data['form_link'] = formLink;
    return data;
  }
}
