import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/message_page_controller.dart';

class MessagePageView extends GetView<MessagePageController> {
  const MessagePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MessagePageView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MessagePageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
