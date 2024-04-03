import 'package:get/get.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:newbee_talk/features/main/models/chat_room.dart';

class ChatCont extends GetxController {
  static ChatCont get to => Get.find<ChatCont>();

  /// ChatRoom Model Class Instance
  final _chat = Rx<ChatRoomModel?>(null);

  /// Member Model Class Instance
  final _member = Rx<MemberModel?>(null);

  /// Getter (ChatRoomModel)
  ChatRoomModel? get chat => _chat.value;

  /// Getter (MemberModel)
  MemberModel? get member => _member.value;

  /// Setter (ChatRoomModel)
  void setChatRoomModel(ChatRoomModel model) {
    _chat.value = model;
  }

  /// Setter (MemberModel)
  void setMemberModel(MemberModel model) {
    _member.value = model;
  }
}
