// ── healthmatrixstates.dart ───────────────────────────────────────────────────

import 'package:equatable/equatable.dart';
import 'package:grad_project/models/healthmatrixmodel.dart';

abstract class HealthMatrixState extends Equatable {
  const HealthMatrixState();

  @override
  List<Object?> get props => [];
}

/// Initial — nothing has happened yet
class HealthMatrixInitial extends HealthMatrixState {
  const HealthMatrixInitial();
}

/// Fetching / submitting in progress
class HealthMatrixLoading extends HealthMatrixState {
  const HealthMatrixLoading();
}

/// Data loaded successfully
class HealthMatrixLoaded extends HealthMatrixState {
  final HealthMatrixModel data;
  const HealthMatrixLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

/// Record does not exist yet — show the create form
class HealthMatrixNotFound extends HealthMatrixState {
  const HealthMatrixNotFound();
}

/// Create / update submitted and confirmed
class HealthMatrixSaved extends HealthMatrixState {
  final HealthMatrixModel data;
  const HealthMatrixSaved(this.data);

  @override
  List<Object?> get props => [data];
}

/// 401 — token expired or invalid, redirect to login
class HealthMatrixUnauthorized extends HealthMatrixState {
  const HealthMatrixUnauthorized();
}

/// Any network / server error
class HealthMatrixError extends HealthMatrixState {
  final String message;
  const HealthMatrixError(this.message);

  @override
  List<Object?> get props => [message];
}
