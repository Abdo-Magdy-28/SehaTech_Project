import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/cubit/doctorCategoryStates.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/services/search%20services/doctors/speciallitiesService.dart';

class CategoryDoctorsCubit extends Cubit<CategoryDoctorsState> {
  final SpecialitiesService specialitiesService;
  List<Doctor> _allDoctors = [];

  CategoryDoctorsCubit({required this.specialitiesService})
    : super(CategoryDoctorsInitial());

  Future<void> loadDoctors(String speciality) async {
    emit(CategoryDoctorsLoading());
    try {
      final raw = await specialitiesService.fetchDoctorsBySpeciality(
        speciality,
      );
      final doctors = raw.map((json) => Doctor.fromJson(json)).toList();
      _allDoctors = doctors;

      if (doctors.isEmpty) {
        emit(CategoryDoctorsEmpty());
      } else {
        emit(CategoryDoctorsSuccess(doctors: doctors, filtered: doctors));
      }
    } catch (e) {
      emit(CategoryDoctorsError(e.toString()));
    }
  }

  void filterDoctors(String query) {
    if (state is! CategoryDoctorsSuccess) return;

    if (query.trim().isEmpty) {
      emit(CategoryDoctorsSuccess(doctors: _allDoctors, filtered: _allDoctors));
      return;
    }

    final q = query.toLowerCase();
    final filtered = _allDoctors
        .where(
          (d) =>
              d.name.toLowerCase().contains(q) ||
              d.hospital.toLowerCase().contains(q) ||
              d.job.toLowerCase().contains(q),
        )
        .toList();

    if (filtered.isEmpty) {
      emit(CategoryDoctorsSuccess(doctors: _allDoctors, filtered: []));
    } else {
      emit(CategoryDoctorsSuccess(doctors: _allDoctors, filtered: filtered));
    }
  }

  void retry(String speciality) => loadDoctors(speciality);
}
