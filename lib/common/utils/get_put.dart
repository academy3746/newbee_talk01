import 'package:get/get.dart';
import 'package:newbee_talk/features/splash/controllers/splash_controller.dart';

class GetController {
  static void put() {
    /// Splash Feature
    Get.put(SplashScreenController());
  }
}