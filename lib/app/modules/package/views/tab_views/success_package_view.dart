import 'package:convenient_way/app/core/utils/alert_quick_service.dart';
import 'package:convenient_way/app/modules/package/controllers/package_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessView extends GetView<PackageController> {
  const SuccessView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed:() => 
                QuickAlertService.showSuccess('Success!'),
                child: Text('Success')
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed:() => 
                QuickAlertService.showWarning('Warning!'),
                child: Text('Warning')
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed:() => 
                QuickAlertService.showError('Error!'),
                child: Text('Error')
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed:() => 
                QuickAlertService.showInfo('Info!'),
                child: Text('Info')
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed:() => 
                QuickAlertService.showConfirm('Confirm!'),
                child: Text('Confirm')
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed:() => 
                QuickAlertService.showLoading('Loading!'),
                child: Text('Loading')
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(onPressed:() => 
                QuickAlertService.showAlert('Alert!'),
                child: Text('Alert')
              ),
            ),
          ],
        ),
    );
  }
}
