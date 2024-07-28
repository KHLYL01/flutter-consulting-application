import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/splash_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/data/model/expert_model/expert_info_model.dart';
import 'package:my_project/data/model/expert_model/expert_page_model.dart';
import 'package:my_project/view/screen/splash_screen/expert_Info_page.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({Key? key}) : super(key: key);

  // List<ExpertInfoModel> favouriteExperts = [
  //   ExpertInfoModel(photo: '', id: '2', name: 'hamam2'),
  //   ExpertInfoModel(photo: '', id: '2', name: 'nour2'),
  //   ExpertInfoModel(photo: '', id: '2', name: 'mostafa2'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'khalil3'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'mhamad3'),
  //   ExpertInfoModel(photo: '', id: '3', name: 'ward3'),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Page'.tr),
        centerTitle: true,
      ),
      body: GetBuilder<SplashControllerImp>(
        builder: (controller) => HandlingDataView(
          statusRequest: controller.statusRequest!,
          widget: ListView.separated(
            itemCount: controller.favouriteExperts.length,
            itemBuilder: (context, index) {
              return product(
                controller.favouriteExperts[index].name,
                controller.favouriteExperts[index].imagePath,
                controller.favouriteExperts[index].id,
                controller.favouriteExperts[index],
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
        trailing: const Icon(
          Icons.favorite,
          color: Colors.red,
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
