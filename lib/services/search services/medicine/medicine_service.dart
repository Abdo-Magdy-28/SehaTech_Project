import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/medicine/medicinemodel.dart';

class MedicineService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "$apiurl/api/v2"));
  MedicineService() {
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

  Future<List<MedicineModel>> fetchMedicines({
    required String search,
    required String category,
    required int page,
    required int limit,
  }) async {
    final response = await _dio.get(
      "/medicines",
      queryParameters: {
        "search": search,
        "category": category,
        "page": page,
        "limit": limit,
      },
    );

    if (response.statusCode == 200) {
      final data = response.data["data"]["medicines"] as List;
      return data.map((json) => MedicineModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch medicines");
    }
  }
}
