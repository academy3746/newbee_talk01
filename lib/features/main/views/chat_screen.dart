import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/utils/common_app_bar.dart';
import 'package:newbee_talk/features/main/controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const String routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    final cont = ChatCont.to;

    return Obx(
      () => Scaffold(
        appBar: CommonAppBar(
          title: cont.member!.name,
          isLeading: true,
          backgroundColor: Theme.of(context).primaryColor,
          iconColor: Colors.white,
          fontColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Container(),
      ),
    );
  }
}
