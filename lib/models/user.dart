// lib/models/user.dart
class User {
  final String id;
  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final String token;
  final String phone;
  final String address;
  final String gender;
  final String role;
  final String password;
  final String passwordconfirm;
  final String image;
  final String date;

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
    required this.address,
    required this.image,
    required this.date,
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
      address: json['address'] ?? '',
      image: json['photo'] ?? '',
      date: json['date'] ?? '',
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
      'address': address,
      'date': date,
      'photo': image,
    };
  }

  // Helper getter
  String get fullName => '$firstname $lastname';
}
