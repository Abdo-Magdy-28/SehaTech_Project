import 'package:grad_project/models/doctor.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<Doctor> doctors;
  DoctorLoaded(this.doctors);
}

class DoctorEmpty extends DoctorState {}

class DoctorError extends DoctorState {
  final String message;
  DoctorError(this.message);
}
