import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_project/controller/splash_controller.dart';
import 'package:my_project/core/class/handling_data_view.dart';
import 'package:my_project/data/model/expert_model/expert_page_model.dart';
import 'package:my_project/view/screen/splash_screen/expert_Info_page.dart';

class MySearchDelegate extends SearchDelegate {
  SplashControllerImp controller = Get.find();
  // List<String> searchResults = [
  //   //   'item1',
  //   //   'ite2',
  //   //   'it3',
  //   //   'i4',
  //   //   'i5',
  // ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
            // Get.to(SplashPage());
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    SplashControllerImp controller = Get.find();
    // Future.delayed(Duration.zero, () async {
    //
    // });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.searchExpert(query);
      // Add Your Code here.
    });
    if (controller.experts.isEmpty) {
      return Container();
    }
    return GetBuilder<SplashControllerImp>(
      builder: (controller) => HandlingDataRequest(
        statusRequest: controller.statusRequest!,
        widget: ListView.builder(
          itemCount: controller.searchExperts.length,
          itemBuilder: (context, index) {
            return product(
              controller.searchExperts[index].name,
              controller.searchExperts[index].imagePath,
              controller.searchExperts[index].id,
              controller.searchExperts[index],
              controller,
            );
          },
        ),
      ),
    );
    //   Center(
    //   child: Text(
    //     query,
    //     style: const TextStyle(
    //       fontSize: 64,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    SplashControllerImp controller = Get.find();
    // List<String> suggestions = searchResults.where((searchResult) {
    //   final result = searchResult.toLowerCase();
    //   final input = query.toLowerCase();
    //   return result.contains(input);
    // }).toList();
    // return ListView.builder(
    //   itemCount: suggestions.length,
    //   itemBuilder: (context, index) {
    //     final suggestion = suggestions[index];
    //     return ListTile(
    //       title: Text(suggestion),
    //       onTap: () {
    //         query = suggestion;
    //         showResults(context);
    //       },
    //     );
    //   },
    // );
    if (controller.experts.isEmpty) {
      return Container();
    }
    return ListView.builder(
      itemCount: controller.experts.length,
      itemBuilder: (context, index) {
        return product(
          controller.experts[index].name,
          controller.experts[index].imagePath,
          controller.experts[index].id,
          controller.experts[index],
          controller,
        );
      },
    );
  }

  Widget product(String name, String imagePath, int id,
      ExpertPageModel expertPageModel, SplashControllerImp controller) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipOval(
          child: Material(
            color: Colors.transparent,
            child: Ink.image(
              image:
                  NetworkImage(imagePath.replaceFirst('127.0.0.1', '10.0.2.2')),
              fit: BoxFit.cover,
              height: 64,
              width: 64,
              child: InkWell(
                onTap: () {},
              ),
            ),
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
        title: Text(
          name,
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            color: Colors.black54,
            fontSize: 24,
          ),
        ),
        onTap: () {
          Get.to(ExpertInfoPage(
              controllerSplash: controller, expertPageModel: expertPageModel));
        },
      ),
    );
  }
}
