class User {
  String name;
  String email;
  String password;
  String token;

  User({
    this.name,
    this.email,
    this.password,
    this.token
  });

  User.fromJson(Map<String, dynamic> map) {
    this.name = map["name"];
    this.email = map["email"];
    this.email = map["password"];
    this.token = map["token"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['token'] = this.token;

    return data;
  }

  @override
  String toString() {
    return 'User{name: $name, email: $email, password: $password, token: $token}';
  }
}