import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/services/const.dart';

class HttpService {
  static final HttpService _singleton = HttpService._internal();

  final _dio = Dio();
  factory HttpService() {
    return _singleton;
  }
  HttpService._internal() {
    setUp();
  }

  Future<void> setUp({String? bearerToken}) async {
    final headers = {
      'Content-Type': 'application/json',
    };
    if (bearerToken != null) {
      headers['Authorization'] = 'Bearer $bearerToken';
    }
    final options = BaseOptions(
        baseUrl: API_BASE_URL,
        headers: headers,
        validateStatus: (status) {
          if (status == null) return false;
          return status < 500;
        });
    _dio.options = options;
  }

  Future<Response?> post(String path, Map data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } catch (e) {
      print(e);
    }
  }

  Future<Response?> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
