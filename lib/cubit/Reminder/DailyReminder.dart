import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/Reminders/DailyReminder.dart';
import 'package:grad_project/services/reminder/DailyMedications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

abstract class DailyScheduleState {}

class MarkingTaken extends DailyScheduleState {}

class MarkedTaken extends DailyScheduleState {}

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

  List<DailyMedications> getUpcomingForToday() {
    if (state is! DailyScheduleLoaded) return [];

    final meds = (state as DailyScheduleLoaded).medications;
    final now = DateTime.now();

    final pending = meds.where((med) {
      final parts = med.time.split(':');
      final medDate = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(parts[0]),
        int.parse(parts[1]),
      );
      return medDate.isAfter(now) && med.status != "taken";
    }).toList();

    pending.sort((a, b) {
      final aParts = a.time.split(':');
      final bParts = b.time.split(':');
      final aDate = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(aParts[0]),
        int.parse(aParts[1]),
      );
      final bDate = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(bParts[0]),
        int.parse(bParts[1]),
      );
      return aDate.compareTo(bDate);
    });

    return pending;
  }

  Future<void> markTaken(DailyMedications med, DateTime date) async {
    emit(MarkingTaken());
    try {
      await _service.markMedicationTaken(
        med.reminderId,
        med.time,
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      );

      await loadSchedule(date);
    } catch (e) {
      emit(DailyScheduleError("Failed to mark as taken: $e"));
    }
  }
}
