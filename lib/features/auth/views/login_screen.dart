// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:newbee_talk/common/constants/gaps.dart';
import 'package:newbee_talk/common/constants/sizes.dart';
import 'package:newbee_talk/common/utils/app_snackbar.dart';
import 'package:newbee_talk/common/utils/back_handler_button.dart';
import 'package:newbee_talk/common/utils/common_button.dart';
import 'package:newbee_talk/common/utils/common_input_field.dart';
import 'package:newbee_talk/common/utils/common_text.dart';
import 'package:newbee_talk/common/utils/validator.dart';
import 'package:newbee_talk/features/auth/views/sign_up_screen.dart';
import 'package:newbee_talk/features/main/views/main_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// Text InputField Controller 객체 생성
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwdController = TextEditingController();

  /// Validate Text Input Field
  final _formKey = GlobalKey<FormState>();

  /// Initialize Supabase Console
  final _supabase = Supabase.instance.client;

  /// 뒤로가기 처리
  BackHandlerButton? backHandlerButton;

  /// Form Field Validation
  InputFieldValidator? val;

  @override
  void initState() {
    super.initState();

    backHandlerButton = BackHandlerButton(context: context);

    val = InputFieldValidator(context: context);
  }

  /// Login with Email Address on Supabase Server
  Future<bool> _loginWithEmail(String emailValue, String pwdValue) async {
    var success = false;

    final AuthResponse response = await _supabase.auth.signInWithPassword(
      email: emailValue,
      password: pwdValue,
    );

    if (response.user != null) {
      success = true;
    } else {
      success = false;
    }

    return success;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          if (backHandlerButton != null) {
            return backHandlerButton!.onWillPop();
          }

          return Future.value(false);
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: Form(
            key: _formKey,
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
                      controller: _emailController,
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
                      controller: _pwdController,
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
                          var emailValue = _emailController.text;
                          var pwdValue = _pwdController.text;

                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          bool success = await _loginWithEmail(
                            emailValue,
                            pwdValue,
                          );

                          if (!context.mounted) return;

                          if (!success) {
                            var snackBar = AppSnackbar(
                              context: context,
                              msg: '잘못된 회원 정보입니다!',
                            );

                            snackBar.showSnackbar(context);

                            return;
                          } else {
                            Navigator.popAndPushNamed(
                              context,
                              MainScreen.routeName,
                            );
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
                        btnAction: () {
                          Navigator.pushNamed(
                            context,
                            SignUpScreen.routeName,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
