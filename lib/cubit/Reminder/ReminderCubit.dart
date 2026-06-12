import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/Reminders/AllReminder.dart';
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
        await _scheduleNotifications(reminder);
        emit(ReminderSuccess());
      } else {
        emit(ReminderError("Failed to create reminder"));
      }
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }

  Future<void> _scheduleNotifications(MedicationReminder reminder) async {
    final endDate = DateTime.tryParse(reminder.endDate);
    if (endDate == null) return;

    for (int i = 0; i < reminder.doseTimes.length; i++) {
      final doseTime = reminder.doseTimes[i]; // DoseTime object
      final parts = doseTime.time.split(':'); // time is a String field
      if (parts.length < 2) continue;

      final hour = int.tryParse(parts[0]);
      final minute = int.tryParse(parts[1]);
      if (hour == null || minute == null) continue;

      final uniqueId =
          (reminder.medicationName + i.toString()).hashCode.abs() % 2147483647;

      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: uniqueId,
          channelKey: 'medication_channel',
          title: 'Time to take ${reminder.medicationName}',
          body:
              'Dosage: ${doseTime.dosage} at ${doseTime.time}', // dosage from DoseTime
        ),
        schedule: NotificationCalendar(
          hour: hour,
          minute: minute,
          second: 0,
          repeats: true,
          preciseAlarm: true,
        ),
      );

      _cancelOnEndDate(uniqueId, endDate, hour, minute);
    }
  }

  void _cancelOnEndDate(int id, DateTime endDate, int hour, int minute) {
    final now = DateTime.now();
    final cancelAt = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      hour,
      minute,
    );
    if (cancelAt.isAfter(now)) {
      final delay = cancelAt.difference(now);
      Future.delayed(delay, () {
        AwesomeNotifications().cancel(id);
      });
    }
  }

  Future<void> _cancelReminderNotifications(AllReminderModel reminder) async {
    for (int i = 0; i < reminder.doseTimes.length; i++) {
      final uniqueId =
          (reminder.medicationName + i.toString()).hashCode.abs() % 2147483647;
      await AwesomeNotifications().cancel(uniqueId);
    }
  }

  Future<void> updateReminder(
    String id,
    MedicationReminder reminder,
    AllReminderModel oldReminder,
  ) async {
    emit(ReminderLoading());
    try {
      final ok = await _service.updateReminder(id, reminder);
      if (ok) {
        // ── cancel old notifications ──
        for (int i = 0; i < oldReminder.doseTimes.length; i++) {
          final uniqueId =
              (oldReminder.medicationName + i.toString()).hashCode.abs() %
              2147483647;
          await AwesomeNotifications().cancel(uniqueId);
        }

        // ── schedule new notifications ──
        await _scheduleNotifications(reminder);

        emit(ReminderSuccess());
      } else {
        emit(ReminderError("Failed to update reminder"));
      }
    } catch (e) {
      emit(ReminderError(e.toString()));
    }
  }
}
