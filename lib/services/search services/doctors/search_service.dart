import 'package:dio/dio.dart';
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
        final List<dynamic> doctorsList = body['data']['doctors'];
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
}
