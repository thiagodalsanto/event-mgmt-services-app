class User {
  final String name;
  final String email;
  final String password;
  final String localization;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.localization,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'localization': localization,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'],
      email: map['email'],
      password: map['password'],
      localization: map['localization'],
    );
  }
}
