import 'package:get/get.dart';
import 'package:new_music_app/Controller/AuthController.dart';
import 'package:new_music_app/Utils/ChopperClientService/AuthChopperService.dart';
import 'package:new_music_app/Utils/Network/AppChopperClient.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AdService(), permanent: true);
    Get.lazyPut(() =>
        AuthController(
            authChopperService:
            AppChopperClient().getChopperService<AuthChopperService>()));
  }
}
