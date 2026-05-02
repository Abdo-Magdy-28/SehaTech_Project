// services/search_service.dart

import 'package:dio/dio.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/doctor.dart';

class SearchService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '$apiurl/api',
      headers: {'Content-Type': 'application/json'},
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  Future<List<Doctor>> searchDoctors(String query) async {
    try {
      final response = await _dio.get(
        '/doctors/search',
        queryParameters: {'query': query},
      );

      if (response.statusCode == 200) {
        // ✅ FIXED: Access the nested "doctors" list
        final Map<String, dynamic> body = response.data;
        final List<dynamic> doctorsList = body['data']['doctors'];
        return doctorsList.map((item) => Doctor.fromJson(item)).toList();
      } else {
        throw Exception('Failed to search doctors');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout. Please try again.');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Server took too long to respond.');
      } else if (e.response != null) {
        throw Exception('Error: ${e.response?.statusMessage}');
      } else {
        throw Exception('No internet connection.');
      }
    }
  }
}
