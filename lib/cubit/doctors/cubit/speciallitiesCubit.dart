import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/doctors/cubit/speciallitiesStates.dart';
import 'package:grad_project/models/doctor.dart';
import 'package:grad_project/services/search%20services/doctors/speciallitiesService.dart';

class SpecialitiesCubit extends Cubit<SpecialitiesState> {
  final SpecialitiesService specialitiesService;

  SpecialitiesCubit({required this.specialitiesService})
    : super(SpecialitiesInitial());

  /// Loads specialities first, then fetches all doctors from every speciality.
  Future<void> loadAllDoctors() async {
    emit(SpecialitiesLoading());

    List<String> specialities;

    try {
      specialities = await specialitiesService.fetchSpecialities();
    } catch (e) {
      emit(SpecialitiesError(e.toString()));
      return;
    }

    if (specialities.isEmpty) {
      emit(AllDoctorsSuccess(specialities: [], doctors: []));
      return;
    }

    final allDoctors = <Doctor>[];
    int loaded = 0;

    for (final spec in specialities) {
      if (isClosed) return;

      emit(AllDoctorsLoading(specialities: specialities, loadedCount: loaded));

      try {
        final raw = await specialitiesService.fetchDoctorsBySpeciality(spec);
        allDoctors.addAll(raw.map((json) => Doctor.fromJson(json)));
      } catch (_) {
        // Skip failing specialities silently — partial results are better than none
      }

      loaded++;
    }

    if (isClosed) return;

    emit(AllDoctorsSuccess(specialities: specialities, doctors: allDoctors));
  }

  void retry() => loadAllDoctors();
}
