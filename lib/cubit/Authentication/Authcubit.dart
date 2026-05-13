import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Authentication/Authstates.dart';
import 'package:grad_project/models/user.dart';
import 'package:grad_project/services/Authservice.dart';

class Authcubit extends Cubit<Authstates> {
  Authcubit() : super(nothingstate());
  String? firstname,
      lastname,
      email,
      password,
      confirmpassword,
      username,
      role,
      gender,
      phone;

  User? user;

  Future signup() async {
    emit(loadingstate());

    final response = await AuthService().signup(
      firstname: firstname!,
      lastname: lastname!,
      email: email!,
      gender: gender!,
      confirmpassword: confirmpassword!,
      password: password!,
      phone: phone!,
      role: role!,
      username: username!,
    );
    if (response.success) {
      emit(successstate());
    } else {
      emit(errorstate());
    }
    return response;
  }

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    emit(loadingstate());

    final response = await AuthService().login(
      email: email,
      password: password,
    );

    if (response.success) {
      emit(successstate());
    } else {
      emit(errorstate());
    }

    return response;
  }

  Future checkToken(String code) async {
    emit(loadingstate());

    final result = await AuthService().checkToken(Token: code);

    if (result.success) {
      emit(successstate());
    } else {
      emit(errorstate());
    }
  }

  Future resetpassword({
    required String code,
    required String password,
    required String confirmpassword,
  }) async {
    emit(loadingstate());

    final response = await AuthService().resetPassword(
      code: code,
      password: password,
      confirmPassword: confirmpassword,
    );

    if (response.success) {
      emit(successstate());
    } else {
      emit(errorstate());
    }

    return response;
  }

  Future forgotpassword({required String email}) async {
    emit(loadingstate());
    final response = await AuthService().forgotPassword(email: email);
    if (response.success) {
      emit(successstate());
    } else {
      emit(errorstate());
    }
    return response;
  }
}
