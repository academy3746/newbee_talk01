import 'package:get/get.dart';
import 'package:newbee_talk/features/auth/controllers/login_controller.dart';
import 'package:newbee_talk/features/auth/controllers/sign_up_controller.dart';
import 'package:newbee_talk/features/splash/controllers/splash_controller.dart';

class GetController {
  static void put() {
    /// Splash Controller
    Get.put(SplashCont());

    /// Login Controller
    Get.put(LoginCont());

    /// SignUp Controller
    Get.put(SignUpCont());
  }
}