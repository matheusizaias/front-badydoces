import 'package:badydoces/models/admin.model.dart';
import 'package:badydoces/models/venda.model.dart';
import 'package:badydoces/repositories/produto_repository.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SaleRepository extends ChangeNotifier {
  SharedPreferences preferences;
  List<Sale> sales = List<Sale>();
  bool createdNewSale;

  SaleRepository() {
    read();
  }

  Future<bool> create(Sale sale) async {
    this.preferences = await SharedPreferences.getInstance();
    Admin usuario = Admin.fromJson(jsonDecode(preferences?.getString('user')));
    var token = usuario.token;
    sale.adminId = usuario.id;

    var response = await http.post(
      'https://back-bady2.herokuapp.com/new-sale',
      body: jsonEncode(sale.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      Sale sale = Sale.fromJson(jsonDecode(response.body));
      this.sales.add(sale);
      await ProductRepository().read();
      return true;
    } else {
      return false;
    }
  }

  Future<void> read() async {
    try {
      this.preferences = await SharedPreferences.getInstance();
      Admin usuario =
          Admin.fromJson(jsonDecode(this.preferences?.getString('user')));
      var token = usuario.token;
      var response = await http.get(
        'https://back-bady2.herokuapp.com/show-order-sales',
        headers: {
          'Content-type': '	application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        Iterable sales = jsonDecode(response.body) as List;
        var lista = sales.map((objeto) => Sale.fromJson(objeto));
        this.sales = lista.toList();
        notifyListeners();
      }
    } catch (err) {}
  }

  Future<void> delete(String id) async {
    this.preferences = await SharedPreferences.getInstance();
    Admin usuario =
        Admin.fromJson(jsonDecode(this.preferences?.getString('user')));
    var token = usuario.token;
    var response = await http.delete(
        "https://back-bady2.herokuapp.com/delete-sale/$id",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        });
    if (response.statusCode == 200) {
      this.sales.removeWhere((sale) => sale.idSale == id);
      notifyListeners();
    } else {
      print(response.body);
    }
  }

  Future<void> update(Sale sale) async {
    this.preferences = await SharedPreferences.getInstance();
    Admin usuario =
        Admin.fromJson(jsonDecode(this.preferences?.getString('user')));
    var token = usuario.token;
    var response = await http.put("/${sale.idSale}",
        body: jsonEncode(sale.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        });
    if (response.statusCode == 200) {
      int index = this.sales.indexWhere((s) => s.idSale == sale.idSale);
      this.sales[index] = sale;
      notifyListeners();
    }
  }
}
