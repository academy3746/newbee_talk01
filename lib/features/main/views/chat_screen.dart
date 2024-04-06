import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/constants/gaps.dart';
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
            Expanded(
              child: StreamBuilder(
                stream: cont.stream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    );
                  }

                  var model = snapshot.data!
                      .map(
                        (data) => ChatMessageModel.fromJson(data),
                      )
                      .toList();

                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: model.length,
                    itemBuilder: (context, index) {
                      return _buildPartnerMessage(model[index]);
                    },
                  );
                },
              ),
            ),
            
            /// Send Message
            _buildSendMessage(),
          ],
        ),
      ),
    );
  }

  /// Build Message Receiving UI
  Widget _buildPartnerMessage(ChatMessageModel model) {
    final cont = ChatCont.to;

    if (model.uid == cont.getMyId()) {
      return Container(
        margin: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        child: Expanded(
          child: Wrap(
            alignment: WrapAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  vertical: Sizes.size10,
                ),
                decoration: ShapeDecoration(
                  color: const Color(0xFFFDD835),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Sizes.size10),
                  ),
                  shadows: const [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size12,
                    horizontal: Sizes.size10,
                  ),
                  child: CommonText(
                    textContent: model.message,
                    textColor: Colors.white,
                    textSize: Sizes.size12,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Obx(
        () => Container(
          margin: const EdgeInsets.symmetric(
            vertical: Sizes.size10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              cont.records!.$2.profileUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: Image.network(
                        cont.records!.$2.profileUrl!,
                        width: Sizes.size48,
                        height: Sizes.size48,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const FaIcon(
                      FontAwesomeIcons.user,
                      size: Sizes.size32,
                    ),
              Gaps.h16,
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: Sizes.size10,
                      ),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFEDEDED),
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Color(0xFFEDEDED),
                          ),
                          borderRadius: BorderRadius.circular(Sizes.size10),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size12,
                          horizontal: Sizes.size10,
                        ),
                        child: CommonText(
                          textContent: model.message,
                          textColor: Colors.black,
                          textSize: Sizes.size12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  
  /// Build Message Sending UI
  Widget _buildSendMessage() {
    return Container();
  }
}
