import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/expert_controller.dart';
import 'package:my_project/controller/splash_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/data/model/expert_model/expert_page_model.dart';
import 'package:my_project/view/screen/auth/expert_page.dart';
import 'package:my_project/view/screen/splash_screen/time/add_time_page.dart';
import 'package:my_project/view/screen/splash_screen/time/availablet_time.dart';

import '../image/pick_image.dart';

class ExpertInfoPage extends StatelessWidget {
  final SplashControllerImp controllerSplash;
  final ExpertPageModel expertPageModel;
  const ExpertInfoPage(
      {Key? key, required this.controllerSplash, required this.expertPageModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${expertPageModel.name} ${'Page'.tr}')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: GetBuilder<ExpertControllerImp>(builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest!,
            widget: ListView(
              children: [
                Center(
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: NetworkImage(expertPageModel.imagePath
                            .replaceFirst('127.0.0.1', '10.0.2.2')),
                        fit: BoxFit.cover,
                        height: 128,
                        width: 128,
                        child: InkWell(
                          onTap: () {},
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Center(
                  child: Text(
                    expertPageModel.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue.shade300,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Center(
                  child: Text(
                    expertPageModel.phone,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: Colors.black54,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingBar.builder(
                      minRating: 1,
                      ignoreGestures: true,
                      allowHalfRating: true,
                      initialRating: expertPageModel.count_ratings == 0
                          ? 0
                          : (expertPageModel.sum_ratings /
                              expertPageModel.count_ratings),
                      itemBuilder: (BuildContext context, int index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (double value) {},
                    ),
                    Text(
                      '(${expertPageModel.count_ratings})',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('rate title'.tr),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'rate text'.tr,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(height: 32),
                              RatingBar.builder(
                                initialRating: 1,
                                minRating: 1,
                                itemBuilder: (BuildContext context,
                                        int index) =>
                                    const Icon(Icons.star, color: Colors.amber),
                                onRatingUpdate: (value) {
                                  controllerSplash.addRating(
                                      '${expertPageModel.id}',
                                      '${value.toInt()}');
                                },
                              )
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'OK'.tr,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    // => Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (_) => const TimePage())),
                    child: Text(
                      'add Rating'.tr,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      controllerSplash
                          .getAvailableTimes('${expertPageModel.id}');
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    // => Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (_) => const TimePage())),
                    child: Text(
                      'Book an appointment'.tr,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // ListTile(
                //   title: Text(
                //     'Category',
                //     style: TextStyle(color: Colors.blue.shade400, fontSize: 24),
                //   ),
                //   // subtitle: Text(category),
                // ),
                ListTile(
                  title: Text(
                    'About'.tr,
                    style: TextStyle(color: Colors.blue.shade400, fontSize: 24),
                    maxLines: 5,
                  ),
                  subtitle: Text(expertPageModel.experience),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
