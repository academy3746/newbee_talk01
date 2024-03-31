import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/constants/gaps.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/app_snackbar.dart';
import 'package:newbee_talk/common/utils/common_app_bar.dart';
import 'package:newbee_talk/common/utils/common_button.dart';
import 'package:newbee_talk/common/utils/common_input_field.dart';
import 'package:newbee_talk/common/utils/common_text.dart';
import 'package:newbee_talk/common/utils/validator.dart';
import 'package:newbee_talk/features/auth/controllers/sign_up_controller.dart';
import 'package:newbee_talk/features/auth/widgets/profile.dart';
import 'package:newbee_talk/get_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/signup';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// Form Field Validation
  InputFieldValidator? val;

  @override
  void initState() {
    super.initState();

    val = InputFieldValidator(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: const CommonAppBar(
        title: '푸드피커 가입하기',
        isLeading: true,
        backgroundColor: Colors.white,
        iconColor: Colors.black,
        fontColor: Colors.black,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          margin: const EdgeInsets.all(Sizes.size20),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: _buildSignUpScreen(context),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpScreen(BuildContext context) {
    final cont = SignUpCont.to;

    cont.initImageUploader(context);

    return Obx(
      () => Form(
        key: cont.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile IMG
            GestureDetector(
              onTap: () async {
                cont.uploader.showImageUploadBottomSheet();
              },
              child: BuildProfile(profileImg: cont.profileImg),
            ),
            Gaps.v32,

            /// Nickname
            Gaps.v16,
            CommonText(
              textContent: '닉네임',
              textSize: Sizes.size20,
              textColor: Colors.grey.shade500,
              textWeight: FontWeight.w700,
            ),
            InputField(
              controller: cont.nameController,
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              enabled: true,
              readOnly: false,
              onTap: null,
              hintText: '닉네임을 입력해 주세요',
              obscureText: false,
              maxLines: 1,
              maxLength: 15,
              validator: (value) => val!.nameValidation(value),
            ),

            /// E-mail Addr.
            Gaps.v16,
            CommonText(
              textContent: '이메일',
              textSize: Sizes.size20,
              textColor: Colors.grey.shade500,
              textWeight: FontWeight.w700,
            ),
            InputField(
              controller: cont.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              enabled: true,
              readOnly: false,
              onTap: null,
              hintText: '이메일 주소를 입력해 주세요',
              obscureText: false,
              maxLines: 1,
              maxLength: 50,
              validator: (value) => val!.emailValidation(value),
            ),

            /// Password
            Gaps.v16,
            CommonText(
              textContent: '패스워드',
              textSize: Sizes.size20,
              textColor: Colors.grey.shade500,
              textWeight: FontWeight.w700,
            ),
            InputField(
              controller: cont.pwdController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              enabled: true,
              readOnly: false,
              onTap: null,
              hintText: '패스워드를 입력해 주세요',
              obscureText: true,
              maxLines: 1,
              maxLength: 25,
              validator: (value) => val!.pwdValidation(value),
            ),

            /// Confirm PWD
            Gaps.v16,
            CommonText(
              textContent: '패스워드 확인',
              textSize: Sizes.size20,
              textColor: Colors.grey.shade500,
              textWeight: FontWeight.w700,
            ),
            InputField(
              controller: cont.confirmController,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.next,
              enabled: true,
              readOnly: false,
              onTap: null,
              hintText: '패스워드를 다시 한 번 입력해 주세요',
              obscureText: true,
              maxLines: 1,
              maxLength: 25,
              validator: (value) => val!.confirmValidation(value),
            ),

            /// Introduce
            Gaps.v16,
            CommonText(
              textContent: '자기소개',
              textSize: Sizes.size20,
              textColor: Colors.grey.shade500,
              textWeight: FontWeight.w700,
            ),
            InputField(
              controller: cont.introController,
              textInputAction: TextInputAction.newline,
              enabled: true,
              readOnly: false,
              onTap: null,
              hintText: '자기소개를 입력해 주세요',
              maxLines: 5,
              maxLength: 500,
              obscureText: false,
              validator: (value) => val!.introValidation(value),
            ),

            /// 회원가입 완료
            Container(
              width: MediaQuery.of(context).size.width,
              height: Sizes.size64,
              margin: const EdgeInsets.symmetric(vertical: Sizes.size32),
              child: CommonButton(
                btnBackgroundColor: Colors.black,
                btnText: '가입 완료',
                textColor: Colors.white,
                btnAction: () async {
                  var emailValue = cont.emailController.text;
                  var pwdValue = cont.pwdController.text;

                  /// Check Validation
                  if (!cont.formKey.currentState!.validate()) {
                    return;
                  }

                  /// CRUD on Supabase Server
                  bool success = await cont.signUpWithEmail(
                    emailValue,
                    pwdValue,
                  );

                  if (!success) {
                    return;
                  } else {
                    var snackBar = AppSnackbar(
                      msg: '함께 하게 되어서 기뻐요!',
                    );

                    if (!context.mounted) return;

                    snackBar.showSnackbar(context);

                    GetRouter.main().off();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
