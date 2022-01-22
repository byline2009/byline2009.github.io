import 'dart:io';
import 'dart:convert';
import 'package:bloc_login/provider/exception.dart';
import 'package:bloc_login/provider/keys.dart';
import 'package:bloc_login/provider/locator.dart';
import 'package:http/http.dart' as http;

import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum HttpMethod { GET, POST, PUT, PATCH, DELETE }

class Api {
  final String _baseUrl = 'https://wallet-dev.namtech.xyz';
  final PackageInfo _packageInfo = locator<PackageInfo>();
  // ignore: unused_field
  final SharedPreferences _prefs = locator<SharedPreferences>();

  Future<dynamic> get(String urlPath, {Map<String, String>? headers}) async {
    return await _request(HttpMethod.GET, urlPath, headers: headers);
  }

  Future<dynamic> post(String urlPath,
      {dynamic data, Map<String, String>? headers}) async {
    return await _request(HttpMethod.POST, urlPath,
        data: data, headers: headers);
  }

  Future<dynamic> put(String urlPath,
      {dynamic data, Map<String, String>? headers}) async {
    return await _request(HttpMethod.PUT, urlPath,
        data: data, headers: headers);
  }

  Future<dynamic> patch(String urlPath,
      {dynamic data, Map<String, String>? headers}) async {
    return await _request(HttpMethod.PATCH, urlPath,
        data: data, headers: headers);
  }

  Future<dynamic> delete(String urlPath, {Map<String, String>? headers}) async {
    return await _request(HttpMethod.DELETE, urlPath, headers: headers);
  }

  Future<dynamic> _request(HttpMethod method, String urlPath,
      {dynamic data, Map<String, String>? headers}) async {
    final url = _baseUrl + urlPath;
    final accessToken = _prefs.getString(Keys.tokenKey);
    var responseJson;

    headers = headers ?? {};
    headers['x-app-name'] = _packageInfo.appName;
    headers['x-app-version'] = _packageInfo.version;
    headers['x-app-build-version'] = _packageInfo.buildNumber;
    headers[HttpHeaders.acceptHeader] = '*/*';
    headers[HttpHeaders.contentTypeHeader] = 'application/json';

    if (accessToken != null) {
      headers[HttpHeaders.authorizationHeader] = 'Bearer ' + accessToken;
    }

    try {
      var response;
      switch (method) {
        case HttpMethod.GET:
          try {
            response = await http.get(Uri.parse(url), headers: headers);
          } catch (e) {
            print(e.toString());
          }
          break;

        case HttpMethod.POST:
          try {
            response = await http.post(Uri.parse(url),
                body: data == null ? [] : jsonEncode(data), headers: headers);
          } catch (e) {
            print(e.toString());
          }
          break;

        case HttpMethod.PUT:
          response = await http.put(Uri.parse(url),
              body: jsonEncode(data), headers: headers);
          break;

        case HttpMethod.PATCH:
          response = await http.patch(Uri.parse(url),
              body: jsonEncode(data), headers: headers);
          break;

        case HttpMethod.DELETE:
          response = await http.delete(Uri.parse(url), headers: headers);
          break;
      }

      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        var err = json.decode(response.body.toString());
        throw BadRequestException(err['message']);

      case 401:
      case 403:
        var err = json.decode(response.body.toString());
        throw UnauthorisedException(err['message']);

      case 500:
      default:
        var err = json.decode(response.body.toString());
        throw UnknownException(err['message']);
    }
  }
}
