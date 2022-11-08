import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/create_route_controller.dart';

class CreateRouteView extends GetView<CreateRouteController> {
  const CreateRouteView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CreateRouteView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'CreateRouteView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
