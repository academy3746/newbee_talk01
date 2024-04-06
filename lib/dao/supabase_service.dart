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

  /// 대화방 신규 생성 or 진입
  Future<ChatRoomModel> fetchOrInsertChatRoom(String otherUid) async {
    final chatRoomMap = await supabase.from('chat_room').select().contains(
          'members_uid',
          '{$otherUid, ${getMyUid()}}',
        );

    /// 대화방 신규 생성
    if (chatRoomMap.isEmpty) {
      ChatRoomModel chatRoomModel;

      List<Map<String, dynamic>> chatRoomList = await supabase
          .from('chat_room')
          .insert(ChatRoomModel(membersUid: [otherUid, getMyUid()]).toMap())
          .select();

      chatRoomModel = chatRoomList
          .map((data) => ChatRoomModel.fromJson(data))
          .toList()
          .single;

      return chatRoomModel;
    }

    /// 기존 대화방 진입
    return chatRoomMap
        .map((data) => ChatRoomModel.fromJson(data))
        .toList()
        .single;
  }

  /// 로그인 유저 UID 획득
  String getMyUid() {
    return supabase.auth.currentUser!.id;
  }

  /// 대화 메시지 실시간 구독
  Stream<List<Map<String, dynamic>>> fetchChatMessage(String uid, int idx) {
    final chatStream = supabase
        .from('chat_message')
        .stream(
          primaryKey: ['idx'],
        )
        .eq(
          'chat_room_id',
          idx,
        )
        .order(
          'created_at',
          ascending: true,
        );

    return chatStream;
  }

  /// 본인의 회원정보 갱신
  Future<MemberModel> fetchMyAccount() async {
    final userMap = await supabase.from('member').select().eq(
          'uid',
          getMyUid(),
        );

    var res = userMap
        .map(
          (data) => MemberModel.fromMap(data),
        )
        .toList()
        .single;

    return res;
  }

  /// 리얼타임 메시지 전송
  Future<void> sendDirectMessage(
    String message,
    MemberModel userModel,
    int idx,
  ) async {
    await supabase.from('chat_message').insert(ChatMessageModel(
          message: message,
          uid: userModel.uid,
          chatRoomId: idx,
          name: userModel.name,
          profileUrl: userModel.profileUrl,
        ).toMap());
  }
}
