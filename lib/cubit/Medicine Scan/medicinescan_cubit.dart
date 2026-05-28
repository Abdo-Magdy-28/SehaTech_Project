import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:grad_project/cubit/Medicine%20Scan/medicinescan_states.dart';
import 'package:grad_project/services/medicinescan_service.dart';

class MedicineBoxCubit extends Cubit<MedicineBoxState> {
  MedicineBoxCubit({required MedicineBoxService medicineBoxService})
    : _service = medicineBoxService,
      super(const MedicineBoxInitial());

  final MedicineBoxService _service;
  final ImagePicker _picker = ImagePicker();

  // ─── Image Picking ────────────────────────────────────────────────────────
  Future<void> pickImageFromCamera() async => _pickImage(ImageSource.camera);
  Future<void> pickImageFromGallery() async => _pickImage(ImageSource.gallery);

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (picked == null) return; // user cancelled
      emit(MedicineBoxImagePicked(imageFile: File(picked.path)));
    } catch (e) {
      emit(MedicineBoxFailure(errorMessage: 'Failed to pick image: $e'));
    }
  }

  // ─── Analyze ──────────────────────────────────────────────────────────────
  Future<void> analyzeImage(File imageFile) async {
    emit(const MedicineBoxLoading());

    try {
      final medicine = await _service.analyzeMedicineBox(imageFile);
      emit(MedicineBoxSuccess(medicine: medicine, imageFile: imageFile));
      print("Raw response: ${medicine.toJson()}");
    } on DioException catch (e) {
      emit(
        MedicineBoxFailure(
          errorMessage: _mapDioError(e),
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      emit(MedicineBoxFailure(errorMessage: 'Unexpected error: $e'));
    }
  }

  void reset() => emit(const MedicineBoxInitial());

  String _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Request timed out. Please check your connection.';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 400) return 'Invalid image. Please try a clearer photo.';
        if (code == 413)
          return 'Image is too large. Please use a smaller file.';
        if (code == 422)
          return 'Could not extract medicine data from this image.';
        if (code != null && code >= 500)
          return 'Server error ($code). Try again later.';
        return 'Server returned an error (${code ?? 'unknown'}).';
      default:
        return e.message ?? 'Something went wrong.';
    }
  }
}
