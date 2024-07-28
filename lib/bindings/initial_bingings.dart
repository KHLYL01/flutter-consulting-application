import 'package:get/get.dart';
import 'package:my_project/controller/auth/login_controller.dart';
import 'package:my_project/controller/auth/register_controller.dart';
import 'package:my_project/core/class/crud.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
  }
}
