import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/auth/login_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/core/functions/validator_input.dart';
import 'package:my_project/view/widget/app_bar_widget.dart';
import 'package:my_project/view/widget/text_field_widget.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());

    return Scaffold(
      appBar: buildAppBarWithoutColor(context),
      body: GetBuilder<LoginControllerImp>(
          builder: (controller) => HandlingDataRequest(
                statusRequest: controller.statusRequest!,
                widget: SafeArea(
                  child: Form(
                    key: controller.formState,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 50),
                        const SizedBox(height: 75),
                        const Center(
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFieldWidget(
                          label: 'Email',
                          hint: 'Enter you email',
                          icon: Icons.account_circle,
                          controller: controller.email,
                          valid: (val) {
                            return validInput(val!, 8, 30, 'email');
                          },
                        ),
                        const SizedBox(height: 10),
                        GetBuilder<LoginControllerImp>(
                          builder: (controller) => TextFieldWidget(
                            label: 'Password',
                            hint: "Enter password",
                            icon: Icons.lock,
                            obscureText: controller.isShowPassword,
                            onTapIcon: () {
                              controller.showPassword();
                            },
                            controller: controller.password,
                            valid: (val) {
                              return validInput(val!, 8, 20, 'password');
                            },
                          ),
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  controller.login();
                                  print('login');
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
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            controller.goToRegister();
                          },
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: 'Create new account? ',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Sign up',
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
              )),
    );
  }
}
