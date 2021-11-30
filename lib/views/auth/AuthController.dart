import 'dart:convert';

import 'package:badydoces/models/admin.model.dart';
import 'package:badydoces/repositories/admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends ChangeNotifier {
  SharedPreferences preferences;
  final AdminRepository repository = AdminRepository();

  Admin usuario = Admin();
  Admin get user => usuario;
  bool isLogged;
  bool get isLoggedUser => isLogged;

  Future<void> login() async {
    try {
      repository.admin = usuario;
      isLogged = await repository.login();
      notifyListeners();
    } catch (err) {}
  }

  Future<Admin> autenticar() async {
    try {
      this.preferences = await SharedPreferences.getInstance();
      this.usuario =
          Admin.fromJson(jsonDecode(this.preferences?.getString('user')));
      isLogged = true;
      notifyListeners();
    } catch (err) {
      print(err);
      isLogged = false;
      notifyListeners();
    }
  }

  Future<void> logout(context) async {
    this.preferences = await SharedPreferences.getInstance();
    preferences?.clear();
    Navigator.of(context).pushNamed('/');
  }
}
