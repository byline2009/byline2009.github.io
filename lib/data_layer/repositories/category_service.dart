import 'dart:convert';

import 'package:bloc_login/data_layer/models/category_response.dart';
import 'package:bloc_login/data_layer/models/user_login.dart';
import 'package:bloc_login/data_layer/provider/api.dart';
import 'package:bloc_login/data_layer/provider/logger.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class BaseService {
  late Logger log;

  BaseService({String? title}) {
    this.log = getLogger(
      title ?? this.runtimeType.toString(),
    );
  }
}

class CategoryService extends BaseService {
  Api _api;

  CategoryService({required Api api}) : _api = api;

  Future<CategoryResponse> getCategories(dynamic data) async {
    try {
      var response = await _api.get('/api/v1/merchants');
      return CategoryResponse.fromJson(response);
    } catch (error) {
      return CategoryResponse.withError("$error");
    }
  }
}
