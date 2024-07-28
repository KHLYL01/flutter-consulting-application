import 'dart:io';

class ExpertPageModel {
  final int id;
  final String name;
  final String phone;
  final String address;
  final String experience;
  final int sum_ratings;
  final int count_ratings;
  // final String category;
  final String imagePath;+

  ExpertPageModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.experience,
    required this.count_ratings,
    required this.sum_ratings,
    // required this.category,
    required this.imagePath,
  });

  factory ExpertPageModel.zero() {
    return ExpertPageModel(
      id: 0,
      name: '',
      phone: '',
      address: '',
      experience: '',
      // category: '',
      imagePath: '',
      count_ratings: 0,
      sum_ratings: 0,
    );
  }

  factory ExpertPageModel.fromJson(Map<String, dynamic> json) {
    return ExpertPageModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      experience: json['experience'],
      count_ratings: json['count_ratings'],
      sum_ratings: json['sum_ratings'],
      // category: json['category'],
      imagePath: json['image'],
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'phone': phone,
  //     'address': address,
  //     'experince': experience,
  //     // 'category': category,
  //   };
  // }
}
