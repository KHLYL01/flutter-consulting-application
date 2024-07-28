import 'package:my_project/core/class/crud.dart';
import 'package:my_project/link_api.dart';

class TestData {
  Crud crud;

  TestData(this.crud);

  getData() async {
    var response = await crud.postData(AppLink.baseAuth, {});
    return response.fold((l) => l, (r) => r);
  }
}
