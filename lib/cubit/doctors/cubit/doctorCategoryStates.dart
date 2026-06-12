import 'package:equatable/equatable.dart';
import 'package:grad_project/models/doctor.dart';

abstract class CategoryDoctorsState extends Equatable {
  const CategoryDoctorsState();

  @override
  List<Object?> get props => [];
}

class CategoryDoctorsInitial extends CategoryDoctorsState {}

class CategoryDoctorsLoading extends CategoryDoctorsState {}

class CategoryDoctorsSuccess extends CategoryDoctorsState {
  final List<Doctor> doctors;
  final List<Doctor> filtered;

  const CategoryDoctorsSuccess({required this.doctors, required this.filtered});

  @override
  List<Object?> get props => [doctors, filtered];
}

class CategoryDoctorsEmpty extends CategoryDoctorsState {}

class CategoryDoctorsError extends CategoryDoctorsState {
  final String message;

  const CategoryDoctorsError(this.message);

  @override
  List<Object?> get props => [message];
}
