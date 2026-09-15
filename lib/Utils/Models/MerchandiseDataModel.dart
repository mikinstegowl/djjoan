class MerchandiseDataModel {
  int? status;
  String? message;
  String? link;
  String? url;

  MerchandiseDataModel({this.status, this.message, this.link, this.url});

  MerchandiseDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    link = json['link'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['link'] = link;
    data['url'] = url;
    return data;
  }
}
