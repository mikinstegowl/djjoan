class GeneralErrorModel {
  // bool? error;
  String? message;
  int? statusCode;
  bool? success;

  GeneralErrorModel({this.message});

  GeneralErrorModel.fromJson(Map<String, dynamic> json) {
    // error = json['error'];
    // if (json["message"] is List) {
    message = json['message'];
    statusCode = json['status'];
    success = json['success'];
    // } else {
    //   message = json['message'] ?? json["msg"] ?? "Something went wrong!";
    // }
  }
}
