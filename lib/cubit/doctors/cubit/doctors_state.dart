// cubit/search_doctor_state.dart

import 'package:equatable/equatable.dart';
import 'package:grad_project/models/doctor.dart';

abstract class SearchDoctorState extends Equatable {
  const SearchDoctorState();

  @override
  List<Object?> get props => [];
}

class SearchDoctorInitial extends SearchDoctorState {}

class SearchDoctorLoading extends SearchDoctorState {}

class SearchDoctorSuccess extends SearchDoctorState {
  final List<Doctor> doctors;

  const SearchDoctorSuccess(this.doctors);

  @override
  List<Object?> get props => [doctors];
}

class SearchDoctorEmpty extends SearchDoctorState {}

class SearchDoctorError extends SearchDoctorState {
  final String message;

  const SearchDoctorError(this.message);

  @override
  List<Object?> get props => [message];
}
