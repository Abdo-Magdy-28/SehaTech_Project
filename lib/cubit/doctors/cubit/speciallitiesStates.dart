import 'package:equatable/equatable.dart';
import 'package:grad_project/models/doctor.dart';

abstract class SpecialitiesState extends Equatable {
  const SpecialitiesState();

  @override
  List<Object?> get props => [];
}

class SpecialitiesInitial extends SpecialitiesState {}

class SpecialitiesLoading extends SpecialitiesState {}

class SpecialitiesSuccess extends SpecialitiesState {
  final List<String> specialities;

  const SpecialitiesSuccess(this.specialities);

  @override
  List<Object?> get props => [specialities];
}

class SpecialitiesError extends SpecialitiesState {
  final String message;

  const SpecialitiesError(this.message);

  @override
  List<Object?> get props => [message];
}

// ── All doctors loaded from all specialities ──

class AllDoctorsLoading extends SpecialitiesState {
  final List<String> specialities;
  final int loadedCount;

  const AllDoctorsLoading({
    required this.specialities,
    required this.loadedCount,
  });

  double get progress =>
      specialities.isEmpty ? 0 : loadedCount / specialities.length;

  @override
  List<Object?> get props => [specialities, loadedCount];
}

class AllDoctorsSuccess extends SpecialitiesState {
  final List<String> specialities;
  final List<Doctor> doctors;

  const AllDoctorsSuccess({required this.specialities, required this.doctors});

  @override
  List<Object?> get props => [specialities, doctors];
}

class AllDoctorsError extends SpecialitiesState {
  final List<String> specialities;
  final String message;

  const AllDoctorsError({required this.specialities, required this.message});

  @override
  List<Object?> get props => [specialities, message];
}
