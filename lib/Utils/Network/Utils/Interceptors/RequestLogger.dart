import 'dart:async';
import 'dart:developer';
import 'package:chopper/chopper.dart';

class RequestLogger implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) {
    log("=====================================${request.method} REQUEST=====================================",
        name: "Request");

    log("==> ${request.url.toString()}", name: "Request URL");
    log("==> ${request.headers}", name: "header URL");
    log("==> ${request.body.toString()}", name: "Request parameters");
    log("===========================================================================================",
        name: "Request");
        
    return request;
  }
}
