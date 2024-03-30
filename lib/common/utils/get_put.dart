import 'package:get/get.dart';
import 'package:newbee_talk/features/auth/controllers/login_controller.dart';
import 'package:newbee_talk/features/splash/controllers/splash_controller.dart';

class GetController {
  static void put() {
    /// Splash Cont
    Get.put(SplashCont());

    /// Login Cont
    Get.put(LoginCont());
  }
}