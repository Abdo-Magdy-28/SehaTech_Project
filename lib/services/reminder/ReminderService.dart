import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/Reminders/AllReminder.dart';
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
      final response = await _dio.post("/reminders", data: reminder.toJson());

      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      throw Exception("Network error: ${e.response?.statusCode} ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<List<AllReminderModel>> getAllReminders() async {
    try {
      final response = await _dio.get("/reminders");

      if (response.statusCode != 200) {
        throw Exception("Server returned ${response.statusCode}");
      }

      final List data = response.data['data']['reminders'] ?? [];
      return data.map((e) => AllReminderModel.fromJson(e)).toList();
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

  Future<void> deleteReminder(String id) async {
    final response = await _dio.delete("/reminders/$id");

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete reminder');
    }
  }

  Future<bool> updateReminder(String id, MedicationReminder reminder) async {
    try {
      final response = await _dio.patch(
        "/reminders/$id",
        data: {
          "medicationName": reminder.medicationName,
          "genericName": reminder.genericName,
          "form": reminder.form,
          "strength": reminder.strength,
          "instructions": reminder.instructions,
          "startDate": reminder.startDate,
          "endDate": reminder.endDate,
          "daysOfWeek": reminder.daysOfWeek,
          "color": reminder.color,
          "doseTimes": reminder.doseTimes
              .map((d) => {"time": d.time, "dosage": d.dosage})
              .toList(),
        },
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      throw Exception("Network error: ${e.response?.statusCode} ${e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
