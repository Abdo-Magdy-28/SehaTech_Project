import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/medication_reminder.dart';
import 'package:grad_project/services/reminder/ReminderService.dart';

abstract class ReminderState {}

class ReminderInitial extends ReminderState {}

class ReminderLoading extends ReminderState {}

class ReminderSuccess extends ReminderState {}

class ReminderError extends ReminderState {
  final String message;
  ReminderError(this.message);
}

class ReminderCubit extends Cubit<ReminderState> {
  final ReminderService _service = ReminderService();

  ReminderCubit() : super(ReminderInitial());

  Future<void> submitReminder(MedicationReminder reminder) async {
    emit(ReminderLoading());
    try {
      final ok = await _service.createReminder(reminder);
      if (ok) {
        emit(ReminderSuccess());
      } else {
        emit(ReminderError("Failed to create reminder"));
      }
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }
}
