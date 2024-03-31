import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/constants/gaps.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/common_app_bar.dart';
import 'package:newbee_talk/common/utils/common_text.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:newbee_talk/features/main/controllers/user_info_controller.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (InfoCont cont) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: CommonAppBar(
            title: '프로필',
            isLeading: false,
            backgroundColor: Theme.of(context).primaryColor,
            fontColor: Colors.white,
            iconColor: Colors.white,
            actions: [
              TextButton(
                onPressed: () => cont.logOut(),
                child: const CommonText(
                  textContent: '로그아웃',
                  textColor: Colors.black45,
                  textSize: Sizes.size20,
                  textWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          body: FutureBuilder(
            future: cont.getCurrentUser(),
            builder: (context, snapshot) {
              var userModel = snapshot.data;

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

              return _myProfile(
                userModel!,
                context,
              );
            },
          ),
        );
      },
    );
  }

  /// 회원 정보 위젯
  Widget _myProfile(MemberModel model, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(Sizes.size20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile Card
          Container(
            margin: const EdgeInsets.only(bottom: Sizes.size32),
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size24,
            ),
            decoration: ShapeDecoration(
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.size10),
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.black,
                ),
              ),
            ),
            child: Row(
              children: [
                /// 프로필 사진
                ClipRRect(
                  borderRadius: BorderRadius.circular(360),
                  child: model.profileUrl != null
                      ? Image.network(
                          model.profileUrl.toString(),
                          width: Sizes.size52,
                          height: Sizes.size52,
                          fit: BoxFit.cover,
                        )
                      : const FaIcon(
                          FontAwesomeIcons.user,
                          size: Sizes.size52,
                        ),
                ),
                Gaps.h20,

                /// 회원명 및 이메일
                Container(
                  margin: const EdgeInsets.only(bottom: Sizes.size8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonText(
                        textContent: model.name,
                        textColor: Colors.black,
                        textWeight: FontWeight.w700,
                        textSize: Sizes.size16,
                      ),
                      CommonText(
                        textContent: model.email,
                        textColor: Colors.grey.shade500,
                        textSize: Sizes.size12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// Introduce
          const CommonText(
            textContent: '자기소개',
            textColor: Colors.black,
            textSize: Sizes.size20,
            textWeight: FontWeight.w700,
          ),
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: Sizes.size20),
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                  vertical: Sizes.size24,
                ),
                decoration: ShapeDecoration(
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Sizes.size10),
                    borderSide: const BorderSide(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                ),
                child: CommonText(
                  textContent: model.introduce,
                  textColor: Colors.black,
                  textSize: Sizes.size16,
                  textWeight: FontWeight.w700,
                )),
          ),
        ],
      ),
    );
  }
}
