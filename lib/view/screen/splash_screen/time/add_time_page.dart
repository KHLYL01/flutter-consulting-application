import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/expert_controller.dart';

class AddTimePage extends StatelessWidget {
  const AddTimePage({Key? key}) : super(key: key);

  static const TextStyle optionStyle = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Time Page'.tr),
      ),
      body: GetBuilder<ExpertControllerImp>(
        builder: (controller) => Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(
                    context: context,
                    initialDate: controller.dateTime,
                    firstDate: DateTime(2023, 1, 7),
                    lastDate: DateTime(2023, 1, 13),
                  );
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay(
                        hour: controller.dateTime.hour,
                        minute: controller.dateTime.minute),
                  );
                  controller.selectTime(newDate, newTime);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50))),
                // => Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (_) => const TimePage())),
                child: Text(
                  'add time'.tr,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.itemCount,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(
                        '${controller.dateTimeList.value[index].hour}:${controller.dateTimeList.value[index].minute}'),
                    subtitle: Text(
                        '${'day'.tr}:${controller.dateTimeList.value[index].day}'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
