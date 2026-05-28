import 'dart:io';

import 'package:dio/dio.dart';
import 'package:grad_project/models/medicine_preview_model.dart';

class MedicineBoxService {
  MedicineBoxService();

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl:
          "https://8080-dep-01kp3cxxfzs0chgwd41w54zmem-d.cloudspaces.litng.ai",
      headers: {
        "Authorization": "Bearer d1414a76-13c4-4267-9b96-12b0b62425f5",
        "Accept": "application/json",
      },
    ),
  );

  static const String _endpoint = '/analyze/medicine-box';

  Future<Medicine_preview> analyzeMedicineBox(File imageFile) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: 'medicine_box.jpg',
      ),
    });

    final response = await _dio.post<Map<String, dynamic>>(
      _endpoint,
      data: formData,
    );

    if (response.statusCode == 200 && response.data != null) {
      return Medicine_preview.fromJson(response.data!);
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      message: 'Unexpected status code: ${response.statusCode}',
    );
  }
}
