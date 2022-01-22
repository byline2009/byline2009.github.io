import 'dart:convert';

import 'package:bloc_login/models/category_response.dart';
import 'package:bloc_login/models/user_login.dart';
import 'package:bloc_login/provider/api.dart';
import 'package:bloc_login/provider/logger.dart';
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

class AuthenticationService extends BaseService {
  Api _api;

  AuthenticationService({required Api api}) : _api = api;

  Future<Token?> login(UserLogin model) async {
    final result = await _api.post('/api/v1/auths/login', data: model.toMap());
    if (result != null) {
      return Token.fromMap(result);
    } else {
      return null;
    }
  }

  Future<int> register(UserLogin model) async {
    final result = await _api.post('Register', data: model.toMap());
    return result['d'] ?? '';
  }

  Future<Token?> validateToken() async {
    final result = await _api.post('api/v1/auth', data: null);
    if (result['data'] != null) {
      return Token.fromMap(result['data']);
    } else {
      return null;
    }
  }

  Future<String> forgotPass(UserLogin user) async {
    final result =
        await _api.post('api/v1/clients/forgot-password', data: user);
    return result['data'] ?? '';
  }

  Future<CategoryResponse> getCategories(dynamic data) async {
    try {
      var response = await _api.get('/api/v1/merchants');
      return CategoryResponse.fromJson(response);
    } catch (error) {
      return CategoryResponse.withError("$error");
    }
  }
}
