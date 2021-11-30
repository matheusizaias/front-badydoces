class Admin {
  String id;
  String name;
  String email;
  String password;
  String token;

  Admin({this.id, this.name, this.email, this.password, this.token});

  Admin.fromJson(Map<String, dynamic> json) {
    id = json['admin']['id'];
    name = json['admin']['name'];
    email = json['admin']['email'];
    password =
        json['admin']['password'] != null ? json['admin']['password'] : '';
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      "token": token
    };
  }

  @override
  String toString() {
    return '{"admin": { "id": "$id", "name": "$name", "email": "$email"}, "token": "$token"}';
  }
}
