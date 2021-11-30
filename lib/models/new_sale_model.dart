import 'dart:convert';

class NewSaleModel {
  String adminId;
  String costumer;
  String idProduct;
  int amount;
  String productName;
  NewSaleModel({
    this.adminId,
    this.costumer,
    this.idProduct,
    this.amount,
    this.productName,
  });

  NewSaleModel copyWith({
    String adminId,
    String costumer,
    String idProduct,
    int amount,
    String productName,
  }) {
    return NewSaleModel(
      adminId: adminId ?? this.adminId,
      costumer: costumer ?? this.costumer,
      idProduct: idProduct ?? this.idProduct,
      amount: amount ?? this.amount,
      productName: productName ?? this.productName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'adminId': adminId,
      'costumer': costumer,
      'idProduct': idProduct,
      'amount': amount,
      'productName': productName,
    };
  }

  factory NewSaleModel.fromMap(Map<String, dynamic> map) {
    return NewSaleModel(
      adminId: map['adminId'],
      costumer: map['costumer'],
      idProduct: map['idProduct'],
      amount: map['amount'],
      productName: map['productName'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NewSaleModel.fromJson(String source) =>
      NewSaleModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewSaleModel(adminId: $adminId, costumer: $costumer, idProduct: $idProduct, amount: $amount, productName: $productName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NewSaleModel &&
        other.adminId == adminId &&
        other.costumer == costumer &&
        other.idProduct == idProduct &&
        other.amount == amount &&
        other.productName == productName;
  }

  @override
  int get hashCode {
    return adminId.hashCode ^
        costumer.hashCode ^
        idProduct.hashCode ^
        amount.hashCode ^
        productName.hashCode;
  }
}
