import 'dart:convert';

import 'package:badydoces/models/admin.model.dart';
import 'package:badydoces/models/venda_produto.model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SaleProductRepository extends ChangeNotifier {
  List<SaleProduct> salesProducts = List<SaleProduct>();
  SharedPreferences preferences;
  bool createdNewSale;
  SaleProductRepository() {
    read();
  }

  Future<bool> create(SaleProduct saleProduct) async {
    this.preferences = await SharedPreferences.getInstance();
    Admin usuario = Admin.fromJson(jsonDecode(preferences?.getString('user')));
    var token = usuario.token;

    var response = await http.post(
      'https://back-bady2.herokuapp.com/new-sale-product',
      body: jsonEncode(saleProduct.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      SaleProduct saleProduct = SaleProduct.fromJson(jsonDecode(response.body));
      this.salesProducts.add(saleProduct);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> read() async {
    this.preferences = await SharedPreferences.getInstance();
    Admin usuario = Admin.fromJson(jsonDecode(preferences?.getString('user')));
    var token = usuario.token;
    var response = await http.get(
      'https://back-bady2.herokuapp.com/show-sale-product',
      headers: {
        'Content-type': '	application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    if (response.statusCode == 200) {
      Iterable salesProducts = jsonDecode(response.body) as List;
      var lista = salesProducts.map((objeto) => SaleProduct.fromJson(objeto));
      this.salesProducts = lista.toList();
      notifyListeners();
    }
  }
}
