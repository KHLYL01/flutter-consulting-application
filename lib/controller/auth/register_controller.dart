import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:my_project/core/class/status_request.dart';
import 'package:my_project/core/constant/routes_name.dart';
import 'package:my_project/core/functions/handling_data.dart';
import 'package:my_project/core/services/services.dart';
import 'package:my_project/data/datasource/remote/auth/register_data.dart';

abstract class RegisterController extends GetxController {
  register(String role);
  goToLogin();
}

class RegisterControllerImp extends RegisterController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  MyServices myServices = Get.find();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController c_password;

  bool isShowPassword = true;

  RegisterData registerData = RegisterData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;

  void showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  goToLogin() {
    Get.offNamed(AppRoute.login);
  }

  @override
  register(String role) async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await registerData.postData(
          username.text, email.text, password.text, c_password.text, role);
      statusRequest = handlingData(response);
      print(statusRequest);
      if (statusRequest == StatusRequest.success) {
        if (response['message'] == 'User successfully registered') {
          myServices.sharedPreferences!.setString('name', username.text);
          myServices.sharedPreferences?.setString('role', role);
          Get.offNamed(AppRoute.login);
          print(response);
        }
      } else {
        Get.defaultDialog(title: 'Warning', middleText: 'Email Already Exist');
        statusRequest = StatusRequest.failure;
        print(response);
      }
      update();
    } else {}
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    c_password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    c_password.dispose();
    super.dispose();
  }
}
