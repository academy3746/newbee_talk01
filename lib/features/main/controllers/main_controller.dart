import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/dao/supabase_service.dart';
import 'package:newbee_talk/features/main/controllers/chat_controller.dart';
import 'package:newbee_talk/features/main/widgets/chat.dart';
import 'package:newbee_talk/features/main/widgets/index.dart';
import 'package:newbee_talk/features/main/widgets/user_info.dart';
import 'package:newbee_talk/get_router.dart';

class MainCont extends GetxController {
  static MainCont get to => Get.find<MainCont>();

  /// Selected Index No.
  final _screenIndex = 0.obs;

  /// Index Screen Footer
  final List<Widget> _screens = [
    const IndexScreen(),
    const ChatListScreen(),
    const InfoScreen(),
  ];

  /// Switch Bottom Navigation Bar
  void bottomOnTap(int index) {
    _screenIndex(index);
  }

  /// Get MyUid from server
  String getMyUid() {
    var res = SupabaseService().getMyUid();

    return res;
  }

  /// Enter Current Chatroom with Idx
  Future enterChatRoom(int chatRoomId) async {
    final chatCont = ChatCont.to;

    var chatRoomModel = await SupabaseService().fetchCurrentChatRoom(
      chatRoomId,
    );

    String? otherUid;

    for (String uid in chatRoomModel.membersUid) {
      if (uid != getMyUid()) {
        otherUid = uid;
        break;
      }
    }

    var userModel = await SupabaseService().fetchOtherUser(
      otherUid!,
    );

    chatCont.setRecords((
      chatRoomModel,
      userModel,
    ));

    GetRouter.chat().to();
  }

  int get screenIndex => _screenIndex.value;

  List<Widget> get screens => _screens;
}
