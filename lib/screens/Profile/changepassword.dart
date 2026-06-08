// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grad_project/cubit/Authentication/Authcubit.dart';
import 'package:grad_project/screens/Homepage.dart';
import 'package:grad_project/widgets/textformfield.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key, required this.password});
  final String password;
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
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;
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
          reverse: false,
          child: Form(
            key: formKey,
            child: Center(
              child: Form(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: devHeight * 0.04),
                    Text(
                      "Change Password",
                      style: TextStyle(
                        fontSize: devWidth * 0.06,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: devHeight * 0.01),
                    Text("Enter your new password"),
                    SizedBox(height: devHeight * 0.04),
                    Textformfield(
                      controller: _currentpasswordController,
                      focusNode: _currentpasswordFocus,
                      hinttext: 'Current Password',
                      ispassword: true,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Password required"),
                        MinLengthValidator(
                          6,
                          errorText: 'Password must be at least 6 characters',
                        ),
                      ]),
                      obsecure: true,
                      bordercolor: const Color(0xFFF3F1F7),
                      prefixicon:
                          "assets/images/teenyicons_password-outline.svg",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_passwordFocus),
                    ),
                    SizedBox(height: devHeight * 0.01),

                    Textformfield(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      hinttext: 'New Password',
                      ispassword: true,
                      validator: MultiValidator([
                        RequiredValidator(errorText: "Password required"),
                        MinLengthValidator(
                          6,
                          errorText: 'Password must be at least 6 characters',
                        ),
                      ]),
                      obsecure: true,
                      bordercolor: const Color(0xFFF3F1F7),
                      prefixicon:
                          "assets/images/teenyicons_password-outline.svg",
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_confirmFocus),
                    ),
                    SizedBox(height: devHeight * 0.01),

                    // Confirm Password
                    Textformfield(
                      controller: _confirmController,
                      focusNode: _confirmFocus,
                      hinttext: 'Confirm Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      obsecure: true,
                      ispassword: true,
                      bordercolor: const Color(0xFFF3F1F7),
                      prefixicon:
                          "assets/images/teenyicons_password-outline.svg",

                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => {},
                    ),
                    SizedBox(height: devHeight * 0.04),

                    SizedBox(
                      width: double.infinity,
                      height: devHeight * 0.07,
                      child: ElevatedButton(
                        onPressed: () async {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2260FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Finish',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: devWidth * 0.045,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
