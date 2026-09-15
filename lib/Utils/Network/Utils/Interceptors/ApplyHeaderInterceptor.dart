import 'dart:async';
import 'package:chopper/chopper.dart';
import 'package:new_music_app/Utils/SharedPreferences/PrefKeys.dart';
import 'package:new_music_app/Utils/SharedPreferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ApplyHeaderInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    // if (request.url.toString().contains("language")) {
    //   log("url contains \"language\"", name: "from ApplyHeaderInterceptor");
    //   return request;
    // }

    var token;
    SharedPreferences sharedPref = await SharedPreferences.getInstance();

    token = UserPreference.getValue(key: PrefKeys.logInToken) ??
        sharedPref.get("logInToken");
    // await g.Get.find<MySecureStorage>().getStringValue(StorageKeys.token);

    //'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQyMDI4NzUwLCJpYXQiOjE3MTA0OTI3NTAsImp0aSI6ImNiNzA0NjNiZmFiZTRjNDk4MTM0YTMyYzViNTFhZmI4IiwidXNlcl9pZCI6MTM2NSwidGltZXN0YW1wIjoxNzEwNDkyNzUwNDkzLCJlbWFpbCI6InZpc2hlc2hwYXRlbDI2MTBAZ21haWwuY29tIiwidXNlcklkIjoiZmNkMTE2OTktNzlhNS00MTU2LTlkYjEtMDBmNmIxODZmNWE1MTcxMDQ5Mjc1MDQ5MyJ9.yvqRaPV5hPugXBh3jadqKXQ5ro4mRwLpLgoJKgtlHIA';
    // "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzQzNjU3Mzk1LCJpYXQiOjE3MTIxMjEzOTUsImp0aSI6ImI1ZjU1NmE5ZTM4NTRkZWJiM2FiNjNiMmU4YzI4MDI0IiwidXNlcl9pZCI6MTU5MCwidGltZXN0YW1wIjoxNzEyMTIxMzk1MjY2LCJlbWFpbCI6InZpc2hlc2gxOTk5LmN1bXVsYXRpdmVAZ21haWwuY29tIiwidXNlcklkIjoiOTQ0NGNmODEtYWY2YS00ZGYzLWEwNzMtMTkzNjkzOTI3Nzg1MTcxMjEyMTM5NTI2NiJ9.qQl0m3kJBRHakxmDSd_mxor5DHdldPfXrXzqZhK2Eoc";
    // don't add token if null



    if (token == null) {
      return request;
    }
    // return applyHeaders(request, {'x-access-token': token});
    return applyHeaders(request, {'Authorization': 'Bearer $token'});

  }
}
