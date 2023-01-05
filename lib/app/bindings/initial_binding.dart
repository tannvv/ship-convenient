import 'package:convenient_way/app/bindings/controller_binding.dart';
import 'package:convenient_way/app/bindings/local_bindings.dart';
import 'package:convenient_way/app/bindings/repository_bindings.dart';
import 'package:get/get.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    RepositoryBindings().dependencies();
    LocalBindings().dependencies();
    ControllerBindings().dependencies();
  }
}
