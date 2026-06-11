import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/medicine/OcrModel.dart';
import 'package:grad_project/services/Ocr/OcrService.dart';

abstract class OcrStates {}

class OcrInitial extends OcrStates {}

class OcrLoading extends OcrStates {}

class OcrLoaded extends OcrStates {
  final OcrModel scan;
  OcrLoaded(this.scan);
}

class MedicationScanError extends OcrStates {
  final String message;
  MedicationScanError(this.message);
}

class OcrCubit extends Cubit<OcrStates> {
  final OcrService _service = OcrService();

  OcrCubit() : super(OcrInitial());

  Future<void> postScan(OcrModel scan) async {
    emit(OcrLoading());
    try {
      final result = await _service.postMedicationScan(scan);
      emit(OcrLoaded(result));
    } catch (e) {
      emit(MedicationScanError(e.toString()));
    }
  }
}
