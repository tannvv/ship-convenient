import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_page_controller.dart';

class ProfilePageView extends GetView<ProfilePageController> {
  const ProfilePageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ProfilePageView'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                controller.gotoTransactions();
              },
              child: const Text('Transaction'))
        ],
      ),
    );
  }
}
