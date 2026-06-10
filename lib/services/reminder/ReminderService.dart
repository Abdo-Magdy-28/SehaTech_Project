import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/medication_reminder.dart';
import 'package:grad_project/services/Authservice.dart';

class ReminderService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "$apiurl/api/v2/medications",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );
  ReminderService() {
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
  Future<bool> createReminder(MedicationReminder reminder) async {
    try {
      print("📤 SENDING REMINDER JSON:");
      print(reminder.toJson());
      final response = await _dio.post("/reminders", data: reminder.toJson());

      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception("Network error: ${e.response?.statusCode} ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
