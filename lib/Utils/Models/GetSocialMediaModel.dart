class GetSocialMediaModel {
  bool? success;
  String? message;
  Data? data;

  GetSocialMediaModel({this.success, this.message, this.data});

  GetSocialMediaModel.fromJson(Map<String, dynamic> json) {
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
    instagramLink = json['instagramLink'];
    twitterLink = json['twitterLink'];
    facebookLink = json['facebookLink'];
    otherLink = json['otherLink'];
    formLink = json['formLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instagramLink'] = instagramLink;
    data['twitterLink'] = twitterLink;
    data['facebookLink'] = facebookLink;
    data['otherLink'] = otherLink;
    data['formLink'] = formLink;
    return data;
  }
}
