import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/Reminders/StreakReminderModel.dart';

class StreakService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "$apiurl/api/v2"));

  StreakService() {
    // Add interceptor to attach token automatically
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          const storage = FlutterSecureStorage();
          final token = await storage.read(key: 'auth_token');

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<StreakModel> fetchStreak() async {
    final response = await _dio.get("/streak");

    if (response.statusCode == 200) {
      return StreakModel.fromJson(response.data['data']);
    } else {
      throw Exception("Failed to load streak data");
    }
  }
}
