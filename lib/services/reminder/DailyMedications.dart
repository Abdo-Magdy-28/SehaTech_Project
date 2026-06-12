import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/Reminders/DailyReminder.dart';

class DailyScheduleService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "$apiurl/api/v2/medications",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  DailyScheduleService() {
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

  Future<List<DailyMedications>> fetchDailySchedule(String date) async {
    try {
      final response = await _dio.get(
        "/schedule/daily",
        queryParameters: {"date": date},
      );
      if (response.statusCode != 200) {
        throw Exception("Server returned ${response.statusCode}");
      }
      final List data = response.data['data']['schedule'] ?? [];
      return data.map((e) => DailyMedications.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception(
        "Network error: ${e.response?.statusCode ?? 'No status'}\n"
        "Message: ${e.message}\n"
        "Data: ${e.response?.data}",
      );
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<void> markMedicationTaken(
    String reminderId,
    String scheduledTime,
    String scheduledDate,
  ) async {
    final response = await _dio.post(
      '/logs',
      data: {
        "reminderId": reminderId,
        "scheduledTime": scheduledTime,
        "scheduledDate": scheduledDate,
        "status": "taken",
      },
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception("Failed to mark medication as taken");
    }
  }
}
