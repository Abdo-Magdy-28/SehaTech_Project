import 'package:dio/dio.dart';

class AuthService {
  final Dio dio = Dio();

  Future<Response> signup({
    required String firstname,
    required String lastname,
    required String email,
    required String password,
    required String confirmpassword,
    required String username,
    required String role,
    required String gender,
    required String phone,
  }) async {
    const String url = "http://192.168.1.3:5000/api/auth/signup";
    try {
      return await dio.post(
        url,
        data: {
          "username": username,
          "email": email,
          "firstName": firstname,
          "lastName": lastname,
          "phoneNumber": phone,
          "gender": gender,
          "role": role,
          "password": password,
          "passwordConfirm": confirmpassword,
        },
      );
    } catch (e) {
      throw Exception("api call error");
    }
  }
}
