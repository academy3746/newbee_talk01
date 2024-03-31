import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/features/main/widgets/chat.dart';
import 'package:newbee_talk/features/main/widgets/index.dart';
import 'package:newbee_talk/features/main/widgets/user_info.dart';

class MainCont extends GetxController {
  static MainCont get to => Get.find<MainCont>();

  /// Selected Index No.
  final _screenIndex = 0.obs;

  /// Index Screen Footer
  final List<Widget> _screens = [
    const IndexScreen(),
    const ChatScreen(),
    const InfoScreen(),
  ];

  /// Switch Bottom Navigation Bar
  void bottomOnTap(int index) {
    _screenIndex(index);
  }

  int get screenIndex => _screenIndex.value;

  List<Widget> get screens => _screens;
}