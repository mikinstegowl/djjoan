class LiveVideoLikeModel {
  bool? success;
  String? message;
  int? likesCount;
  String? queryKeyType;

  LiveVideoLikeModel(
      {this.success, this.message, this.likesCount, this.queryKeyType});

  LiveVideoLikeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    likesCount = json['likesCount'];
    queryKeyType = json['queryKeyType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['likesCount'] = likesCount;
    data['queryKeyType'] = queryKeyType;
    return data;
  }
}
