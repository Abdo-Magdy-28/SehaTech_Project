import 'dart:io';
import 'package:grad_project/models/medicine_preview_model.dart';

abstract class MedicineBoxState {
  const MedicineBoxState();
}

/// Initial state — no action taken yet
class MedicineBoxInitial extends MedicineBoxState {
  const MedicineBoxInitial();
}

/// Image has been picked and is ready to be uploaded
class MedicineBoxImagePicked extends MedicineBoxState {
  final File imageFile;

  const MedicineBoxImagePicked({required this.imageFile});
}

/// API call is in progress
class MedicineBoxLoading extends MedicineBoxState {
  const MedicineBoxLoading();
}

/// API call succeeded — medicine data available
class MedicineBoxSuccess extends MedicineBoxState {
  final Medicine_preview medicine;
  final File imageFile;

  const MedicineBoxSuccess({required this.medicine, required this.imageFile});
}

/// API call failed
class MedicineBoxFailure extends MedicineBoxState {
  final String errorMessage;
  final int? statusCode;

  const MedicineBoxFailure({required this.errorMessage, this.statusCode});
}
