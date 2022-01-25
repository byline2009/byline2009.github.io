import 'package:bloc_login/data_layer/models/category.dart';

class CategoryResponse {
  final List<Category> categories;
  final String error;
  CategoryResponse({required this.categories, required this.error});
  CategoryResponse.fromJson(Map<String, dynamic> json)
      : categories =
            (json["data"] as List).map((i) => Category.fromJson(i)).toList(),
        error = "";
  CategoryResponse.withError(String errorValue)
      : categories = [],
        error = errorValue;
}
