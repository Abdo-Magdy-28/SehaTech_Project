import 'package:equatable/equatable.dart';
import 'package:grad_project/models/pharmacies.dart';

abstract class PharmacyState extends Equatable {
  const PharmacyState();

  @override
  List<Object?> get props => [];
}

class PharmacyInitial extends PharmacyState {}

class PharmacyLoading extends PharmacyState {}

class PharmacyLoaded extends PharmacyState {
  final List<Pharmacy> pharmacies;
  final bool isSearching;

  const PharmacyLoaded({required this.pharmacies, this.isSearching = false});

  @override
  List<Object?> get props => [pharmacies, isSearching];
}

class PharmacyError extends PharmacyState {
  final String message;

  const PharmacyError(this.message);

  @override
  List<Object?> get props => [message];
}

class PharmacySearchEmpty extends PharmacyState {
  const PharmacySearchEmpty();
}
