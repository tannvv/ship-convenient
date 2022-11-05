import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notify_page_controller.dart';

class NotifyPageView extends GetView<NotifyPageController> {
  const NotifyPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NotifyPageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotifyPageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
