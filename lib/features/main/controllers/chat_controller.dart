import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/constants/date.dart';
import 'package:newbee_talk/common/utils/app_snackbar.dart';
import 'package:newbee_talk/dao/supabase_service.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:newbee_talk/features/main/models/chat_room.dart';

class ChatCont extends GetxController {
  static ChatCont get to => Get.find<ChatCont>();

  /// Instances Model Classes
  final _records = Rx<(ChatRoomModel, MemberModel)?>(null);

  /// Instances View Page TextField Controller
  final _chatFieldCont = TextEditingController().obs;

  /// Instances View Page Scroll Controller
  final _chatScrollCont = ScrollController().obs;

  /// Getter (ChatRoomModel, MemberModel)
  (ChatRoomModel, MemberModel)? get records => _records.value;

  /// Getter (_chatFieldCont)
  TextEditingController get chatFieldCont => _chatFieldCont.value;

  /// Getter (_chatScrollCont)
  ScrollController get chatScrollCont => _chatScrollCont.value;

  /// Setter (ChatRoomModel, MemberModel)
  void setRecords((ChatRoomModel, MemberModel) model) {
    _records.value = model;
  }

  /// Streaming Realtime Message
  Stream<List<Map<String, dynamic>>> stream() {
    var res = SupabaseService().fetchChatMessage(
      records!.$2.uid,
      records!.$1.idx!,
    );

    return res;
  }

  /// Get Current Login User Id
  String getMyId() {
    var res = SupabaseService().getMyUid();

    return res;
  }

  /// Validate TextInputField
  void filedValidator() {
    if (chatFieldCont.text.isEmpty) {
      var snackbar = AppSnackbar(
        msg: '메시지 입력란이 비어있어요!',
      );

      snackbar.showSnackbar(Get.context!);

      return;
    }
  }

  /// Send Message
  Future<void> sendMessage(String message) async {
    filedValidator();

    var userModel = await SupabaseService().fetchMyAccount();

    await SupabaseService().sendDirectMessage(
      message,
      userModel,
      records!.$1.idx!,
    );

    FocusManager.instance.primaryFocus?.unfocus();

    chatFieldCont.clear();
  }

  /// Keyboard Auto Scrolling
  void autoScroll() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(
        const Duration(milliseconds: 300), () {
        if (chatScrollCont.hasClients) {
          chatScrollCont.jumpTo(chatScrollCont.position.maxScrollExtent);
        }
      }
      );
    });
  }

  /// Parse Datetime
  String datetimeToString() {
    var parse = '';

    var now = DateTime.now();

    parse = formatted.format(now);

    return parse;
  }
}
