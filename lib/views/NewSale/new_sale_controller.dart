import 'dart:js';

import 'package:badydoces/models/categoria.model.dart';
import 'package:badydoces/models/new_sale_model.dart';
import 'package:badydoces/models/produto.model.dart';
import 'package:badydoces/models/venda.model.dart';
import 'package:badydoces/models/venda_produto.model.dart';
import 'package:badydoces/repositories/produto_repository.dart';
import 'package:badydoces/repositories/venda_produto_repository.dart';
import 'package:badydoces/repositories/venda_repository.dart';
import 'package:badydoces/views/NewSale/new_sale.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badydoces/views/Home/home_controller.dart';

class NewSaleController extends ChangeNotifier {
  static NewSaleController instance = NewSaleController();
  Categoria select_category;
  List<Product> products = [];
  String costumer;
  List<Categoria> categories;
  Sale newSale;
  SaleProduct newSaleProduct;
  Product select_product;
  bool created;

  Sale fieldsNewSale = Sale();
  void addProduct(Product product) {
    this.products.add(product);
    notifyListeners();
  }

  void removeProduct(int index) {
    this.products.removeAt(index);
    notifyListeners();
  }

  Future<bool> realizarVenda(String adminId) async {
    created = false;
    newSale = Sale(
      adminId: adminId,
      costumer: fieldsNewSale.costumer,
      idProduct: products,
    );

    try {
      bool created = await SaleRepository().create(newSale);
      notifyListeners();
      return created;
    } catch (err) {
      return false;
    }
    notifyListeners();
  }
}
