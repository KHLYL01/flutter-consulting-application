import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_project/core/class/status_request.dart';
import 'package:my_project/core/constant/routes_name.dart';
import 'package:my_project/core/functions/handling_data.dart';
import 'package:my_project/core/services/services.dart';
import 'package:my_project/data/datasource/remote/auth/expert_data.dart';
import 'package:my_project/data/model/Time_model.dart';
import 'package:my_project/data/model/expert_model/expert_category.dart';
import 'package:my_project/data/model/expert_model/expert_page_model.dart';
import 'package:my_project/view/screen/splash_screen/time/Appointment_Booking_time_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

abstract class ExpertController extends GetxController {
  addExpertData();
  getExpertData();
  pickImage(ImageSource source);
  saveImagePermanent(String imagePath);
  addTime(DateTime newDateTime, String cost);
}

class ExpertControllerImp extends ExpertController {
  late File image;

  late ExpertPageModel expertInfo;
  List<ExpertCategoryModel> expertCategory = [];
  List<TimeModel> bookedAppointments = [];

  DateTime dateTime = DateTime.now();
  Rx<List<DateTime>> dateTimeList = Rx<List<DateTime>>([]);
  var itemCount = 0;

  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController name;
  late TextEditingController phone;
  late TextEditingController address;
  late TextEditingController experience;

  ExpertData expertData = ExpertData(Get.find());
  StatusRequest? statusRequest = StatusRequest.none;
  MyServices myServices = Get.find();

  List<String> items = [
    'medical',
    'occupational',
    'psychological',
    'family',
    'business',
  ];
  // 'medical,occupational',
  // 'medical,psychological',
  // 'medical,family',
  // 'medical,business',
  // 'occupational,psychological',
  // 'occupational,family',
  // 'occupational,business',
  // 'medical,occupational,psychological',
  // 'medical,occupational,family',
  // 'medical,occupational,business',
  // 'medical,psychological,family',
  // 'medical,psychological,business',
  // 'medical,family,business',
  // 'occupational,psychological,family',
  // 'occupational,psychological,business',
  // 'psychological,family,business',
  // 'medical,occupational,psychological,family',
  // 'medical,psychological,family,business',
  // 'occupational,psychological,family,business',
  // 'medical,occupational,psychological,family,business',
  String selectedItem = 'medical';

  selectItem(String item) {
    selectedItem = item;
    update();
  }

  selectTime(DateTime? newDate, TimeOfDay? newTime) {
    if (newDate == null) return;
    if (newTime == null) return;
    var newDateTime = DateTime(
      0,
      0,
      (newDate.day % 7) + 1,
      newTime.hour,
      newTime.minute,
    );
    addTime(newDateTime, '200');
    update();
  }

  @override
  addExpertData() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await expertData.addData(
          image!,
          name.text,
          phone.text,
          address.text,
          experience.text,
          '${items.indexOf(selectedItem, 0) + 1}');
      // '${items.indexOf(selectedItem, 0) + 1}'
      statusRequest = handlingData(response);
      print(statusRequest);
      if (statusRequest == StatusRequest.success) {
        myServices.sharedPreferences?.setString('step', '3');
        Get.offNamed(AppRoute.splashPage);
        print(response);
      } else {
        Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
        statusRequest = StatusRequest.failure;
        print(response);
      }
      update();
    } else {}
  }

  @override
  getExpertData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response1 = await expertData
        .getData('${myServices.sharedPreferences?.getString('user_id')}');
    var response2 = await expertData
        .getCategory('${myServices.sharedPreferences?.getString('user_id')}');
    statusRequest = handlingData(response1);
    print(statusRequest);
    statusRequest = handlingData(response2);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      expertInfo = ExpertPageModel.fromJson(response1);
      print(response1);
      expertCategory = response2;
      print(response2);
      Get.toNamed(AppRoute.profilePage);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response1);
    }
    update();
  }

  getUnavailableTimes() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await expertData.getUnavailableTimes(
        '${myServices.sharedPreferences?.getString('user_id')}');
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      bookedAppointments = response;
      Get.toNamed(AppRoute.appointmentBookingPage);
      print(response);
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  addTime(DateTime newDateTime, String cost) async {
    statusRequest = StatusRequest.loading;
    var response = await expertData.addTime(
        '${newDateTime.day}',
        '${newDateTime.hour}:${newDateTime.minute}',
        '${newDateTime.hour + 1}:${newDateTime.minute}',
        cost);
    statusRequest = handlingData(response);
    print(statusRequest);
    if (statusRequest == StatusRequest.success) {
      dateTimeList.value.add(newDateTime);
      itemCount++;
    } else {
      Get.defaultDialog(title: 'Warning', middleText: 'Try Again');
      statusRequest = StatusRequest.failure;
      print(response);
    }
    update();
  }

  @override
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      // final imageTemporary = File(image.path);
      final imageTemporary = await saveImagePermanent(image.path);

      this.image = imageTemporary;
      update();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Future<File> saveImagePermanent(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  void onInit() {
    phone = TextEditingController();
    address = TextEditingController();
    experience = TextEditingController();
    name = TextEditingController();
    image = File('assets/images/image1.jpg');
    expertInfo = ExpertPageModel.zero();
    super.onInit();
  }

  @override
  void dispose() {
    phone.dispose();
    address.dispose();
    experience.dispose();
    name.dispose();
    super.dispose();
  }
}
