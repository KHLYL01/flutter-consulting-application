import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/expert_controller.dart';

class AppointmentBookingPage extends StatelessWidget {
  const AppointmentBookingPage({Key? key}) : super(key: key);

  static const TextStyle optionStyle = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment Booking Page'.tr),
      ),
      body: GetBuilder<ExpertControllerImp>(
        builder: (controller) => Padding(
          padding: EdgeInsets.all(8),
          child: ListView.separated(
            itemCount: controller.bookedAppointments.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                  '${'day'.tr} :${controller.bookedAppointments[index].day_id}\n   ${'start'.tr} :${controller.bookedAppointments[index].start}\n   ${'end'.tr} :${controller.bookedAppointments[index].end}'),
              subtitle: Text(
                  '${'cost'.tr} :${controller.bookedAppointments[index].cost}'),
            ),
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
}
