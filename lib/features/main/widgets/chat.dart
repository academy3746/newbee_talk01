import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newbee_talk/common/constants/gaps.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/common_app_bar.dart';
import 'package:newbee_talk/common/utils/common_text.dart';
import 'package:newbee_talk/common/utils/supabase_service.dart';
import 'package:newbee_talk/features/auth/models/chat_message.dart';

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
        margin: const EdgeInsets.all(Sizes.size16),
        padding: const EdgeInsets.all(Sizes.size8),
        child: FutureBuilder(
          future: SupabaseService().fetchChatRooms(),
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

            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var model = snapshot.data![index];

                return _buildChatRoomList(
                  model,
                  index,
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatRoomList(ChatMessageModel model, int index) {
    return Container(
      decoration: ShapeDecoration(
        color: index % 2 == 0 ? const Color(0xFFEDEDED) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size6),
          side: index % 2 == 0
              ? BorderSide.none
              : const BorderSide(
                  width: 1.0,
                  color: Colors.black,
                ),
        ),
      ),
      child: Row(
        children: [
          /// 프로필 사진
          SizedBox(
            height: Sizes.size64,
            width: Sizes.size64,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: model.profileUrl == null
                  ? const FaIcon(FontAwesomeIcons.user)
                  : Image.network(
                      model.profileUrl!,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Gaps.h10,

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                /// 사용자 이름
                CommonText(
                  textContent: model.name,
                  textSize: Sizes.size16,
                  textColor: Colors.black,
                  textWeight: FontWeight.w700,
                ),
                Gaps.v10,

                /// 채팅 메시지
                CommonText(
                  textContent: model.message,
                  textSize: Sizes.size12,
                  textColor: Colors.black,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
