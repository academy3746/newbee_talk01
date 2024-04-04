import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/gaps.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/common_app_bar.dart';
import 'package:newbee_talk/common/utils/common_text.dart';
import 'package:newbee_talk/features/main/controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const String routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    final cont = ChatCont.to;

    return Scaffold(
      appBar: CommonAppBar(
        title: cont.records!.$2.name,
        isLeading: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconColor: Colors.white,
        fontColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Gaps.v16,

          /// DateTime.now()
          Center(
            child: CommonText(
              textContent: cont.datetimeToString(),
              textSize: Sizes.size16,
              textColor: const Color(0xFFABA7FF),
            ),
          ),

          /// onMessage Realtime
          _buildMessageBody(),
        ],
      ),
    );
  }

  /// Build Chatting Message UI
  Widget _buildMessageBody() {
    return Container();
  }
}
