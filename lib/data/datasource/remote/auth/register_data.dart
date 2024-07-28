import 'package:my_project/core/class/crud.dart';
import 'package:my_project/core/constant/routes_name.dart';
import 'package:my_project/link_api.dart';

class RegisterData {
  Crud crud;
  RegisterData(this.crud);

  postData(String username, String email, String password, String c_password,
      String role) async {
    var response = await crud.postData(AppLink.register, {
      'name': username,
      'email': email,
      'password': password,
      'c_password': c_password,
      'role': role,
    });
    print('register data');
    return response.fold((l) => l, (r) => r);
  }
}
