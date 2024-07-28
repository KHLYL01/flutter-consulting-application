import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (type == 'username') {
    if (!GetUtils.isUsername(val)) {
      return 'not valid username';
    }
  }
  if (type == 'email') {
    if (!GetUtils.isEmail(val)) {
      return 'not valid email';
    }
  }

  if (val.isEmpty) {
    return 'con\'t be empty value';
  }
  if (val.length < min) {
    return 'con\'t be less than $min';
  }
  if (val.length > max) {
    return 'con\'t be greater than $max';
  }
}
