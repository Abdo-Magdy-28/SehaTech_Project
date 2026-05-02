// cubit/search_doctor_cubit.dart

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_state.dart';
import 'package:grad_project/services/search%20services/doctors/search_service.dart';

class SearchDoctorCubit extends Cubit<SearchDoctorState> {
  final SearchService searchService;
  Timer? _debounce;

  SearchDoctorCubit({required this.searchService})
    : super(SearchDoctorInitial());

  void onSearchChanged(String query) {
    _debounce?.cancel();

    if (query.trim().isEmpty) {
      emit(SearchDoctorInitial());
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      searchDoctors(query);
    });
  }

  Future<void> searchDoctors(String query) async {
    emit(SearchDoctorLoading());

    try {
      final doctors = await searchService.searchDoctors(query);

      if (doctors.isEmpty) {
        emit(SearchDoctorEmpty());
      } else {
        emit(SearchDoctorSuccess(doctors));
      }
    } catch (e) {
      emit(SearchDoctorError(e.toString()));
    }
  }

  void clearSearch() {
    emit(SearchDoctorInitial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
