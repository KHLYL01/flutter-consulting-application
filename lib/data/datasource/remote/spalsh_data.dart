import 'package:my_project/core/class/crud.dart';
import 'package:my_project/link_api.dart';
import 'package:my_project/view/screen/splash_screen.dart';

class SplashData {
  Crud crud;
  SplashData(this.crud);

  getExpertsById(String id) async {
    var response = await crud.getExpertsById('${AppLink.getExpertsById}/$id');
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  getAvailableTimes(String expert_id) async {
    var response =
        await crud.getTimes('${AppLink.expertAvailableTimes}/$expert_id');
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  payment(String expert_id, String time_id) async {
    var response = await crud
        .payment(AppLink.payment, {'expert_id': expert_id, 'time_id': time_id});
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  addRating(String expert_id, String value) async {
    var response = await crud
        .addRating(AppLink.addRating, {'expert_id': expert_id, 'value': value});
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  addToFavourite(String expert_id) async {
    var response = await crud
        .addToFavourite(AppLink.addToFavourite, {'expert_id': expert_id});
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  getFavorite() async {
    var response = await crud.getFavorite(AppLink.getFavorite);
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  searchExpert(String name) async {
    var response =
        await crud.searchExpert(AppLink.searchExpert, {'name': name});
    print(response);
    return response.fold((l) => l, (r) => r);
  }

  logout() async {
    var response = await crud.logout(AppLink.logout);
    return response.fold((l) => l, (r) => r);
  }
}
