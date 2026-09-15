import 'package:get/get.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Network/AppChopperClient.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';

class MenuPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AdService(), permanent: true);
    Get.lazyPut(() => MenuPageController(
        homeChopperService:
            AppChopperClient().getChopperService<HomeChopperService>()));
    // TODO: implement dependencies
  }
}
