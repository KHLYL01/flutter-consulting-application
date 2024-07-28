import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/core/class/status_request.dart';
import 'package:my_project/core/constant/routes_name.dart';
import 'package:my_project/core/functions/handling_data.dart';
import 'package:my_project/core/services/services.dart';
import 'package:my_project/data/datasource/remote/auth/login_data.dart';
import 'package:my_project/data/datasource/remote/spalsh_data.dart';
import 'package:my_project/data/model/Time_model.dart';
import 'package:my_project/data/model/expert_model/expert_page_model.dart';
import 'package:my_project/view/screen/splash_screen/favourite_page.dart';

abstract class SplashController extends GetxController {
  logout();
  getExpertsById(String id);
  addToFavourite(String id);
  getFavorite();
  searchExpert(String name);
  getAvailableTimes(String expert_id);
  payment(String time_id);
}

class SplashControllerImp extends SplashController {
  List<ExpertPageModel> experts = [];
  List<ExpertPageModel> favouriteExperts = [];
  List<ExpertPageModel> searchExperts = [];
  List<TimeModel> availableTimes = [];

  SplashData splashData = SplashData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  late Color color;

  @override
  getExpertsById(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await splashData.getExpertsById(id);
    // var response2 = await splashData
    //     .getCategory('${myServices.sharedPreferences?.getString('user_id')}');
    statusRequest = handlingData(response);
    print(statusRequest);
    // statusRequest = handlingData(response2);
    // print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      myServices.sharedPreferences?.setString("category_id", id);
      experts = response;
      print(response);
      // expertCategory = response2;
      // print(response2);
      Get.toNamed(AppRoute.categoryPage);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  addRating(String expert_id, String value) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await splashData.addRating(expert_id, value);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      print(response);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  addToFavourite(String id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await splashData.addToFavourite(id);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      color = Colors.red;
      update();
      print(response);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  getFavorite() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await splashData.getFavorite();
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      favouriteExperts = response;
      print(response);
      Get.toNamed(AppRoute.favouritePage);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  getAvailableTimes(String expert_id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await splashData.getAvailableTimes(expert_id);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      myServices.sharedPreferences?.setString('expertTime_id', expert_id);
      availableTimes = response;
      print(response);
      Get.toNamed(AppRoute.availableTime);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  payment(String time_id) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await splashData.payment(
        '${myServices.sharedPreferences?.getString('expertTime_id')}', time_id);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      print(response);
      Get.back();
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  searchExpert(String name) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await splashData.searchExpert(name);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      searchExperts = response;
      update();
      if (searchExperts.length == 0) {
        Get.defaultDialog(title: 'Warning', middleText: 'Expert not found');
      }
      print(response);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  logout() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await splashData.logout();
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      myServices.sharedPreferences!.setString('step', '1');
      Get.offAllNamed(AppRoute.login);
      print(response);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Email Already Exist');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  void onInit() {
    color = Colors.grey;
    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    color = Colors.grey;
    super.dispose();
  }
}
