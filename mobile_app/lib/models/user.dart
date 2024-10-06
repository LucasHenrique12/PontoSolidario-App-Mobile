class User {
  final String name;
  final String email;
  final String password;
  final String gender;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'gen': gender,
    };
  }
}
