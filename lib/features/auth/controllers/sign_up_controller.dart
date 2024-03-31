import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/utils/app_snackbar.dart';
import 'package:newbee_talk/common/utils/image_uploader.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpCont extends GetxController {
  static SignUpCont get to => Get.find<SignUpCont>();

  /// Initialize Supabase Auth Client
  final _supabase = Supabase.instance.client;

  /// 유저 프로필 이미지
  final _profileImg = Rx<File?>(null);

  /// 이미지 URL 주소
  final _imageUrl = Rx<String?>(null);

  /// 이름 입력필드
  final _nameController = TextEditingController().obs;

  /// 이메일 입력필드
  final _emailController = TextEditingController().obs;

  /// 패스워드 입력필드
  final _pwdController = TextEditingController().obs;

  /// 패스워드 재확인 입력필드
  final _confirmController = TextEditingController().obs;

  /// 자기소개 입력필드
  final _introController = TextEditingController().obs;

  /// 텍스트 입력필드 검증
  final _formKey = GlobalKey<FormState>().obs;

  /// 이미지 파일 업로드
  late ImageUploader uploader;

  /// Initialize Image Uploader Widget
  void initImageUploader(BuildContext context) {
    uploader = ImageUploader(
      context: context,
      imgFile: _profileImg.value,
      onImageUploaded: onImageUploaded,
    );
  }

  /// Image Uploader Callback
  void onImageUploaded(File? file) {
    _profileImg(file);
  }

  /// Signup With Email Address
  Future<bool> signUpWithEmail(String emailValue, String pwdValue) async {
    var success = false;

    var res = await _supabase.auth.signUp(
      email: emailValue,
      password: pwdValue,
    );

    if (res.user != null) {
      success = true;

      if (_profileImg.value != null) {
        var now = DateTime.now();

        var path = 'profiles/${res.user!.id}_$now.jpg';

        final uploadImage = _profileImg.value;

        final uploadUrl =
            _supabase.storage.from('food_pick').getPublicUrl(path);

        await _supabase.storage.from('food_pick').upload(
              path,
              uploadImage!,
              fileOptions: const FileOptions(upsert: true),
            );

        _imageUrl(uploadUrl);
      }

      await _supabase.from('member').insert(
            MemberModel(
              name: nameController.text,
              email: emailController.text,
              introduce: introController.text,
              uid: res.user!.id,
              profileUrl: _imageUrl.value,
            ).toMap(),
          );
    } else {
      var msg = '올바른 양식을 제출해 주세요!';

      var snackbar = AppSnackbar(msg: msg);

      snackbar.showSnackbar(Get.context!);

      success = false;
    }

    return success;
  }

  File? get profileImg => _profileImg.value;

  String? get imageUrl => _imageUrl.value;

  TextEditingController get nameController => _nameController.value;

  TextEditingController get emailController => _emailController.value;

  TextEditingController get pwdController => _pwdController.value;

  TextEditingController get confirmController => _confirmController.value;

  TextEditingController get introController => _introController.value;

  GlobalKey<FormState> get formKey => _formKey.value;
}
