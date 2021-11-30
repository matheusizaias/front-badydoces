import 'package:badydoces/models/produto.model.dart';

class Sale {
  String idSale;
  String adminId;
  String costumer;
  String value;

  String createdAt;
  List<Product> idProduct;

  Sale({this.idSale, this.adminId, this.costumer, this.value, this.idProduct});

  Sale.fromJson(Map<String, dynamic> json) {
    idSale = json['id_sale'];
    adminId = json['admin_id'];
    costumer = json['costumer'];
    value = json['value'].toString();
    createdAt = json['created_at'];
    if (json['id_product'] != null) {
      idProduct = <Product>[];
      json['id_product'].forEach((v) {
        idProduct.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_sale'] = this.idSale;
    data['admin_id'] = this.adminId;
    data['costumer'] = this.costumer;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    if (this.idProduct != null) {
      data['id_product'] = this.idProduct.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
