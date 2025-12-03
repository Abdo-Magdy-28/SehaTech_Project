import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/models/user.dart';

class AuthService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();
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
    const String url = "https://sehatech-backend.vercel.app/api/auth/signup";
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

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    const String url = "https://sehatech-backend.vercel.app/api/auth/login";
    try {
      final response = await dio.post(
        url,
        data: {"email": email, "password": password},
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        String token = data['token'];
        await storage.write(key: 'auth_token', value: token);

        final userData = data['user'];
        User? userObj;
        if (userData != null) {
          userObj = User.fromJson(userData);
        }

        return LoginResponse(
          success: true,
          message: 'Login successful',
          token: token,
          user: userObj,
        );
      } else if (response.statusCode == 401) {
        return LoginResponse(success: false, message: 'Invalid credentials');
      } else {
        final error = response.data;
        return LoginResponse(
          success: false,
          message: error['message'] ?? 'Login failed',
        );
      }
    } catch (e) {
      // Handle DioException and SocketException (No Internet/No Host)
      if (e is DioException) {
        // DioException for no internet or host unreachable (especially mobile)
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.unknown ||
            e.error is SocketException) {
          return LoginResponse(
            success: false,
            message: 'No internet connection. Please check your network.',
          );
        }
        // Other Dio errors (timeout, etc.)
        return LoginResponse(
          success: false,
          message: 'Network error occurred. Please try again.',
        );
      }
      // Catch-all for all other errors
      return LoginResponse(
        success: false,
        message: 'An error occurred. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
  }

  Future<Response> forgotPassword({required String email}) async {
    const String url =
        "https://sehatech-backend.vercel.app/api/auth/forgotPassword";
    try {
      return await dio.post(url, data: {"email": email});
    } catch (e) {
      throw Exception("forgot password api call error");
    }
  }

  Future<Response> checkToken({required String Token}) async {
    String url =
        "https://sehatech-backend.vercel.app/api/auth/checkToken/$Token";
    try {
      return await dio.post(url, data: {"Token": Token});
    } catch (e) {
      throw Exception("Invaild reset code");
    }
  }

  Future<Response> resetPassword({
    required String code,
    required String password,
    required String confirmpassword,
  }) async {
    String url =
        "https://sehatech-backend.vercel.app/api/auth/resetPassword/$code";
    try {
      return await dio.post(
        url,
        data: {"password": password, "passwordConfirm": confirmpassword},
      );
    } catch (e) {
      throw Exception("forgot password api call error");
    }
  }
}

class LoginResponse {
  final bool success;
  final String message;
  final String? token;
  final User? user;

  LoginResponse({
    required this.success,
    required this.message,
    this.token,
    this.user,
  });
}
