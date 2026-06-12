import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/Reminders/DailyReminder.dart';
import 'package:grad_project/services/reminder/DailyMedications.dart';

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

  DateTime selectedDate = DateTime.now();

  DailyScheduleCubit() : super(DailyScheduleInitial());

  bool get _isToday {
    final now = DateTime.now();
    return selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day;
  }

  String _formatDate(DateTime date) =>
      "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

  Future<void> loadSchedule(DateTime date) async {
    selectedDate = date;
    emit(DailyScheduleLoading());
    try {
      final meds = await _service.fetchDailySchedule(_formatDate(date));
      emit(DailyScheduleLoaded(meds));
    } catch (e) {
      emit(
        DailyScheduleError(
          "Failed to load medications for ${_formatDate(date)}\nDetails: $e",
        ),
      );
    }
  }

  List<DailyMedications> getUpcomingForToday(List<DailyMedications> meds) {
    final now = DateTime.now();

    final pending = meds.where((med) {
      final parts = med.time.split(':');
      if (parts.length < 2) return false;

      // For today: only show future times
      // For past days: show all pending regardless of time
      if (_isToday) {
        final medTime = DateTime(
          now.year,
          now.month,
          now.day,
          int.parse(parts[0]),
          int.parse(parts[1]),
        );
        return medTime.isAfter(now) && med.status != "taken";
      } else {
        return med.status != "taken"; // just filter by status
      }
    }).toList();

    pending.sort((a, b) {
      final aParts = a.time.split(':');
      final bParts = b.time.split(':');
      final aTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(aParts[0]),
        int.parse(aParts[1]),
      );
      final bTime = DateTime(
        now.year,
        now.month,
        now.day,
        int.parse(bParts[0]),
        int.parse(bParts[1]),
      );
      return aTime.compareTo(bTime);
    });

    return pending;
  }

  Future<void> markTaken(DailyMedications med, DateTime date) async {
    emit(MarkingTaken());
    try {
      await _service.markMedicationTaken(
        med.reminderId,
        med.time,
        _formatDate(date),
      );
      await loadSchedule(date);
    } catch (e) {
      emit(DailyScheduleError("Failed to mark as taken: $e"));
    }
  }
}
