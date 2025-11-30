class User {
  final String id;
  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final String token;
  final String phone;
  final String gender;
  final String role;
  final String password;
  final String passwordconfirm;

  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.token,
    required this.phone,
    required this.gender,
    required this.role,
    required this.password,
    required this.passwordconfirm,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
      token: json['token'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      role: json['role'] ?? '',
      password: json['password'] ?? '',
      passwordconfirm: json['passwordconfirm'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'firstname': firstname,
      'lastname': lastname,
      'token': token,
      'phone': phone,
      'gender': gender,
      'role': role,
      'password': password,
      'passwordconfirm': passwordconfirm,
    };
  }
}
