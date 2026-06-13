import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/google_auth_service.dart';

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

      // ✅ Save idToken as auth_token
      await _storage.write(key: 'auth_token', value: data['idToken']);

      // ✅ Save user data as JSON string
      await _storage.write(
        key: 'Google_user_data',
        value: data['user'].toString(), // or jsonEncode(data['user'])
      );
      print(data['idToken']);
      emit(GoogleAuthSuccess(data['user']));
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
