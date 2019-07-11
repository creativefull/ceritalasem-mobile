import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../config/api.dart' show urlApi;

class Auth {
  Future<UserModel> getAuth() async {
    bool checkLogin = await isLogin();
    if (checkLogin) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userId = preferences.getString('userId');
      String nama = preferences.getString('nama');
      String email = preferences.getString('email');
      String token = preferences.getString('token');

      UserModel user = UserModel(
        userId: userId,
        nama: nama,
        email: email,
        token: token
      );

      return user;
    } else {
      print('belum login');
      return null;
    }
  }

  Future<bool> isLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    if (token != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<UserModel> sendLogin(String email, String password) async {
    Map<String, dynamic> dataToSend = {
      'email' : email,
      'password' : password
    };

    http.Response response = await http.post(urlApi + '/login', body: dataToSend);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data['success']) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('userId', data['userid'].toString());
        preferences.setString('nama', data['nama']);
        preferences.setString('email', data['email']);
        preferences.setString('token', data['token']);
        
        UserModel userModel = new UserModel(
          userId: data['userid'].toString(),
          nama: data['nama'],
          email: data['email'],
          token: data['token']
        );
        return userModel;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('userId');
    preferences.remove('nama');
    preferences.remove('email');
    preferences.remove('token');
  }
}

class UserModel {
  final String userId;
  final String nama;
  final String email;
  final String token;
  
  UserModel({
    this.userId,
    this.nama,
    this.email,
    this.token
  });
}