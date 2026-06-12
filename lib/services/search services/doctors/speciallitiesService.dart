import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';

class SpecialitiesService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '$apiurl/api',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  SpecialitiesService() {
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

  Future<List<String>> fetchSpecialities() async {
    try {
      final response = await _dio.get('/doctors/specialities');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data == null || data['specialities'] == null) return [];

        final List<dynamic> list = data['specialities'];
        return list
            .map((item) => item['speciality']?.toString() ?? '')
            .where((s) => s.isNotEmpty)
            .toList();
      } else {
        throw Exception('Failed to load specialities');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchDoctorsBySpeciality(
    String speciality,
  ) async {
    try {
      final encoded = Uri.encodeComponent(speciality);
      final response = await _dio.get('/doctors/speciality/$encoded');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        if (data == null || data['doctors'] == null) return [];

        final List<dynamic> list = data['doctors'];
        return list.cast<Map<String, dynamic>>();
      } else {
        throw Exception('Failed to load doctors for speciality');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
