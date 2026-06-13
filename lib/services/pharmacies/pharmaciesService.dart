import 'package:dio/dio.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/pharmacies.dart';
import 'package:grad_project/services/Authservice.dart';

class PharmacyService {
  final Dio dio = Dio();
  final AuthService authService = AuthService();

  Future<List<Pharmacy>> getPharmacies({int page = 1}) async {
    final token = await authService.getToken();

    final response = await dio.get(
      "$apiurl/api/pharmacies",
      queryParameters: {"page": page},
      options: Options(
        headers: {"Authorization": "Bearer $token"},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data['data']['pharmacies'] as List;
      return data.map((e) => Pharmacy.fromJson(e)).toList();
    } else {
      throw Exception(response.data['message'] ?? "Failed to load pharmacies");
    }
  }

  Future<List<Pharmacy>> searchPharmacies(String query) async {
    final token = await authService.getToken();

    final response = await dio.get(
      "$apiurl/api/pharmacies/name",
      queryParameters: {"query": query},
      options: Options(
        headers: {"Authorization": "Bearer $token"},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data['data']['pharmacies'] as List;
      return data.map((e) => Pharmacy.fromJson(e)).toList();
    } else {
      throw Exception(response.data['message'] ?? "Search failed");
    }
  }

  Future<List<Pharmacy>> getNearbyPharmacies({
    required double lat,
    required double lng,
    int maxDistance = 5000,
    int limit = 20,
  }) async {
    final token = await authService.getToken();

    final response = await dio.get(
      "$apiurl/api/pharmacies/nearby",
      queryParameters: {
        "lat": lat,
        "lng": lng,
        "maxDistance": maxDistance,
        "limit": limit,
      },
      options: Options(
        headers: {"Authorization": "Bearer $token"},
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data['data']['pharmacies'] as List;
      return data.map((e) => Pharmacy.fromJson(e)).toList();
    } else {
      throw Exception(
        response.data['message'] ?? "Failed to load nearby pharmacies",
      );
    }
  }
}
