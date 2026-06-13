import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/google_auth_service.dart';
import '../services/Authservice.dart';

abstract class GoogleAuthState {}

class GoogleAuthInitial extends GoogleAuthState {}

class GoogleAuthLoading extends GoogleAuthState {}

class GoogleAuthSuccess extends GoogleAuthState {
  final Map<String, dynamic> user;
  GoogleAuthSuccess(this.user);
}

class GoogleAuthFailure extends GoogleAuthState {
  final String message;
  GoogleAuthFailure(this.message);
}

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  final GoogleAuthService _service;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  GoogleAuthCubit(this._service) : super(GoogleAuthInitial());

  Future<void> signInWithGoogle() async {
    emit(GoogleAuthLoading());
    try {
      final data = await _service.signInWithGoogle();
      final idToken = data['idToken'] as String;

      if (idToken.isEmpty) {
        emit(GoogleAuthFailure('Failed to get Google ID token'));
        return;
      }

      // ✅ Send idToken to backend for verification
      final response = await AuthService().googleLogin(idToken: idToken);

      if (response.success) {
        emit(GoogleAuthSuccess(data['user']));
      } else {
        emit(GoogleAuthFailure(response.message));
      }
    } catch (e) {
      emit(GoogleAuthFailure(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _service.signOut();
    await _storage.delete(key: 'auth_token');
    await _storage.delete(key: 'user_data');
    emit(GoogleAuthInitial());
  }
}
