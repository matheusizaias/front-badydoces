class Product {
  String id_product;
  String name;
  String price;
  int amount;
  // ignore: non_constant_identifier_names
  String name_category;

  // ignore: non_constant_identifier_names
  Product(
      {this.id_product,
      this.name,
      this.amount,
      this.name_category,
      this.price});

  Product.fromJson(Map<String, dynamic> json) {
    id_product = json['id'];
    name = json['name'];
    amount = json['amount'];
    name_category = json['name_category'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id_product,
      'name': name,
      'amount': amount,
      'name_category': name_category,
      'price': price,
    };
  }
}
