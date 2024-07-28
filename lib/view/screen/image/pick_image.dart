import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/expert_controller.dart';
import 'package:my_project/view/widget/profile_widget.dart';

class PickImage extends StatelessWidget {
  const PickImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PickImageControllerImp controller = Get.put(PickImageControllerImp());
    ExpertControllerImp controller = Get.find();
    return GetBuilder<ExpertControllerImp>(
      builder: (controller) => ProfileWidget(
        // image: controller.image!,
        image: controller.image != null
            ? controller.image!
            : File('assets/images/image1.jpg'),
        onClicked: (source) => controller.pickImage(source),
        icon: Icons.add_a_photo,
      ),
    );
  }
}
