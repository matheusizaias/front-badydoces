import 'package:badydoces/models/admin.model.dart';
import 'package:badydoces/models/produto.model.dart';
import 'package:badydoces/views/NewSale/new_sale_controller.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductRepository extends ChangeNotifier {
  SharedPreferences preferences;
  List<Product> products = <Product>[];
  List<Product> filteredProducts = <Product>[];
  ProductRepository() {
    read();
  }

  Future<bool> create(Product product) async {
    this.preferences = await SharedPreferences.getInstance();
    Admin usuario = Admin.fromJson(jsonDecode(preferences?.getString('user')));
    var token = usuario.token;
    var response = await http.post(
      'https://back-bady2.herokuapp.com/new-product',
      body: jsonEncode(product.toJson()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      Product product = Product.fromJson(jsonDecode(response.body));

      this.products.add(product);
      read();

      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> read() async {
    try {
      this.preferences = await SharedPreferences.getInstance();
      Admin usuario =
          Admin.fromJson(jsonDecode(preferences?.getString('user')));
      var token = usuario.token;
      var response = await http.get(
        'https://back-bady2.herokuapp.com/show-product',
        headers: {
          'Content-type': '	application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        Iterable products1 = jsonDecode(response.body) as List;
        var lista = products1.map((objeto) => Product.fromJson(objeto));
        this.products = lista.toList();
        notifyListeners();
      }
    } catch (erro) {}
  }

  Future<void> fetchProductByCategory({String category = ''}) async {
    try {
      this.preferences = await SharedPreferences.getInstance();
      Admin usuario =
          Admin.fromJson(jsonDecode(preferences?.getString('user')));
      var token = usuario.token;
      var response = await http.get(
        'https://back-bady2.herokuapp.com/show-product-category/$category',
        headers: {
          'Content-type': '	application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      if (response.statusCode == 200) {
        Iterable products = jsonDecode(response.body) as List;
        var lista = products.map((objeto) => Product.fromJson(objeto));
        this.filteredProducts = lista.toList();
        notifyListeners();
      }
    } catch (erro) {}
  }

  Future<void> delete(String id) async {
    this.preferences = await SharedPreferences.getInstance();
    Admin usuario = Admin.fromJson(jsonDecode(preferences?.getString('user')));
    var token = usuario.token;
    var response = await http.delete(
        "https://back-bady2.herokuapp.com/delete-product/$id",
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        });
    if (response.statusCode == 200) {
      this.products.removeWhere((product) => product.id_product == id);
      notifyListeners();
    }
  }

  Future<void> update(Product product) async {
    this.preferences = await SharedPreferences.getInstance();
    Admin usuario = Admin.fromJson(jsonDecode(preferences.getString('user')));
    var token = usuario.token;
    var response = await http.put(
        "https://back-bady2.herokuapp.com/update-product/${product.id_product}",
        body: jsonEncode(product.toJson()),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        });
    if (response.statusCode == 200) {
      int index =
          this.products.indexWhere((p) => p.id_product == product.id_product);
      this.products[index] = product;
      notifyListeners();
    }
  }
}
