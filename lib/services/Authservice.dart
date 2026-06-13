import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/user.dart';

class AuthService {
  final Dio dio = Dio();
  final storage = FlutterSecureStorage();
  // ✅ Save user data
  Future<void> saveUserData(User user) async {
    await storage.write(key: 'user_data', value: jsonEncode(user.toJson()));
  }

  // ✅ Get user data
  Future<User?> getUserData() async {
    final userData = await storage.read(key: 'user_data');
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  // ✅ Get token
  Future<String?> getToken() async {
    return await storage.read(key: 'auth_token');
  }

  Future<String?> getUserId() async {
    const storage = FlutterSecureStorage();
    final userDataString = await storage.read(key: 'user_data');

    if (userDataString != null) {
      final Map<String, dynamic> userData = jsonDecode(userDataString);
      // Assuming your JSON looks like: { "id": "123", "name": "..." }
      return userData['_id'] ?? userData['id'];
    }
    return null;
  }

  // ✅ Check if logged in
  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: 'auth_token');
    return token != null && token.isNotEmpty;
  }

  Future<LoginResponse> signup({
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
    const String url = "$apiurl/api/auth/signup";

    try {
      final response = await dio.post(
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
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          sendTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final data = response.data;

        // ✅ Check if token is returned on signup
        String? token = data['token'];
        if (token != null) {
          await storage.write(key: 'auth_token', value: token);
        }

        // ✅ Check if user data is returned on signup
        final userData = data['data']?['user'] ?? data['user'];
        User? userObj;
        if (userData != null) {
          userData['token'] = token;
          userObj = User.fromJson(userData);
          await saveUserData(userObj);
          print('✅ User data saved');
        }

        return LoginResponse(
          success: true,
          message: 'Account created successfully',
          token: token,
          user: userObj,
        );
      }

      if (response.statusCode == 409) {
        return LoginResponse(
          success: false,
          message: 'Email or username already exists',
        );
      }

      return LoginResponse(
        success: false,
        message: response.data['message'] ?? "Signup failed",
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        return LoginResponse(success: false, message: "No internet connection");
      }
      return LoginResponse(success: false, message: "Network error occurred");
    } catch (e) {
      return LoginResponse(
        success: false,
        message: "Unexpected error occurred",
      );
    }
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    const String url = "$apiurl/api/auth/login";
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
        print('Token received: $token');
        await storage.write(key: 'auth_token', value: token);
        print('Token saved successfully');
        final userData = data['data']?['user'];
        User? userObj;
        if (userData != null) {
          userData['token'] = token;
          userObj = User.fromJson(userData);
          await saveUserData(userObj);
        }
        await storage.write(key: 'login_method', value: 'local');
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

  Future<LoginResponse> googleLogin({required String idToken}) async {
    const String url = "$apiurl/api/v2/auth/google/verify-token";
    try {
      final response = await dio.post(
        url,
        data: {"idToken": idToken},
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        String? token = data['token'];
        if (token != null) {
          await storage.write(key: 'auth_token', value: token);
        }

        final userData = data['data']?['user'] ?? data['user'];
        User? userObj;
        if (userData != null) {
          userData['token'] = token;
          userObj = User.fromJson(userData);
          await saveUserData(userObj);
        }

        await storage.write(key: 'login_method', value: 'google');

        return LoginResponse(
          success: true,
          message: 'Login successful',
          token: token,
          user: userObj,
        );
      }

      return LoginResponse(
        success: false,
        message: response.data['message'] ?? 'Google sign-in failed',
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        return LoginResponse(success: false, message: 'No internet connection');
      }
      return LoginResponse(success: false, message: 'Network error occurred');
    } catch (e) {
      return LoginResponse(
        success: false,
        message: 'Unexpected error occurred',
      );
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'auth_token');
    // await storage.delete(key: 'user_data');
    final GoogleSignIn googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }
  }

  Future<LoginResponse> forgotPassword({required String email}) async {
    try {
      final response = await dio.post(
        "$apiurl/api/auth/forgotPassword",
        data: {"email": email},
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        return LoginResponse(
          success: true,
          message: "Reset code sent to your email",
        );
      }

      if (response.statusCode == 404) {
        return LoginResponse(success: false, message: "Email not found");
      }

      return LoginResponse(
        success: false,
        message: "Failed to send reset code",
      );
    } on DioException {
      return LoginResponse(success: false, message: "No internet connection");
    }
  }

  Future<LoginResponse> checkToken({required String Token}) async {
    try {
      final response = await dio.post(
        "$apiurl/api/auth/checkToken/$Token",
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        return LoginResponse(success: true, message: "Code is valid");
      }
      return LoginResponse(success: false, message: "Invalid or expired code");
    } on DioException {
      return LoginResponse(success: false, message: "No internet connection");
    }
  }

  Future<LoginResponse> resetPassword({
    required String code,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await dio.post(
        "$apiurl/api/auth/resetPassword/$code",
        data: {"password": password, "passwordConfirm": confirmPassword},
        options: Options(
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      if (response.statusCode == 200) {
        return LoginResponse(
          success: true,
          message: "Password changed successfully",
        );
      }

      return LoginResponse(
        success: false,
        message: response.data['message'] ?? "Failed to reset password",
      );
    } on DioException {
      return LoginResponse(success: false, message: "No internet connection");
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
