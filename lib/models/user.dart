class User {
  final String id;
  final String email;
  final String username;
  final String firstname;
  final String lastname;
  final String token;
  final int phone;
  final String gender;
  final String role;
  final String password;
  final String passwordconfirm;
  const User(
    this.id,
    this.username,
    this.firstname,
    this.lastname,
    this.phone,
    this.gender,
    this.token,
    this.role,
    this.password,
    this.passwordconfirm, {
    required this.email,
  });
}
