class ExpertCategoryModel {
  final String name;
  ExpertCategoryModel({required this.name});

  factory ExpertCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExpertCategoryModel(name: json['name']);
  }
  factory ExpertCategoryModel.zero() {
    return ExpertCategoryModel(
      name: '',
    );
  }
}
