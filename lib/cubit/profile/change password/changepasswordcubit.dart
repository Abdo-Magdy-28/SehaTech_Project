import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/cubit/profile/change%20password/changepasswordstates.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(ChangePasswordLoading());

    try {
      final token = await _storage.read(key: 'auth_token');

      if (token == null || token.isEmpty) {
        emit(const ChangePasswordFailure(messageKey: 'not_logged_in'));
        return;
      }

      final response = await _dio.patch(
        '$apiurl/api/users/updateMyPassword',
        data: {
          'passwordCurrent': currentPassword,
          'password': newPassword,
          'passwordConfirm': confirmPassword,
        },
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
          validateStatus: (status) => status != null && status < 500,
        ),
      );

      final data = response.data as Map<String, dynamic>;
      final status = data['status'] as String?;

      if (status == 'success') {
        final newToken = data['token'] as String? ?? '';
        await _storage.write(key: 'auth_token', value: newToken);

        final userDataString = await _storage.read(key: 'user_data');
        if (userDataString != null) {
          final userData = jsonDecode(userDataString) as Map<String, dynamic>;
          userData['token'] = newToken;
          await _storage.write(key: 'user_data', value: jsonEncode(userData));
        }

        emit(ChangePasswordSuccess(token: newToken));
      } else {
        // ✅ بنحول الـ raw message لـ key معروف
        final rawMessage = data['message'] as String? ?? '';
        emit(ChangePasswordFailure(messageKey: _mapToKey(rawMessage)));
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.error is SocketException) {
        emit(const ChangePasswordFailure(messageKey: 'no_internet'));
      } else {
        emit(const ChangePasswordFailure(messageKey: 'network_error'));
      }
    } catch (_) {
      emit(const ChangePasswordFailure(messageKey: 'unexpected_error'));
    }
  }

  /// بيحول الـ backend message لـ key ثابت نقدر نترجمه
  String _mapToKey(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('current password') && lower.contains('wrong')) {
      return 'wrong_current_password';
    }
    if (lower.contains('passwords are not the same') ||
        lower.contains('password') && lower.contains('not match')) {
      return 'passwords_not_match';
    }
    if (lower.contains('not logged in') || lower.contains('unauthorized')) {
      return 'not_logged_in';
    }
    // fallback: نرجع الـ message كما هي كـ key
    return raw;
  }
}
