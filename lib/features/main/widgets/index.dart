import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/constants/gaps.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/common_app_bar.dart';
import 'package:newbee_talk/common/utils/common_text.dart';
import 'package:newbee_talk/common/utils/supabase_service.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:newbee_talk/features/main/controllers/index_controller.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        title: 'TALK TALK',
        isLeading: false,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconColor: Colors.white,
        fontColor: Colors.white,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: _buildIndexScreen(),
        ),
      ),
    );
  }

  Widget _buildIndexScreen() {
    final cont = IndexCont.to;

    return Container(
      margin: const EdgeInsets.all(Sizes.size20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.v10,
          const CommonText(
            textContent: '빠르고 쉽게! 원하는 상대와 채팅하세요!',
            textSize: Sizes.size16,
            textColor: Colors.black,
            textWeight: FontWeight.w600,
          ),
          Gaps.v20,
          FutureBuilder(
            future: SupabaseService().fetchChatProfiles(),
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

              return Obx(
                () => GridView.builder(
                  controller: cont.indexController,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var userModel = snapshot.data![index];

                    return GestureDetector(
                      onTap: () {
                        cont.enterChatRoom(
                          userModel.uid,
                          userModel,
                        );
                      },
                      child: _buildProfile(
                        userModel,
                        context,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Chatting User List UI
  Widget _buildProfile(MemberModel userModel, BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.size10),
          side: const BorderSide(
            width: 2,
            color: Colors.black,
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// 프로필 이미지
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.size10),
              child: userModel.profileUrl != null
                  ? Image.network(
                      userModel.profileUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : FaIcon(
                      FontAwesomeIcons.user,
                      color: Theme.of(context).primaryColor,
                      size: Sizes.size100,
                    ),
            ),
          ),

          /// 반투명 배경
          Container(
            color: Colors.black.withOpacity(0.2),
          ),

          /// 닉네임
          Padding(
            padding: const EdgeInsets.all(Sizes.size10),
            child: CommonText(
              textContent: userModel.name,
              textColor: Colors.white,
              textSize: Sizes.size22,
              textWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
