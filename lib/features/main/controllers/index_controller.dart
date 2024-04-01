import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newbee_talk/common/utils/supabase_service.dart';
import 'package:newbee_talk/features/auth/models/member.dart';
import 'package:newbee_talk/get_router.dart';

class IndexCont extends GetxController {
  static IndexCont get to => Get.find<IndexCont>();

  /// Index Screen Scroll Controller
  final _indexController = ScrollController().obs;

  /// Loading Status
  final _loading = false.obs;

  /// User Data List
  final _data = Rx<List<MemberModel>?>(null);

  @override
  void onInit() {
    super.onInit();

    fetchMore();

    indexController.addListener(
      () {
        if (indexController.position.pixels ==
                indexController.position.maxScrollExtent &&
            !loading) {
          fetchMore();
        }
      },
    );
  }

  /// Make current screen scrollable infinitely
  Future<void> fetchMore() async {
    if (loading) return;

    _loading(true);

    try {
      var newData = await SupabaseService().fetchChatProfiles();

      if (newData.isNotEmpty) {
        _data.update(
          (val) {
            val?.addAll(newData);
          },
        );
      }
    } catch (error) {
      throw error.toString();
    } finally {
      _loading(false);
    }
  }

  /// Encounter 1:1 Chat Room (onGenerating)
  Future<void> enterChatRoom(String otherUid, MemberModel userModel) async {
    var chatRoomModel = await SupabaseService().fetchOrInsertChatRoom(
      otherUid,
    );

    GetRouter.chat().to(
      args: (
        chatRoomModel,
        userModel,
      ),
    );
  }

  ScrollController get indexController => _indexController.value;

  bool get loading => _loading.value;

  List<MemberModel>? get data => _data.value;
}
