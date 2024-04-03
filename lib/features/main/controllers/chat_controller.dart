import 'package:get/get.dart';
import 'package:newbee_talk/common/constants/date.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:newbee_talk/features/main/models/chat_room.dart';

class ChatCont extends GetxController {
  static ChatCont get to => Get.find<ChatCont>();

  /// Instances Model Classes
  final _records = Rx<(ChatRoomModel, MemberModel)?>(null);

  /// Getter (ChatRoomModel, MemberModel)
  (ChatRoomModel, MemberModel)? get records => _records.value;

  /// Setter (ChatRoomModel, MemberModel)
  void setRecords((ChatRoomModel, MemberModel) model) {
    _records.value = model;
  }

  /// Parse Datetime
  String datetimeToString() {
    var parse = '';

    var now = DateTime.now();

    parse = formatted.format(now);

    return parse;
  }
}
