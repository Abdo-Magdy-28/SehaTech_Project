import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/Reminders/OcrHistory.dart';

class OcrHistoryService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "$apiurl/api/v2"));

  OcrHistoryService() {
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

  Future<List<OcrHistoryModel>> fetchScans() async {
    final response = await _dio.get("/medications/scans");

    if (response.statusCode == 200) {
      final scans = response.data['data']['scans'] as List;
      return scans.map((e) => OcrHistoryModel.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load scans");
    }
  }

  Future<void> deleteScan(String scanId) async {
    final response = await _dio.delete("/medications/scans/$scanId");
    if (response.statusCode != 204) {
      throw Exception('Failed to delete scan');
    }
  }
}
