class User {
  final String login;
  final String password;
  final String role;

  User({required this.login, required this.password, required this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      login: json['login'],
      password: json['password'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'password': password,
      'role': role,
    };
  }
}
