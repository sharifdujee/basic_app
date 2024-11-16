import 'package:flutter/cupertino.dart';
import 'package:recipe_app/services/http_service.dart';

import '../model/user.dart';

class AuthService {
  static final AuthService _singleton = AuthService._internal();
  final _httpService = HttpService();
  User? user;
  factory AuthService() {
    return _singleton;
  }
  AuthService._internal();

  Future<bool> login(String name, String password) async {
    try{
      var response = await _httpService.post('auth/login', {
        'username': name,
        'password': password
      });
      if(response?.statusCode==200 && response?.data!=null){
        user = User.fromJson(response!.data);
        HttpService().setUp(bearerToken: user!.accessToken);
        return true;
      }


    }
    catch(e){
      print(e);
    }
    return false;
  }
}
