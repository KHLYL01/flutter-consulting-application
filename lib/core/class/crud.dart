import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:my_project/core/class/status_request.dart';
import 'package:my_project/core/functions/check_internet.dart';
import 'package:http/http.dart' as http;
import 'package:my_project/core/services/services.dart';
import 'package:my_project/data/model/Time_model.dart';
import 'package:my_project/data/model/expert_model/expert_category.dart';
import 'package:my_project/data/model/expert_model/expert_page_model.dart';

class Crud {
  MyServices myServices = Get.find();

  Future<Either<StatusRequest, Map>> postData(String link, Map data) async {
    try {
      if (await checkInternet()) {
        var response = await http.post(Uri.parse(link), body: data);
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map body = jsonDecode(response.body);
          print('crud');
          return Right(body);
        } else {
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> addData(
      String link,
      String name,
      String phone,
      String address,
      String experience,
      String category_id,
      File image) async {
    try {
      if (await checkInternet()) {
        print('crud');
        var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
        // List<String> a1 = category_id.split(',');
        // for(int i = 0 ; i < a1.length ; i++){
        //     = 1;
        // }

        var request = http.MultipartRequest('POST', Uri.parse(link));
        request.fields.addAll({
          'name': name,
          'phone': phone,
          'address': address,
          'experience': experience,
          'category1_id': category_id,
        });

        request.files
            .add(await http.MultipartFile.fromPath('image', image.path));
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          // print(await response.stream.bytesToString());
          Map<String, dynamic> body =
              jsonDecode(await response.stream.bytesToString());
          return Right(body);
        } else {
          print(response.reasonPhrase);
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }

  Future<Either<StatusRequest, Map>> getData(String link) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var response = await http.get(Uri.parse(link), headers: headers);
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        return Right(body);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, List<ExpertCategoryModel>>> getCategory(
      String link) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var response = await http.get(Uri.parse(link), headers: headers);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<ExpertCategoryModel> data = body
            .map((dynamic info) {
              return ExpertCategoryModel.fromJson(info);
            })
            .cast<ExpertCategoryModel>()
            .toList();
        return Right(data);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, List<ExpertPageModel>>> getExpertsById(
      String link) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {
        'Authorization': 'Bearer ${myServices.getToken()}',
        "Connection": "Keep-Alive"
      };
      var response = await http.get(Uri.parse(link), headers: headers);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<ExpertPageModel> data = body
            .map((dynamic info) {
              return ExpertPageModel.fromJson(info);
            })
            .cast<ExpertPageModel>()
            .toList();
        return Right(data);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> addRating(
      String link, Map<String, String> body) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var response =
          await http.post(Uri.parse(link), headers: headers, body: body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return Right(body);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> addToFavourite(
      String link, Map<String, String> body) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var response =
          await http.post(Uri.parse(link), headers: headers, body: body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return Right(body);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, List<ExpertPageModel>>> getFavorite(
      String link) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var response = await http.get(Uri.parse(link), headers: headers);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<ExpertPageModel> data = body
            .map((dynamic info) {
              return ExpertPageModel.fromJson(info);
            })
            .cast<ExpertPageModel>()
            .toList();
        return Right(data);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> addTime(
      String link, String day_id, String start, String end, String cost) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var body = {
        'day_id': day_id,
        'start': start,
        'end': end,
        'cost': cost,
      };
      var response =
          await http.post(Uri.parse(link), headers: headers, body: body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return Right(body);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> payment(
      String link, Map<String, dynamic> body) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var response =
          await http.post(Uri.parse(link), headers: headers, body: body);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        return Right(body);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, List<TimeModel>>> getTimes(String link) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var response = await http.get(Uri.parse(link), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        print(body);
        List<TimeModel> data = body
            .map((dynamic info) {
              return TimeModel.fromJson(info);
            })
            .cast<TimeModel>()
            .toList();
        return Right(data);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, List<ExpertPageModel>>> searchExpert(
      String link, Map<String, dynamic> body) async {
    if (await checkInternet()) {
      print('crud');
      var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
      var response =
          await http.post(Uri.parse(link), headers: headers, body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        List<ExpertPageModel> data = body
            .map((dynamic info) {
              return ExpertPageModel.fromJson(info);
            })
            .cast<ExpertPageModel>()
            .toList();
        print(response);
        return Right(data);
      } else {
        print(response.reasonPhrase);
        return const Left(StatusRequest.serverFailure);
      }
    } else {
      return const Left(StatusRequest.offlineFailure);
    }
  }

  Future<Either<StatusRequest, Map>> logout(String link) async {
    try {
      if (await checkInternet()) {
        print('crud');
        var headers = {'Authorization': 'Bearer ${myServices.getToken()}'};
        var request = http.MultipartRequest('POST', Uri.parse(link));
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          // print(await response.stream.bytesToString());
          Map<String, dynamic> body =
              jsonDecode(await response.stream.bytesToString());
          return Right(body);
        } else {
          print(response.reasonPhrase);
          return const Left(StatusRequest.serverFailure);
        }
      } else {
        return const Left(StatusRequest.offlineFailure);
      }
    } catch (_) {
      return const Left(StatusRequest.serverException);
    }
  }
}
