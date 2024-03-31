import 'package:get/get.dart';
import 'package:newbee_talk/features/auth/controllers/login_controller.dart';
import 'package:newbee_talk/features/auth/controllers/sign_up_controller.dart';
import 'package:newbee_talk/features/main/controllers/index_controller.dart';
import 'package:newbee_talk/features/main/controllers/main_controller.dart';
import 'package:newbee_talk/features/main/controllers/user_info_controller.dart';
import 'package:newbee_talk/features/splash/controllers/splash_controller.dart';

class GetController {
  static void put() {
    /// [Splash] Splash Controller
    Get.put(SplashCont());

    /// [Auth] Login Controller
    Get.put(LoginCont());

    /// [Auth] SignUp Controller
    Get.put(SignUpCont());

    /// [Main] Main Controller
    Get.put(MainCont());

    /// [Main] User Info Controller
    Get.put(InfoCont());

    /// [Main] Index Controller
    Get.put(IndexCont());
  }
}