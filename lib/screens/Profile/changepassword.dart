// ignore_for_file: implicit_call_tearoffs
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grad_project/cubit/profile/change%20password/changepasswordcubit.dart';
import 'package:grad_project/cubit/profile/change%20password/changepasswordstates.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/widgets/textformfield.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});
  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _currentpasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _currentpasswordFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  @override
  void dispose() {
    _currentpasswordController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _currentpasswordFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  /// ✅ بيترجم الـ messageKey الجاي من الـ cubit
  String _localizeError(BuildContext context, String key) {
    final s = S.of(context);
    switch (key) {
      case 'wrong_current_password':
        return s.wrongCurrentPassword;
      case 'passwords_not_match':
        return s.passwordnotmatch;
      case 'not_logged_in':
        return s.notLoggedIn;
      case 'no_internet':
        return s.noInternet;
      case 'network_error':
        return s.networkError;
      case 'unexpected_error':
        return s.unexpectedError;
      default:
        // لو جاء key مش متعرف عليه — نعرضه كما هو (fallback)
        return key;
    }
  }

  void _onSubmit(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<ChangePasswordCubit>().changePassword(
        currentPassword: _currentpasswordController.text.trim(),
        newPassword: _passwordController.text.trim(),
        confirmPassword: _confirmController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (_) => ChangePasswordCubit(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(S.of(context).passwordchangedsuccess),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pop(context);
          } else if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_localizeError(context, state.messageKey)),
                backgroundColor: Colors.red,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is ChangePasswordLoading;
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: devWidth * 0.06),
                child: Form(
                  key: formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: devHeight * 0.04),
                        Text(
                          S.of(context).changepassword,
                          style: TextStyle(
                            fontSize: devWidth * 0.06,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'Cairo',
                          ),
                        ),
                        SizedBox(height: devHeight * 0.01),
                        Text(S.of(context).enternewpassword),
                        SizedBox(height: devHeight * 0.04),
                        Textformfield(
                          controller: _currentpasswordController,
                          focusNode: _currentpasswordFocus,
                          hinttext: S.of(context).currentpassword,
                          ispassword: true,
                          validator: MultiValidator([
                            RequiredValidator(
                              errorText: S.of(context).currentpasswordrequiered,
                            ),
                            MinLengthValidator(
                              6,
                              errorText: S.of(context).passwordmustbeatleast,
                            ),
                          ]),
                          obsecure: true,
                          bordercolor: const Color(0xFFF3F1F7),
                          prefixicon:
                              "assets/images/teenyicons_password-outline.svg",
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(
                            context,
                          ).requestFocus(_passwordFocus),
                        ),
                        SizedBox(height: devHeight * 0.01),
                        Textformfield(
                          controller: _passwordController,
                          focusNode: _passwordFocus,
                          hinttext: S.of(context).newpassword,
                          ispassword: true,
                          validator: MultiValidator([
                            RequiredValidator(
                              errorText: S.of(context).newpasswordrequiered,
                            ),
                            MinLengthValidator(
                              6,
                              errorText: S.of(context).passwordmustbeatleast,
                            ),
                          ]),
                          obsecure: true,
                          bordercolor: const Color(0xFFF3F1F7),
                          prefixicon:
                              "assets/images/teenyicons_password-outline.svg",
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(
                            context,
                          ).requestFocus(_confirmFocus),
                        ),
                        SizedBox(height: devHeight * 0.01),
                        Textformfield(
                          controller: _confirmController,
                          focusNode: _confirmFocus,
                          hinttext: S.of(context).confirmpassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).confirmpasswordrequiered;
                            } else if (value != _passwordController.text) {
                              return S.of(context).passwordnotmatch;
                            }
                            return null;
                          },
                          obsecure: true,
                          ispassword: true,
                          bordercolor: const Color(0xFFF3F1F7),
                          prefixicon:
                              "assets/images/teenyicons_password-outline.svg",
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _onSubmit(context),
                        ),
                        SizedBox(height: devHeight * 0.04),
                        SizedBox(
                          width: double.infinity,
                          height: devHeight * 0.07,
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => _onSubmit(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2260FF),
                              disabledBackgroundColor: const Color(
                                0xFF2260FF,
                              ).withOpacity(0.6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : Text(
                                    S.of(context).finish,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: devWidth * 0.045,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: devHeight * 0.04),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
