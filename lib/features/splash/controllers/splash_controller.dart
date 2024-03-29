import 'package:get/get.dart';
import 'package:newbee_talk/get_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get to => Get.find<SplashScreenController>();

  /// Supabase Access
  final _supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();

    navigateProcess();
  }

  /// 로그인 여부에 따른 Route 분기문 처리
  Future<void> navigateProcess() async {
    var loginUser = _supabase.auth.currentUser;

    if (loginUser == null) {
      Future.delayed(
        const Duration(seconds: 3),
        () => GetRouter.login().to(),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () => GetRouter.main().to(),
      );
    }
  }
}
