import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/core/constant/color.dart';
import 'package:my_project/core/constant/image_asset.dart';
import 'package:my_project/core/constant/routes_name.dart';
import 'package:my_project/core/services/services.dart';
import 'package:my_project/data/datasource/static/static.dart';

class EntryPage extends StatelessWidget {
  EntryPage({Key? key}) : super(key: key);

  MyServices myServices = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(AppImageAsset.appImage),
                    const SizedBox(height: 50),
                    Text(
                      // 'Application Name',
                      '1'.tr,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '2'.tr,
                      // 'Description Application',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Theme.of(context).primaryColor,
                child: Center(
                  child: TextButton(
                    child: Text(
                      '3'.tr,
                      // 'Get Started',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      myServices.sharedPreferences?.setString('step', '1');
                      Get.offNamed(AppRoute.login);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
