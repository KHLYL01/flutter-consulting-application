import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/bindings/initial_bingings.dart';
import 'package:my_project/core/constant/color.dart';
import 'package:my_project/core/localization/change_local.dart';
import 'package:my_project/core/localization/translation.dart';
import 'package:my_project/core/services/services.dart';
import 'package:my_project/routes.dart';
import 'package:my_project/view/screen/entry_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LocalController controller = Get.put(LocalController());
    return GetMaterialApp(
      translations: MyTranslation(),
      locale: controller.language,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
          headline1: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          bodyText1: TextStyle(
            height: 2,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColor.gray,
          ),
        ),
        // fontFamily: 'PlayfairDisplay',
        primarySwatch: Colors.blue,
      ),
      // home: EntryPage(),
      // routes: routes,
      getPages: routes,
      initialBinding: InitialBindings(),
    );
  }
}
