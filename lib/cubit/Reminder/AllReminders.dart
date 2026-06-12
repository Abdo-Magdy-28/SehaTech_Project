import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/Reminders/AllReminder.dart';
import 'package:grad_project/services/Reminder/ReminderService.dart';

abstract class AllRemindersState {}

class AllRemindersLoading extends AllRemindersState {}

class AllRemindersLoaded extends AllRemindersState {
  final List<AllReminderModel> reminders;
  AllRemindersLoaded(this.reminders);
}

class AllRemindersError extends AllRemindersState {
  final String message;
  AllRemindersError(this.message);
}

class AllRemindersCubit extends Cubit<AllRemindersState> {
  final ReminderService _service = ReminderService();
  AllRemindersCubit() : super(AllRemindersLoading());

  Future<void> loadReminders() async {
    try {
      emit(AllRemindersLoading());
      final reminders = await _service.getAllReminders();
      emit(AllRemindersLoaded(reminders));
    } catch (e) {
      emit(AllRemindersError(e.toString()));
    }
  }

  Future<void> deleteReminder(String id, AllReminderModel reminder) async {
    try {
      final currentList = state is AllRemindersLoaded
          ? (state as AllRemindersLoaded).reminders
          : <AllReminderModel>[];

      await _service.deleteReminder(id);

      // ── cancel all notifications for this reminder ──
      for (int i = 0; i < reminder.doseTimes.length; i++) {
        final uniqueId =
            (reminder.medicationName + i.toString()).hashCode.abs() %
            2147483647;
        await AwesomeNotifications().cancel(uniqueId);
      }

      final updated = currentList.where((r) => r.id != id).toList();
      emit(AllRemindersLoaded(updated));
    } catch (e) {
      emit(AllRemindersError(e.toString()));
    }
  }
}
