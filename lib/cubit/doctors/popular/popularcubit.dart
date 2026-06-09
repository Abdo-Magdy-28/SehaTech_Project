import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/popular/popular_states.dart';
import 'package:grad_project/services/search services/doctors/search_service.dart';

class DoctorCubit extends Cubit<DoctorState> {
  DoctorCubit() : super(DoctorInitial());

  Future<void> loadDoctors() async {
    final SearchService service = SearchService();
    emit(DoctorLoading());
    try {
      final doctors = await service.fetchDoctors();
      emit(DoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError(e.toString())); // show error in UI
    }
  }
}
