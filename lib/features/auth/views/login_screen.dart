// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/constants/gaps.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/back_handler_button.dart';
import 'package:newbee_talk/common/utils/common_button.dart';
import 'package:newbee_talk/common/utils/common_input_field.dart';
import 'package:newbee_talk/common/utils/common_text.dart';
import 'package:newbee_talk/common/utils/validator.dart';
import 'package:newbee_talk/features/auth/controllers/login_controller.dart';
import 'package:newbee_talk/get_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Exit Application
  BackHandlerButton? backHandlerButton;

  /// Validate Text InputFiled
  InputFieldValidator? val;

  @override
  void initState() {
    super.initState();

    backHandlerButton = BackHandlerButton(context);

    val = InputFieldValidator(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () {
          if (backHandlerButton != null) {
            return backHandlerButton!.onWillPop();
          }

          return Future.value(false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: _buildLoginScreen(context),
        ),
      ),
    );
  }

  Widget _buildLoginScreen(BuildContext context) {
    return GetBuilder(
      builder: (LoginCont cont) {
        return Form(
          key: cont.formKey,
          child: Container(
            margin: const EdgeInsets.all(Sizes.size24),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.v72,
                  const Center(
                    child: Text(
                      '뉴비톡톡',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Sizes.size52,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gaps.v52,

                  /// Email Address Input
                  CommonText(
                    textContent: '이메일주소',
                    textColor: Colors.grey.shade500,
                    textSize: Sizes.size22,
                  ),
                  InputField(
                    controller: cont.emailController,
                    readOnly: false,
                    obscureText: false,
                    maxLines: 1,
                    validator: (value) => val!.emailValidation(value),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  Gaps.v28,

                  /// Password Input
                  CommonText(
                    textContent: '패스워드',
                    textColor: Colors.grey.shade500,
                    textSize: Sizes.size22,
                  ),
                  InputField(
                    controller: cont.pwdController,
                    readOnly: false,
                    obscureText: true,
                    maxLines: 1,
                    validator: (value) => val!.pwdValidation(value),
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                  ),
                  Gaps.v28,

                  /// Login Process
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: Sizes.size58,
                    margin: const EdgeInsets.only(
                      bottom: Sizes.size22,
                      top: Sizes.size48,
                    ),
                    child: CommonButton(
                      btnText: '로그인',
                      btnBackgroundColor: Colors.black,
                      textColor: Colors.white,
                      btnAction: () async {
                        var emailValue = cont.emailController.text;
                        var pwdValue = cont.pwdController.text;

                        if (!cont.formKey.currentState!.validate()) {
                          return;
                        }

                        bool success = await cont.loginWithEmail(
                          emailValue,
                          pwdValue,
                        );

                        if (!success) {
                          return;
                        } else {
                          GetRouter.main().off();
                        }
                      },
                    ),
                  ),

                  /// Navigate to SignUp Screen
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: Sizes.size58,
                    margin: const EdgeInsets.only(bottom: Sizes.size22),
                    child: CommonButton(
                      btnText: '회원 가입',
                      btnBackgroundColor: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      btnAction: () => GetRouter.signUp().to(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
