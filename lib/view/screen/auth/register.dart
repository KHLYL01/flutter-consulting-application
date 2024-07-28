import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/register_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/core/class/status_request.dart';
import 'package:my_project/core/functions/validator_input.dart';
import 'package:my_project/view/widget/app_bar_widget.dart';
import 'package:my_project/view/widget/text_field_widget.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterControllerImp controller = Get.put(RegisterControllerImp());
    return Scaffold(
      appBar: buildAppBarWithoutColor(context),
      body: GetBuilder<RegisterControllerImp>(
        builder: (controller) => HandlingDataRequest(
          statusRequest: controller.statusRequest!,
          widget: SafeArea(
            child: Form(
              key: controller.formState,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 30),
                  const Center(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFieldWidget(
                    label: 'User Name',
                    hint: 'Enter you name',
                    icon: Icons.account_circle,
                    controller: controller.username,
                    valid: (val) {
                      return validInput(val!, 4, 30, 'username');
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFieldWidget(
                    label: 'Email',
                    hint: 'Enter you email',
                    icon: Icons.account_circle,
                    controller: controller.email,
                    valid: (val) {
                      return validInput(val!, 4, 30, 'email');
                    },
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<RegisterControllerImp>(
                    builder: (controller) => TextFieldWidget(
                      label: 'Password',
                      hint: "Enter password",
                      icon: Icons.lock,
                      controller: controller.password,
                      valid: (val) {
                        return validInput(val!, 8, 20, 'password');
                      },
                      obscureText: controller.isShowPassword,
                      onTapIcon: () {
                        controller.showPassword();
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<RegisterControllerImp>(
                    builder: (controller) => TextFieldWidget(
                      label: 'accept Password',
                      hint: "Enter password",
                      icon: Icons.lock,
                      controller: controller.c_password,
                      valid: (val) {
                        return validInput(val!, 8, 20, 'password');
                      },
                      obscureText: controller.isShowPassword,
                      onTapIcon: () {
                        controller.showPassword();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(
                      "Register as",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.register('user');
                          },
                          style: ElevatedButton.styleFrom(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'User',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.register('expert');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Text(
                              'Expert',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.5,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      controller.goToLogin();
                    },
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'already have an account? ',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(
                              text: ' Login',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
