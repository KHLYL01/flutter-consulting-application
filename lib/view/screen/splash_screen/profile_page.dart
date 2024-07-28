import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/expert_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/view/screen/splash_screen/time/add_time_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExpertControllerImp controller = Get.put(ExpertControllerImp());

    return Scaffold(
      appBar: AppBar(title: Text('Profile Page'.tr)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: GetBuilder<ExpertControllerImp>(builder: (controller) {
          String category = '\n';
          for (int i = 0; i < controller.expertCategory.length; i++) {
            category = '$category${controller.expertCategory[i].name}\n';
          }
          return HandlingDataView(
            statusRequest: controller.statusRequest!,
            widget: ListView(
              children: [
                // const PickImage(),
                Center(
                  child: ClipOval(
                    child: Material(
                      color: Colors.transparent,
                      child: Ink.image(
                        image: NetworkImage(controller.expertInfo.imagePath
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
                    controller.expertInfo.name,
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
                    controller.expertInfo.phone,
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
                      initialRating: controller.expertInfo.count_ratings == 0
                          ? 0
                          : (controller.expertInfo.sum_ratings /
                              controller.expertInfo.count_ratings),
                      itemBuilder: (BuildContext context, int index) =>
                          const Icon(Icons.star, color: Colors.amber),
                      onRatingUpdate: (double value) {},
                    ),
                    Text(
                      '(${controller.expertInfo.count_ratings})',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(const AddTimePage());
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50))),
                    // => Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (_) => const TimePage())),
                    child: Text(
                      'Add Time'.tr,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ListTile(
                  title: Text(
                    'Category'.tr,
                    style: TextStyle(color: Colors.blue.shade400, fontSize: 24),
                  ),
                  subtitle: Text(category),
                ),
                ListTile(
                  title: Text(
                    'About'.tr,
                    style: TextStyle(color: Colors.blue.shade400, fontSize: 24),
                  ),
                  subtitle: Text(controller.expertInfo.experience),
                ),
                const SizedBox(height: 70),
                ElevatedButton(
                  onPressed: () {
                    controller.getUnavailableTimes();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50))),
                  // => Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (_) => const TimePage())),
                  child: Text(
                    'Show booked appointments'.tr,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
