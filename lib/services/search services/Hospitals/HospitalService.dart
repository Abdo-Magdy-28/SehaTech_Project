import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/hospitals.dart';

class HospitalService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "$apiurl/api",
      connectTimeout: Duration(seconds: 30),
      receiveTimeout: Duration(seconds: 30),
    ),
  );

  HospitalService() {
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

  Future<List<Hospital>> searchHospitals({
    String? query,
    String? city,
    String? type,
    String? specialty,
    bool? hasEmergency,
    double? minRating,
    int page = 1,
    int? limit,
  }) async {
    try {
      final params = <String, dynamic>{
        if (query != null && query.isNotEmpty) 'query': query,
        if (city != null) 'city': city,
        if (type != null) 'type': type,
        if (specialty != null) 'specialty': specialty,
        if (hasEmergency != null) 'hasEmergency': hasEmergency,
        if (minRating != null) 'minRating': minRating,
        'page': page,
        if (limit == null) 'limit': 10,
        if (limit != null) 'limit': limit,
      };

      final response = await _dio.get(
        '/hospitals/search',
        queryParameters: params,
      );
      final responseData = response.data['data'];
      if (responseData == null) return [];
      final List data = responseData['hospitals'] ?? [];
      return data.map((e) => Hospital.fromJson(e)).toList();
    } on DioException catch (e) {
      throw Exception("Network error: ${e.response?.data ?? e.message}");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }
}
