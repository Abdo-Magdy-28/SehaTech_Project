import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Authstates.dart';
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
    try {
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
      if (response.statusCode == 201) {
        emit(successstate());
        return response;
      } else {
        emit(errorstate());
      }
    } on DioException catch (e) {
      print('Dio error: ${e.message}');
      print('Response data: ${e.response?.data}');
      emit(errorstate());
    } catch (e) {
      print('Error: $e');
      emit(errorstate());
    }
  }

  Future login({required String email, required String password}) async {
    emit(loadingstate());

    final response = await AuthService().login(
      email: email,
      password: password,
    );
    emit(successstate());
    return response;
  }

  Future checkToken({required String code}) async {
    emit(loadingstate());
    final response = await AuthService().checkToken(Token: code);
    emit(successstate());
    return response;
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
      confirmpassword: confirmpassword,
    );
    emit(successstate());
    return response;
  }

  Future forgotpassword({required String email}) async {
    emit(loadingstate());
    final response = await AuthService().forgotPassword(email: email);
    emit(successstate());
    return response;
  }
}
