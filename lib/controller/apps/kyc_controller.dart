import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yamazone/controller/my_controller.dart';
import 'package:yamazone/models/chat.dart';

class KYCController extends MyController {
  List<Chat> chat = [];

  TextEditingController messageController = TextEditingController();
  RxInt selectedTab = 0.obs;

  void sendMessage() {
    chat.add(
      Chat(-1, "", "", DateTime.now(), messageController.text, "", true),
    );
    messageController.clear();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    Chat.dummyList.then((value) {
      chat = value.sublist(0, 10);
      update();
    });
  }
}
