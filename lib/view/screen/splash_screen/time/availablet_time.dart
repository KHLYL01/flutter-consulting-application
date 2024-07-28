import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/expert_controller.dart';
import 'package:my_project/controller/splash_controller.dart';

class AvailableTimePage extends StatelessWidget {
  const AvailableTimePage({Key? key}) : super(key: key);

  static const TextStyle optionStyle = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Time Page'.tr),
      ),
      body: GetBuilder<SplashControllerImp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.all(8),
          child: ListView.separated(
            itemCount: controller.availableTimes.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                  '${'day'.tr} :${controller.availableTimes[index].day_id}\n   ${'start'.tr} :${controller.availableTimes[index].start}\n   ${'end'.tr} :${controller.availableTimes[index].end}'),
              subtitle: Text(
                  '${'cost'.tr} :${controller.availableTimes[index].cost}'),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                ),
                onPressed: () {
                  controller.payment('${controller.availableTimes[index].id}');
                },
                child: Text('booked'.tr),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 10,
                color: Colors.black54,
                indent: 15,
              );
            },
          ),
        ),
      ),
    );
  }
}
