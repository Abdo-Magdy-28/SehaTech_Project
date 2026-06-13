import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/services/search%20services/Hospitals/HospitalService.dart';

abstract class HospitalState {}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  final List<Hospital> hospitals;
  HospitalLoaded(this.hospitals);
}

class HospitalError extends HospitalState {
  final String message;
  HospitalError(this.message);
}

class HospitalCubit extends Cubit<HospitalState> {
  final HospitalService _service = HospitalService();

  HospitalCubit() : super(HospitalInitial());

  Future<void> searchHospitals({
    String? query,
    String? city,
    String? type,
    String? specialty,
    bool? hasEmergency,
    double? minRating,
    int? limit,
  }) async {
    emit(HospitalLoading());
    try {
      final hospitals = await _service.searchHospitals(
        query: query,
        city: city,
        type: type,
        specialty: specialty,
        hasEmergency: hasEmergency,
        minRating: minRating,
        limit: limit,
      );
      emit(HospitalLoaded(hospitals));
    } catch (e) {
      emit(HospitalError(e.toString()));
    }
  }
}
