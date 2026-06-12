import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/Reminders/OcrHistory.dart';
import 'package:grad_project/services/prescription History/OcrHistoryService.dart';

abstract class OcrState {}

class OcrInitial extends OcrState {}

class OcrLoading extends OcrState {}

class OcrDeleteLoading extends OcrState {}

class OcrDeleteComplete extends OcrState {}

class OcrLoaded extends OcrState {
  final List<OcrHistoryModel> scans;
  OcrLoaded(this.scans);
}

class OcrError extends OcrState {
  final String message;
  OcrError(this.message);
}

class OcrHistoryCubit extends Cubit<OcrState> {
  final OcrHistoryService _service;
  OcrHistoryCubit(this._service) : super(OcrInitial());

  Future<void> loadHistory() async {
    emit(OcrLoading());
    try {
      final data = await _service.fetchScans();
      emit(OcrLoaded(data));
    } catch (e) {
      emit(OcrError(e.toString()));
    }
  }

  Future<void> deleteScan(String scanId) async {
    try {
      // keep current list before emitting loading
      final currentScans = state is OcrLoaded
          ? (state as OcrLoaded).scans
          : <OcrHistoryModel>[];

      emit(OcrDeleteLoading());
      await _service.deleteScan(scanId);

      // remove deleted item and go back to loaded
      final updated = currentScans.where((s) => s.id != scanId).toList();
      emit(OcrLoaded(updated));
    } catch (e) {
      emit(OcrError(e.toString()));
    }
  }
}
