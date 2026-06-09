import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/doctor.dart';

class SearchService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '$apiurl/api',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 30), // ✅ Increased
      receiveTimeout: const Duration(seconds: 30), // ✅ Increased
    ),
  );
  SearchService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Read token from secure storage
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
  Future<List<Doctor>> searchDoctors(String query) async {
    try {
      print('🔍 URL: ${_dio.options.baseUrl}/doctors/search?query=$query');

      final response = await _dio.get(
        '/doctors/search',
        queryParameters: {'query': query},
      );

      print('✅ STATUS: ${response.statusCode}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = response.data;
        final data = body['data'];

        if (data == null || data['doctors'] == null) {
          return [];
        }

        final List<dynamic> doctorsList = data['doctors'];
        return doctorsList.map((item) => Doctor.fromJson(item)).toList();
      } else {
        throw Exception('Failed to search doctors');
      }
    } on DioException catch (e) {
      print('❌ DIO ERROR: ${e.type} - ${e.message}');

      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception(
          'Connection timeout. Server may be waking up, try again.',
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server took too long to respond.');
      } else if (e.response != null) {
        throw Exception('Error: ${e.response?.statusMessage}');
      } else {
        throw Exception('No internet connection.');
      }
    } catch (e) {
      print('❌ UNKNOWN ERROR: $e');
      throw Exception('Something went wrong: $e');
    }
  }

  Future<List<Doctor>> fetchDoctors() async {
    try {
      final response = await _dio.get('/doctors');

      if (response.statusCode == 200) {
        final data = response.data['data']['doctors'] as List<dynamic>;
        return data.map((json) => Doctor.fromJson(json)).toList();
      } else {
        throw Exception('Failed with status: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.response?.statusCode} ${e.message}');
    }
  }
}
