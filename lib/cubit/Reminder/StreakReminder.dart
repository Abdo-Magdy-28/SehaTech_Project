import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/models/Reminders/StreakReminderModel.dart';
import 'package:grad_project/services/reminder/StreakReminder.dart';

abstract class StreakState {}

class StreakInitial extends StreakState {}

class StreakLoading extends StreakState {}

class StreakLoaded extends StreakState {
  final StreakModel streak;
  StreakLoaded(this.streak);
}

class StreakError extends StreakState {
  final String message;
  StreakError(this.message);
}

class StreakCubit extends Cubit<StreakState> {
  final StreakService _service = StreakService();

  StreakCubit() : super(StreakInitial());

  Future<void> loadStreak() async {
    emit(StreakLoading());
    try {
      final streak = await _service.fetchStreak();
      emit(StreakLoaded(streak));
    } catch (e) {
      emit(StreakError(e.toString()));
    }
  }
}
