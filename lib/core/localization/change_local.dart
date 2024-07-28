import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/core/services/services.dart';

class LocalController extends GetxController {
  Locale? language;

  MyServices myServices = Get.find();

  changeLanguage(String langCode) {
    Locale locale = Locale(langCode);
    myServices.sharedPreferences?.setString('language', langCode);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? langShared = MyServices().sharedPreferences?.getString('language');
    if (langShared == 'ar') {
      language = const Locale('ar');
    } else if (langShared == 'en') {
      language = const Locale('en');
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
    }
    super.onInit();
  }
}
