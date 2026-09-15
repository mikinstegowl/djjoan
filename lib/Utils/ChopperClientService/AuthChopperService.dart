import "dart:io";

import 'package:chopper/chopper.dart';
import 'package:new_music_app/Utils/Models/GeneralErrorModel.dart';
import 'package:new_music_app/Utils/Models/MerchandiseDataModel.dart';
import 'package:new_music_app/Utils/Models/LoginAndSkipModel.dart';
import 'package:new_music_app/Utils/Models/WalkthroughDataModel.dart';

part 'AuthChopperService.chopper.dart';

@ChopperApi()
abstract class AuthChopperService extends ChopperService {
  static AuthChopperService create({ChopperClient? client}) {
    return _$AuthChopperService(client);
  }

  // @Get(
  //      path: '/app-walkthrough/api/all',
  //      headers: {'Authorization': 'HelloWorld!'})
  //  Future<Response<WalkThroughModel>> walkThroughAPi();
  //
  // @Post(path: 'signin')
  // Future<Response<SignInModel>> signInApi(
  //     {@body required Map<String, dynamic> param});
  //
  // @Post(path: 'skipuser')
  // Future<Response<SkipUserDataModel>> skipUserApi(
  //     {@body required Map<String, dynamic> param});
  //
  // @Post(path: 'signup')
  // Future<Response<GeneralErrorModel>> signUpApi(
  //     {@body required Map<String, dynamic> param});

  @Post(path: 'forgotpassword')
  Future<Response<GeneralErrorModel>> forgotPassword(
      {@body required Map<String, dynamic> param});

  @Post(path: 'uploads')
  @multipart
  Future<Response<MerchandiseDataModel>> imageUpload(
      {@body required Map<String, File> param});

  // @Get(path: 'walkthrough')
  // Future<Response<WalkthroughDataModel>> walkthroughApi();

  /// new API
  @Post(path: '/auth/login')
  Future<Response<LoginAndSkipModel>> logInAPi(
      {@body required Map<String, dynamic> param});

  @Post(path: '/auth/guest-login')
  Future<Response<LoginAndSkipModel>> skipAPi(
      {@body required Map<String, dynamic> param});

  @Post(path: '/auth/register')
  @multipart
  Future<Response<GeneralErrorModel>> signUpUserAPi({
    @Part('name') required String name,
    @Part('username') required String username,
    @Part('email') required String email,
    @Part('phone') required String phone,
    @Part('password') required String password,
    @Part('deviceType') required String deviceType,
    @Part('fcm')  String? fcm,
    @Part('confirm_password') required String confirmPassword,
    @PartFile('image') String? image, // Optional image file
  });
  @Get(path: '/walkthrough-screens')
  Future<Response<WalkthroughDataModel>> walkthroughApi();

  @Post(path: '/auth/change-password')
  Future<Response<GeneralErrorModel>> changePasswordAPi(
      {@body required Map<String, dynamic> param});
}
