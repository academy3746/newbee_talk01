import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/common_app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: '채팅방 목록',
        isLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconColor: Colors.white,
        fontColor: Colors.white,
      ),
      body: Container(
        margin: const EdgeInsets.all(Sizes.size20),
        child: FutureBuilder(
          future: null,
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
                    fontSize: Sizes.size14,
                  ),
                ),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
