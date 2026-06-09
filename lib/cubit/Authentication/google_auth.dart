import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/services/google_auth_service.dart';

// ── States ──────────────────────────────
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

// ── Cubit ───────────────────────────────
class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final GoogleAuthService _service = GoogleAuthService();

  GoogleAuthCubit() : super(GoogleAuthInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleAuthLoading());
    try {
      final data = await _service.signInWithGoogle();
      emit(GoogleAuthSuccess(data));
    } catch (e) {
      emit(GoogleAuthError('Sign in failed. Please try again.'));
    }
  }

  Future<void> signOut() async {
    await _service.signOut();
    emit(GoogleAuthInitial());
  }

  Future<void> checkSignedIn() async {
    final account = await _service.getCurrentUser();
    if (account != null) {
      // Optionally call backend again to refresh token
      emit(GoogleAuthSuccess({'email': account.email}));
    } else {
      emit(GoogleAuthInitial());
    }
  }
}
