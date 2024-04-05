import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/common_app_bar.dart';
import 'package:newbee_talk/common/utils/common_text.dart';
import 'package:newbee_talk/features/auth/models/chat_message.dart';
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
      body: Container(
        margin: const EdgeInsets.only(
          left: Sizes.size20,
          right: Sizes.size20,
          top: Sizes.size16,
        ),
        child: Column(
          children: [
            /// DateTime.now()
            Center(
              child: CommonText(
                textContent: cont.datetimeToString(),
                textSize: Sizes.size16,
                textColor: const Color(0xFFABA7FF),
              ),
            ),

            /// onMessage Realtime
            Obx(
              () => StreamBuilder(
                stream: cont.stream(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: cont.msg!.length,
                    itemBuilder: (context, index) => _buildMessageBody(
                      cont.msg![index],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build Chatting Message UI
  Widget _buildMessageBody(ChatMessageModel model) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: Sizes.size10,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(360),
        child: Image.network(
          model.profileUrl!,
          width: Sizes.size48,
          height: Sizes.size48,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
