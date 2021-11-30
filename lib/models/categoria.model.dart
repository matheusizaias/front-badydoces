class Categoria {
  // ignore: non_constant_identifier_names
  String category_name;
  String id;

  // ignore: non_constant_identifier_names
  Categoria({this.category_name, this.id});

  Categoria.fromJson(Map<String, dynamic> json) {
    category_name = json['category_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {'category_name': category_name, 'id': id};
  }
}
