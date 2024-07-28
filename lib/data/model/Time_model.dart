import 'dart:io';

class TimeModel {
  final int id;
  final int day_id;
  final int cost;
  final String start;
  final String end;

  TimeModel({
    required this.id,
    required this.day_id,
    required this.cost,
    required this.start,
    required this.end,
  });

  factory TimeModel.zero() {
    return TimeModel(id: 0, day_id: 0, cost: 0, start: '', end: '');
  }

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      id: json['id'],
      day_id: json['day_id'],
      cost: json['cost'],
      start: json['start'],
      end: json['end'],
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
