import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/core/constant/routes_name.dart';
import 'package:my_project/core/services/services.dart';

class MyMiddleware extends GetMiddleware {
  int? get priority => 0;
  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (myServices.sharedPreferences?.getString('step') == '3') {
      return const RouteSettings(name: AppRoute.splashPage);
    }
    if (myServices.sharedPreferences?.getString('step') == '2') {
      return const RouteSettings(name: AppRoute.expertPage);
    }
    if (myServices.sharedPreferences?.getString('step') == '1') {
      return const RouteSettings(name: AppRoute.login);
    }
  }
}
