import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/Reminders/DailyReminder.dart';
import 'package:grad_project/services/reminder/DailyMedications.dart';

abstract class DailyScheduleState {}

class DailyScheduleInitial extends DailyScheduleState {}

class DailyScheduleLoading extends DailyScheduleState {}

class DailyScheduleLoaded extends DailyScheduleState {
  final List<DailyMedications> medications;
  DailyScheduleLoaded(this.medications);
}

class DailyScheduleError extends DailyScheduleState {
  final String message;
  DailyScheduleError(this.message);
}

class DailyScheduleCubit extends Cubit<DailyScheduleState> {
  final DailyScheduleService _service = DailyScheduleService();

  DailyScheduleCubit() : super(DailyScheduleInitial());

  Future<void> loadSchedule(DateTime date) async {
    emit(DailyScheduleLoading());

    final formatted =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    try {
      final meds = await _service.fetchDailySchedule(formatted);
      emit(DailyScheduleLoaded(meds));
    } catch (e) {
      emit(
        DailyScheduleError(
          "Failed to load medications for $formatted\nDetails: $e",
        ),
      );
    }
  }
}
