import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  SupabaseService._internal();

  static final SupabaseService _instance = SupabaseService._internal();

  factory SupabaseService() => _instance;

  /// 채팅 가능한 앱 유저 리스트 출력 (본인 제외)
  Future<List<MemberModel>> fetchChatProfiles() async {
    final userMap = await supabase.from('member').select().neq(
          'uid',
          getMyUid(),
        );

    return userMap.map((data) => MemberModel.fromMap(data)).toList();
  }

  /// 로그인 유저 UID 획득
  String getMyUid() {
    return supabase.auth.currentUser!.id;
  }
}
