import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/splash_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/core/services/services.dart';
import 'package:my_project/data/model/expert_model/expert_info_model.dart';
import 'package:my_project/data/model/expert_model/expert_page_model.dart';
import 'package:my_project/view/screen/auth/expert_page.dart';
import 'package:my_project/view/screen/splash_screen/expert_Info_page.dart';
import 'package:my_project/view/screen/splash_screen/profile_page.dart';

class CategoryPage extends StatelessWidget {
  // final String id;
  CategoryPage({Key? key}) : super(key: key);

  // List<ExpertInfoModel> experts = [
  //   ExpertInfoModel(photo: '', id: '1', name: 'khalil1'),
  //   ExpertInfoModel(photo: '', id: '1', name: 'mhamad1'),
  //   ExpertInfoModel(photo: '', id: '1', name: 'ward1'),
  //   ExpertInfoModel(photo: '', id: '1', name: 'hamam1'),
  //   ExpertInfoModel(photo: '', id: '1', name: 'nour1'),
  //   ExpertInfoModel(photo: '', id: '1', name: 'mostafa1'),
  //   ExpertInfoModel(photo: '', id: '2', name: 'khalil2'),
  //   ExpertInfoModel(photo: '', id: '2', name: 'mhamad2'),
  //   ExpertInfoModel(photo: '', id: '2', name: 'ward2'),
  //   ExpertInfoModel(photo: '', id: '2', name: 'hamam2'),
  //   ExpertInfoModel(photo: '', id: '2', name: 'nour2'),
  //   ExpertInfoModel(photo: '', id: '2', name: 'mostafa2'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'khalil3'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'mhamad3'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'ward3'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'hamam3'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'nour3'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'mostafa3'),
  //   ExpertInfoModel(photo: '', id: '4', name: 'khalil4'),
  //   ExpertInfoModel(photo: '', id: '4', name: 'mhamad4'),
  //   ExpertInfoModel(photo: '', id: '4', name: 'ward4'),
  //   ExpertInfoModel(photo: '', id: '4', name: 'hamam4'),
  //   ExpertInfoModel(photo: '', id: '4', name: 'nour4'),
  //   ExpertInfoModel(photo: '', id: '4', name: 'mostafa4'),
  //   ExpertInfoModel(photo: '', id: '5', name: 'khalil5'),
  //   ExpertInfoModel(photo: '', id: '5', name: 'mhamad5'),
  //   ExpertInfoModel(photo: '', id: '5', name: 'ward5'),
  //   ExpertInfoModel(photo: '', id: '5', name: 'hamam5'),
  //   ExpertInfoModel(photo: '', id: '5', name: 'nour5'),
  //   ExpertInfoModel(photo: '', id: '5', name: 'mostafa5'),
  // ];
  Map<String, String> title = {
    '1': 'Medical Page'.tr,
    '2': 'Occupational Page'.tr,
    '3': 'Psychological Page'.tr,
    '4': 'Family Page'.tr,
    '5': 'Business Page'.tr,
  };
  Map<String, IconData> icons = {
    '1': Icons.medical_services,
    '2': Icons.sensor_occupied,
    '3': Icons.psychology,
    '4': Icons.family_restroom,
    '5': Icons.business_center_rounded,
  };

  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${title[myServices.sharedPreferences?.getString('category_id')]}',
        ),
        actions: [
          Icon(
            icons[myServices.sharedPreferences?.getString('category_id')],
            size: 50,
          ),
          const Icon(null),
        ],
      ),
      body: GetBuilder<SplashControllerImp>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest!,
          widget: ListView.separated(
            itemCount: controller.experts.length,
            itemBuilder: (context, index) {
              return product(
                controller.experts[index].name,
                controller.experts[index].imagePath,
                controller.experts[index].id,
                controller.experts[index],
                controller,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 10,
                color: Colors.black54,
                indent: 25,
              );
            },
          ),
        ),
      ),
    );
  }

  // , String id
  Widget product(String name, String imagePath, int id,
      ExpertPageModel expertPageModel, SplashControllerImp controller) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        // shape: const StadiumBorder(
        //   side: BorderSide(
        //     color: Colors.blue,
        //     width: 2,
        //   ),
        // ),
        // leading: Icon(Icons.account_circle_sharp, color: Colors.blue, size: 50),
        leading: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image:
                  NetworkImage(imagePath.replaceFirst('127.0.0.1', '10.0.2.2')),
              fit: BoxFit.cover,
              height: 64,
              width: 64,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ),
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.favorite,
            color: controller.color,
          ),
          onPressed: () {
            controller.addToFavourite('$id');
          },
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        onTap: () {
          Get.to(ExpertInfoPage(
              controllerSplash: controller, expertPageModel: expertPageModel));
        },
      ),
    );
  }
}
