// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthChopperService.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$AuthChopperService extends AuthChopperService {
  _$AuthChopperService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = AuthChopperService;

  @override
  Future<Response<GeneralErrorModel>> forgotPassword(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('forgotpassword');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<MerchandiseDataModel>> imageUpload(
      {required Map<String, File> param}) {
    final Uri $url = Uri.parse('uploads');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<MerchandiseDataModel, MerchandiseDataModel>($request);
  }

  @override
  Future<Response<LoginAndSkipModel>> logInAPi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('/auth/login');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginAndSkipModel, LoginAndSkipModel>($request);
  }

  @override
  Future<Response<LoginAndSkipModel>> skipAPi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('/auth/guest-login');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<LoginAndSkipModel, LoginAndSkipModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> signUpUserAPi({
    required String name,
    required String username,
    required String email,
    required String phone,
    required String password,
    required String deviceType,
    String? fcm,
    required String confirmPassword,
    String? image,
  }) {
    final Uri $url = Uri.parse('/auth/register');
    final List<PartValue> $parts = <PartValue>[
      PartValue<String>(
        'name',
        name,
      ),
      PartValue<String>(
        'username',
        username,
      ),
      PartValue<String>(
        'email',
        email,
      ),
      PartValue<String>(
        'phone',
        phone,
      ),
      PartValue<String>(
        'password',
        password,
      ),
      PartValue<String>(
        'deviceType',
        deviceType,
      ),
      PartValue<String?>(
        'fcm',
        fcm,
      ),
      PartValue<String>(
        'confirm_password',
        confirmPassword,
      ),
      PartValueFile<String?>(
        'image',
        image,
      ),
    ];
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      parts: $parts,
      multipart: true,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }

  @override
  Future<Response<WalkthroughDataModel>> walkthroughApi() {
    final Uri $url = Uri.parse('/walkthrough-screens');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
    );
    return client.send<WalkthroughDataModel, WalkthroughDataModel>($request);
  }

  @override
  Future<Response<GeneralErrorModel>> changePasswordAPi(
      {required Map<String, dynamic> param}) {
    final Uri $url = Uri.parse('/auth/change-password');
    final $body = param;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
    );
    return client.send<GeneralErrorModel, GeneralErrorModel>($request);
  }
}
