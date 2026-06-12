// cubit/auth/google_auth_state.dart
part of 'google_auth_cubit.dart';

abstract class GoogleAuthState {}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthSuccess extends GoogleAuthState {
  final Map<String, dynamic> data;
  GoogleAuthSuccess(this.data);
}

class GoogleAuthError extends GoogleAuthState {
  final String message;
  GoogleAuthError(this.message);
}
