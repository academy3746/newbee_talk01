import 'dart:async';

import 'package:newbee_talk/features/auth/models/chat_message.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:newbee_talk/features/main/models/chat_room.dart';
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

  /// 채팅방 목록 출력
  Future<List<ChatMessageModel>> fetchChatRooms() async {
    List<ChatMessageModel> res = [];

    final roomMap = await supabase.from('chat_room').select();

    List<ChatRoomModel> roomList = roomMap
        .map(
          (data) => ChatRoomModel.fromJson(data),
        )
        .toList();

    for (var room in roomList) {
      final messageMap = await supabase
          .from('chat_message')
          .select()
          .eq(
            'chat_room_id',
            room.idx!,
          )
          .order(
            'created_at',
            ascending: true,
          );

      if (messageMap.isEmpty) continue;

      List<ChatMessageModel> messages = messageMap
          .map(
            (data) => ChatMessageModel.fromJson(data),
          )
          .toList();

      res.add(messages.last);
    }

    return res;
  }

  /// 로그인 유저 UID 획득
  String getMyUid() {
    return supabase.auth.currentUser!.id;
  }
}
