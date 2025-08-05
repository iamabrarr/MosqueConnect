import 'package:get/get.dart';
import 'package:mosqueconnect/controllers/ads.dart';
import 'package:mosqueconnect/controllers/auth.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(AdsController());
  }
}
