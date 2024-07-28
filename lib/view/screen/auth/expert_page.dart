import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/expert_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/core/functions/validator_input.dart';
import 'package:my_project/view/screen/image/pick_image.dart';
import 'package:my_project/view/widget/text_divider.dart';
import 'package:my_project/view/widget/text_field_widget.dart';

class ExpertPage extends StatelessWidget {
  ExpertPage({Key? key}) : super(key: key);

  static const TextStyle optionStyle = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 18,
  );

  @override
  Widget build(BuildContext context) {
    ExpertControllerImp controller = Get.put(ExpertControllerImp());

    return Scaffold(
      // appBar: buildAppBarWithoutColor(context),
      body: GetBuilder<ExpertControllerImp>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest!,
          widget: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    const PickImage(),
                    const SizedBox(height: 20),
                    TextFieldWidget(
                      label: 'Username',
                      hint: 'Enter your name',
                      icon: Icons.account_circle_sharp,
                      controller: controller.name,
                      valid: (val) {
                        return validInput(val!, 6, 20, 'username');
                      },
                    ),
                    const SizedBox(height: 5),
                    const TextDivider(text: 'Contact Information'),
                    TextFieldWidget(
                      label: 'Phone number',
                      hint: 'Enter your number',
                      icon: Icons.phone,
                      controller: controller.phone,
                      valid: (val) {
                        return validInput(val!, 6, 20, 'phone');
                      },
                    ),
                    const SizedBox(height: 5),
                    TextFieldWidget(
                      label: 'Location',
                      hint: 'Enter your location',
                      icon: Icons.location_on,
                      controller: controller.address,
                      valid: (val) {
                        return validInput(val!, 0, 50, 'text');
                      },
                    ),
                    const SizedBox(height: 5),
                    const TextDivider(text: 'Categories'),
                    GetBuilder<ExpertControllerImp>(
                      builder: (controller) => DropdownButtonFormField<String>(
                          isExpanded: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(width: 3, color: Colors.blue),
                          )),
                          value: controller.selectedItem,
                          items: controller.items
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: optionStyle,
                                    ),
                                  ))
                              .toList(),
                          onChanged: (item) => controller.selectItem(item!)),
                    ),
                    const SizedBox(height: 5),
                    const TextDivider(text: 'About'),
                    TextFieldWidget(
                      label: '',
                      hint: 'Enter your experience',
                      icon: Icons.info,
                      controller: controller.experience,
                      valid: (val) {
                        return validInput(val!, 0, 200, 'text');
                      },
                    ),
                    Container(
                      height: 75,
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.addExpertData();
                          // Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(builder: (_) => const SplashPage()));
                        },
                        child: const Text('submit', style: optionStyle),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
