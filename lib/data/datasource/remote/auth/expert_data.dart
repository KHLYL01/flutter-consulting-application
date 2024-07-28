import 'dart:io';

import 'package:my_project/core/class/crud.dart';
import 'package:my_project/link_api.dart';

class ExpertData {
  Crud crud;
  ExpertData(this.crud);

  addData(File image, String name, String phone, String address,
      String experience, String category_id) async {
    var response = await crud.addData(AppLink.expertAdd, name, phone, address,
        experience, category_id, image);
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  addTime(String day_id, String start, String end, String cost) async {
    var response =
        await crud.addTime(AppLink.expertAddTime, day_id, start, end, cost);
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  getUnavailableTimes(String id) async {
    var response = await crud.getTimes('${AppLink.expertUnavailableTimes}/$id');
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  getData(String id) async {
    var response = await crud.getData('${AppLink.expertGet}/$id');
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  getCategory(String id) async {
    var response = await crud.getCategory('${AppLink.expertCategory}/$id');
    print(response);
    return response.fold((l) => l, (r) => r);
  }
}
