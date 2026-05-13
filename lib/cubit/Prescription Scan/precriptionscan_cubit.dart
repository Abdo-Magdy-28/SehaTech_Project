import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Prescription%20Scan/prescriptionscan_states.dart';
import 'package:grad_project/services/prescriptionscan_service.dart';

class PrescriptionCubit extends Cubit<PrescriptionState> {
  final PrescriptionService service;

  PrescriptionCubit(this.service) : super(PrescriptionInitial());

  Future<void> analyzePrescription(File imageFile) async {
    try {
      emit(PrescriptionLoading());

      final data = await service.analyzePrescription(imageFile);

      emit(PrescriptionSuccess(data));
    } catch (e) {
      emit(PrescriptionError(e.toString()));
    }
  }
}
