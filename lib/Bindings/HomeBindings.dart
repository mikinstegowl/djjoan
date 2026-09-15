import 'package:get/get.dart';
import 'package:new_music_app/Controller/BaseController.dart';
import 'package:new_music_app/Controller/HomeController.dart';
import 'package:new_music_app/Controller/LiveVideoController.dart';
import 'package:new_music_app/Controller/MenuPageController.dart';
import 'package:new_music_app/Controller/PlayListController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Network/AppChopperClient.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AdService(), permanent: true);
    Get.put(LiveVideoController(
        homeChopperService:
            AppChopperClient().getChopperService<HomeChopperService>()));
    Get.put(BaseController(), permanent: true);
    Get.lazyPut(
        () => HomeController(
            homeChopperService:
                AppChopperClient().getChopperService<HomeChopperService>()),
        fenix: true);
    Get.lazyPut(
        () => PlayListController(
            homeChopperService:
                AppChopperClient().getChopperService<HomeChopperService>()),
        fenix: true);
    Get.lazyPut(
        () => MenuPageController(
            homeChopperService:
                AppChopperClient().getChopperService<HomeChopperService>()),
        fenix: true);
    // TODO: implement dependencies
  }
}
