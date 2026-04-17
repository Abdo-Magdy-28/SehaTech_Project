// lib/models/user.dart
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

  // ✅ FIXED: Match the API response keys!
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: (json['_id'] ?? json['id'] ?? '').toString(), // ✅ API uses _id
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      firstname:
          json['firstName'] ?? json['firstname'] ?? '', // ✅ API uses firstName
      lastname:
          json['lastName'] ?? json['lastname'] ?? '', // ✅ API uses lastName
      token: json['token'] ?? '',
      phone: (json['phoneNumber'] ?? json['phone'] ?? '')
          .toString(), // ✅ API uses phoneNumber
      gender: json['gender'] ?? '',
      role: json['role'] ?? '',
      password: json['password'] ?? '',
      passwordconfirm: json['passwordConfirm'] ?? json['passwordconfirm'] ?? '',
    );
  }

  // ✅ FIXED: Save with correct keys for later retrieval
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'username': username,
      'firstName': firstname,
      'lastName': lastname,
      'token': token,
      'phoneNumber': phone,
      'gender': gender,
      'role': role,
      'password': password,
      'passwordConfirm': passwordconfirm,
    };
  }

  // Helper getter
  String get fullName => '$firstname $lastname';
}
