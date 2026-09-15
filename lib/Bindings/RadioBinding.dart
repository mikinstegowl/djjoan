import 'package:get/get.dart';
import 'package:new_music_app/Controller/RadioController.dart';
import 'package:new_music_app/Utils/ChopperClientService/HomeChopperService.dart';
import 'package:new_music_app/Utils/Network/AppChopperClient.dart';
import 'package:new_music_app/Utils/Services/AdService.dart';

class RadioBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AdService(), permanent: true);
    Get.lazyPut(
        () => RadioController(
            homeChopperService:
                AppChopperClient().getChopperService<HomeChopperService>()),
        fenix: true);
    // TODO: implement dependencies
  }
}
