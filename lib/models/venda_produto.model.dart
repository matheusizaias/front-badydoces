import 'package:badydoces/models/produto.model.dart';

class SaleProduct {
  String sale_id;
  String product_id;
  int qtd;
  String total;
  String price;

  SaleProduct(
      {this.sale_id, this.product_id, this.qtd, this.total, this.price});

  SaleProduct.fromJson(Map<String, dynamic> json) {
    sale_id = json['salesIdSale'];
    product_id = json['productIdProduct'];
    qtd = json['qtd'];
    price = json['price'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesIdSale'] = this.sale_id;
    data['productIdProduct'] = product_id;
    data['qtd'] = this.qtd;
    data['price'] = this.price;
    data['total'] = this.total;

    return data;
  }
}
