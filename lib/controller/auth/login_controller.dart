import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/core/class/status_request.dart';
import 'package:my_project/core/constant/routes_name.dart';
import 'package:my_project/core/functions/handling_data.dart';
import 'package:my_project/core/services/services.dart';
import 'package:my_project/data/datasource/remote/auth/login_data.dart';

abstract class LoginController extends GetxController {
  login();
  goToRegister();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;

  bool isShowPassword = true;

  LoginData loginData = LoginData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  void showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  goToRegister() {
    Get.offNamed(AppRoute.register);
  }

  @override
  login() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postData(email.text, password.text);
      statusRequest = handlingData(response);
      print(statusRequest);
      if (statusRequest == StatusRequest.success) {
        if (response['access_token'].toString().isNotEmpty) {
          myServices.saveToken(response['access_token']);
          myServices.sharedPreferences
              ?.setString('user_id', '${response['user']['id']}');
          print(myServices.getToken());

          myServices.sharedPreferences?.getString('role') == 'user'
              ? {
                  myServices.sharedPreferences?.setString('step', '3'),
                  Get.offNamed(AppRoute.splashPage),
                }
              : {
                  myServices.sharedPreferences?.setString('step', '2'),
                  Get.offNamed(AppRoute.expertPage)
                };
        }
      } else {
        Get.defaultDialog(title: 'Warning', middleText: 'Email Not Correct');
        statusRequest = StatusRequest.failure;
        print(response);
      }
      update();
    } else {}
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
