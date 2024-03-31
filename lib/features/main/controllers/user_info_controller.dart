import 'package:get/get.dart';
import 'package:newbee_talk/common/utils/app_snackbar.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:newbee_talk/get_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfoCont extends GetxController {
  InfoCont get to => Get.find<InfoCont>();

  /// Initialize Supabase Auth Client
  final _supabase = Supabase.instance.client;

  /// 현재 접속중인 단일 회원정보
  Future<MemberModel> getCurrentUser() async {
    final userMap = await _supabase.from('member').select().eq(
          'uid',
          _supabase.auth.currentUser!.id,
        );

    final user = userMap
        .map(
          (data) => MemberModel.fromMap(data),
        )
        .single;

    return user;
  }

  /// Logout
  Future<void> logOut() async {
    var snackbar = AppSnackbar(
      msg: '정상적으로 로그아웃 되었습니다!',
    );

    snackbar.showSnackbar(Get.context!);

    await _supabase.auth.signOut();

    GetRouter.login().offAnd();
  }
}
