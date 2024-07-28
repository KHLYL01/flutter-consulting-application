import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/expert_controller.dart';
import 'package:my_project/controller/splash_controller.dart';
import 'package:my_project/core/localization/change_local.dart';
import 'package:my_project/core/services/services.dart';
import 'package:my_project/view/screen/splash_screen/home_page.dart';
import 'package:my_project/view/screen/splash_screen/search_delegate.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const TextStyle optionStyle = TextStyle(
    fontWeight: FontWeight.w300,
    color: Colors.black54,
    fontSize: 20,
  );
  @override
  Widget build(BuildContext context) {
    MyServices myServices = Get.find();
    LocalController langcontroller = Get.find();
    SplashControllerImp controller = Get.put(SplashControllerImp());
    ExpertControllerImp expertController = Get.put(ExpertControllerImp());
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: buildRowText(),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: HomePage(),
      drawerEdgeDragWidth: 200,
      drawer: Drawer(
        // backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: buildRowText(),
            ),
            if (myServices.sharedPreferences?.getString('role') != 'user')
              ListTile(
                onTap: () {
                  // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                  //   return const ProfilePage();
                  // }));
                  expertController.getExpertData();
                },
                title: buildText('Profile'.tr),
                leading: const Icon(
                  Icons.account_circle_sharp,
                  color: Colors.blue,
                ),
                minLeadingWidth: 10,
              ),
            ListTile(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                //   return FavouritePage();
                // }));
                controller.getFavorite();
              },
              title: buildText("Favourite".tr),
              leading: const Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              minLeadingWidth: 10,
            ),
            ListTile(
              onTap: () {
                Get.defaultDialog(
                    title: 'Choose language'.tr,
                    titleStyle: const TextStyle(color: Colors.blue),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            langcontroller.changeLanguage('ar');
                            Get.back();
                          },
                          child: Text(
                            'Arabic'.tr,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            langcontroller.changeLanguage('en');
                            Get.back();
                          },
                          child: Text(
                            'English'.tr,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ));
              },
              title: buildText("App Language".tr),
              leading: const Icon(
                Icons.language,
                // color: Colors.white,
              ),
              minLeadingWidth: 10,
            ),
            // ListTile(
            //   onTap: () {},
            //   title: buildText("App Theme"),
            //   leading: const Icon(
            //     Icons.bar_chart_sharp,
            //     // color: Colors.white,
            //   ),
            //   minLeadingWidth: 10,
            // ),
            const Divider(
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                controller.logout();
              },
              title: buildText("Logout".tr),
              leading: const Icon(
                Icons.logout,
              ),
              minLeadingWidth: 10,
            ),
          ],
        ),
      ),
    );
  }

  buildRowText() {
    return Row(
      children: const [
        Text(
          "MY",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Text(
          "APPLICATION",
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  buildText(String text) {
    return Text(
      text,
      style: optionStyle,
    );
  }
}
