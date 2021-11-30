import 'package:badydoces/models/admin.model.dart';

import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AdminRepository extends ChangeNotifier {
  SharedPreferences preferences;
  Admin admin = Admin();

  Future<bool> login() async {
    var url = Uri.parse('https://back-bady2.herokuapp.com/session');
    var response = await http.post(
      url,
      body: json.encode(admin.toJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      this.preferences = await SharedPreferences.getInstance();
      final Admin user = Admin.fromJson(jsonDecode(response.body));
      this.preferences?.setString(
            "user",
            user.toString(),
          );
      return true;
    } else {
      return false;
    }
  }
}
