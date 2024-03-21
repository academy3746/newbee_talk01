import 'package:flutter/material.dart';

class InputFieldValidator {
  final BuildContext context;

  InputFieldValidator({required this.context});

  /// 닉네임 검증
  dynamic nameValidation(value) {
    if (value.isEmpty) {
      return '닉네임을 입력해 주세요!';
    }

    return null;
  }

  /// 이메일 검증
  dynamic emailValidation(value) {
    if (value.isEmpty) {
      return '이메일을 입력해 주세요!';
    }

    return null;
  }

  /// 패스워드 검증
  dynamic pwdValidation(value) {
    if (value.isEmpty) {
      return '패스워드를 입력해 주세요!';
    }

    return null;
  }

  /// 패스워드 확인 검증
  dynamic confirmValidation(value) {
    if (value.isEmpty) {
      return '패스워드 재확인 필드를 입력해 주세요!';
    }

    return null;
  }

  /// 자기소개 검증
  dynamic introValidation(value) {
    if (value.isEmpty) {
      return '자기소개를 입력해 주세요!';
    }

    return null;
  }
}