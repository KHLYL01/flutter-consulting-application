import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/splash_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/data/model/category_model.dart';
import 'package:my_project/view/screen/splash_screen/category_page.dart';
import 'package:my_project/view/widget/app_bar_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  List<CategoryModel> categories = [
    CategoryModel(name: 'medical'.tr, icon: Icons.medical_services, id: '1'),
    CategoryModel(
        name: 'occupational'.tr, icon: Icons.sensor_occupied, id: '2'),
    CategoryModel(name: 'psychological'.tr, icon: Icons.psychology, id: '3'),
    CategoryModel(name: 'family'.tr, icon: Icons.family_restroom, id: '4'),
    CategoryModel(
        name: 'business'.tr, icon: Icons.business_center_rounded, id: '5'),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashControllerImp>(
      builder: (controller) => HandlingDataRequest(
        statusRequest: controller.statusRequest!,
        widget: ListView.separated(
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            return product(categories[index].name, categories[index].icon,
                categories[index].id, controller);
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
    );
  }

  Widget product(
      String name, IconData icon, String id, SplashControllerImp controller) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        // shape: const StadiumBorder(
        //   side: BorderSide(
        //     color: Colors.blue,
        //     width: 2,
        //   ),
        // ),
        leading: Icon(icon, color: Colors.blue, size: 50),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontSize: 24,
          ),
        ),
        onTap: () {
          controller.getExpertsById(id);
        },
      ),
    );
  }
}
