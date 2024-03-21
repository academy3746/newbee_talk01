import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/sizes.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(Sizes.size20),
        child: const Center(
          child: Text(
            'CHAT',
            style: TextStyle(
              color: Colors.black,
              fontSize: Sizes.size42,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
