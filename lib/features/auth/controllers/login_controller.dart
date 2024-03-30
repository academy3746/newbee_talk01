import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/utils/app_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginCont extends GetxController {
  static LoginCont get to => Get.find<LoginCont>();

  /// Initialize Supabase Auth Client
  final _supabase = Supabase.instance.client;

  /// Email (ID) 입력필드
  final _emailController = TextEditingController().obs;

  /// Password 입력필드
  final _pwdController = TextEditingController().obs;

  /// 텍스트 입력필드 검증
  final _formKey = GlobalKey<FormState>().obs;

  /// Login with Email ID
  Future<bool> loginWithEmail(String emailValue, String pwdValue) async {
    var success = false;

    var response = await _supabase.auth.signInWithPassword(
      email: emailValue,
      password: pwdValue,
    );

    var appSnackbar = AppSnackbar(
      msg: '잘못된 로그인 절차입니다!',
    );

    if (response.user != null) {
      success = true;
    } else {
      if (Get.context != null) {
        appSnackbar.showSnackbar(Get.context!);
      }

      success = false;
    }

    return success;
  }

  TextEditingController get emailController => _emailController.value;

  TextEditingController get pwdController => _pwdController.value;

  GlobalKey<FormState> get formKey => _formKey.value;
}
