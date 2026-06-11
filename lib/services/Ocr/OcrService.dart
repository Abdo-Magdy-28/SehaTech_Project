import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/models/medicine/OcrModel.dart';

class OcrService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "$apiurl/api/v2"));

  OcrService() {
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

  Future<OcrModel> postMedicationScan(OcrModel scan) async {
    final response = await _dio.post("/medications/scans", data: scan.toJson());

    if (response.statusCode == 200 || response.statusCode == 201) {
      return OcrModel.fromJson(response.data);
    } else {
      throw Exception("Failed to post medication scan");
    }
  }
}
