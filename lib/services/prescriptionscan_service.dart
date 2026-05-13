import 'dart:io';
import 'package:dio/dio.dart';

class PrescriptionService {
  final Dio dio;

  PrescriptionService(this.dio);

  Future<dynamic> analyzePrescription(File imageFile) async {
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
    });

    Response response = await dio.post(
      "/analyze/prescription",
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer d1414a76-13c4-4267-9b96-12b0b62425f5",
        },
      ),
    );

    return response.data;
  }
}
