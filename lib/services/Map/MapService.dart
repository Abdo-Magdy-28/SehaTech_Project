import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/models/pharmacies.dart';

class MapService {
  final Dio _dio;

  MapService() : _dio = Dio(BaseOptions(baseUrl: '$apiurl/api')) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          const storage = FlutterSecureStorage();
          final token = await storage.read(key: 'auth_token');
          if (token != null) options.headers['Authorization'] = 'Bearer $token';
          return handler.next(options);
        },
      ),
    );
  }

  /// Returns the current position or throws if permission/service unavailable.
  Future<Position> getCurrentPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever ||
        permission == LocationPermission.denied) {
      throw LocationPermissionDeniedException();
    }

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationServiceDisabledException();
    }

    return Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    ).timeout(const Duration(seconds: 10));
  }

  Future<List<Hospital>> getNearbyHospitals({
    required double lat,
    required double lng,
  }) async {
    print(lat);
    print(lng);
    final response = await _dio.get(
      '/hospitals/nearby',
      queryParameters: {
        'lat': lat,
        'lng': lng,
        'maxDistance': 20000,
        'limit': 20,
      },
    );
    final data = response.data['data'];
    final list = (data?['hospitals'] as List?) ?? [];
    return list.map((e) => Hospital.fromJson(e)).toList();
  }

  Future<List<Pharmacy>> getNearbyPharmacies({
    required double lat,
    required double lng,
  }) async {
    final response = await _dio.get(
      '/pharmacies/nearby',
      queryParameters: {
        'lat': lat,
        'lng': lng,
        'maxDistance': 20000,
        'limit': 20,
      },
    );
    final data = response.data['data'];
    final list = (data?['pharmacies'] as List?) ?? [];
    return list.map((e) => Pharmacy.fromJson(e)).toList();
  }
}

class LocationPermissionDeniedException implements Exception {}

class LocationServiceDisabledException implements Exception {}
