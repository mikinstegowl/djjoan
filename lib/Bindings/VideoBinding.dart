import 'package:get/get.dart';
import 'package:new_music_app/Controller/VideoController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Network/AppChopperClient.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';

class VideoBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(AdService(), permanent: true);
    Get.lazyPut(
        () => VideoController(
            homeChopperService:
                AppChopperClient().getChopperService<HomeChopperService>()),
        fenix: true);
  }
}
