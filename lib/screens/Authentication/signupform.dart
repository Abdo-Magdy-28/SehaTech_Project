// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grad_project/cubit/Authentication/Authcubit.dart';
import 'package:grad_project/cubit/Authentication/Authstates.dart';
import 'package:grad_project/cubit/Reminder/DailyReminder.dart';
import 'package:grad_project/cubit/doctors/popular/popularcubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Authentication/signin.dart';
import 'package:grad_project/screens/Homepage.dart';
import 'package:grad_project/widgets/textformfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signupform extends StatefulWidget {
  const Signupform({super.key});

  @override
  State<Signupform> createState() => _SignupformState();
}

class _SignupformState extends State<Signupform> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _firstFocus = FocusNode();
  final _lastFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();
  final _userNameFocus = FocusNode();
  final _phoneNumberFocus = FocusNode();

  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  String? selectedGender;

  @override
  void dispose() {
    _firstFocus.dispose();
    _lastFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _userNameFocus.dispose();
    _phoneNumberFocus.dispose();

    _firstController.dispose();
    _lastController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _userNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<Authcubit, Authstates>(
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is loadingstate,
          progressIndicator: const CircularProgressIndicator(
            color: Color(0xFF2260FF),
          ),
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            extendBodyBehindAppBar: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              shadowColor: Colors.transparent,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: devWidth * 0.06),
                reverse: true, // ensures bottom field stays visible
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: devHeight * 0.02),
                      Text(
                        S.of(context).signup,
                        style: TextStyle(
                          fontSize: devWidth * 0.08,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo',
                        ),
                      ),
                      SizedBox(height: devHeight * 0.04),

                      // First Name
                      Textformfield(
                        controller: _firstController,
                        focusNode: _firstFocus,
                        hinttext: S.of(context).firstname,
                        validator: RequiredValidator(
                          errorText: S.of(context).firstnamerequired,
                        ),
                        bordercolor: const Color(0xFFF3F1F7),
                        prefixicon: "assets/images/iconamoon_profile-light.svg",
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_lastFocus),
                      ),

                      // Last Name
                      Textformfield(
                        controller: _lastController,
                        focusNode: _lastFocus,
                        hinttext: S.of(context).lastname,
                        validator: RequiredValidator(
                          errorText: S.of(context).lastnamerequired,
                        ),
                        bordercolor: const Color(0xFFF3F1F7),
                        prefixicon: "assets/images/iconamoon_profile-light.svg",
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) =>
                            FocusScope.of(context).requestFocus(_userNameFocus),
                      ),

                      // Username
                      Padding(
                        padding: EdgeInsets.only(top: devHeight * 0.01),
                        child: Textformfield(
                          focusNode: _userNameFocus,
                          controller: _userNameController,
                          validator: RequiredValidator(
                            errorText: S.of(context).usernamerequired,
                          ),
                          hinttext: S.of(context).username,
                          bordercolor: const Color(0xFFF3F1F7),
                          prefixicon:
                              "assets/images/iconamoon_profile-light.svg",
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) =>
                              FocusScope.of(context).requestFocus(_emailFocus),
                        ),
                      ),

                      // Email
                      Textformfield(
                        controller: _emailController,
                        focusNode: _emailFocus,
                        hinttext: S.of(context).email,
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: S.of(context).emailrequired,
                          ),
                          EmailValidator(
                            errorText: S.of(context).emailisnotvalid,
                          ),
                        ]),
                        bordercolor: const Color(0xFFF3F1F7),
                        prefixicon: "assets/images/carbon_email.svg",
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) => FocusScope.of(
                          context,
                        ).requestFocus(_phoneNumberFocus),
                      ),

                      // Phone Number
                      Padding(
                        padding: EdgeInsets.only(top: devHeight * 0.01),
                        child: Textformfield(
                          focusNode: _phoneNumberFocus,
                          controller: _phoneNumberController,
                          validator: MultiValidator([
                            RequiredValidator(
                              errorText: S.of(context).phonenumberrequired,
                            ),
                            MinLengthValidator(
                              11,
                              errorText: S.of(context).mustbe11numbers,
                            ),
                            PatternValidator(
                              r'^01[0-9]+$',
                              errorText: S.of(context).invaliphonenumber,
                            ),
                            MaxLengthValidator(
                              11,
                              errorText: S.of(context).mustbe11numbers,
                            ),
                          ]),
                          hinttext: S.of(context).phonenumber,
                          bordercolor: const Color(0xFFF3F1F7),
                          prefixicon: "assets/images/carbon_phone.svg",
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) => FocusScope.of(
                            context,
                          ).requestFocus(_passwordFocus),
                        ),
                      ),

                      // Password
                      Textformfield(
                        controller: _passwordController,
                        focusNode: _passwordFocus,
                        hinttext: S.of(context).password,
                        ispassword: true,
                        validator: MultiValidator([
                          RequiredValidator(
                            errorText: S.of(context).passwordrequired,
                          ),
                          MinLengthValidator(
                            8,
                            errorText: S.of(context).passwordmustbeatleast,
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

                      // Confirm Password
                      Textformfield(
                        controller: _confirmController,
                        focusNode: _confirmFocus,
                        hinttext: S.of(context).confirmpassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).confirmpasswordrequired;
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
                      ),

                      // Gender
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Radio<String>(
                            value: "male",
                            groupValue: selectedGender,
                            onChanged: (value) =>
                                setState(() => selectedGender = value),
                          ),
                          Text(S.of(context).male),
                          Radio<String>(
                            value: "female",
                            groupValue: selectedGender,
                            onChanged: (value) =>
                                setState(() => selectedGender = value),
                          ),
                          Text(S.of(context).female),
                        ],
                      ),

                      SizedBox(height: devHeight * 0.02),
                      Hero(
                        tag: S.of(context).first,
                        child: SizedBox(
                          width: double.infinity,
                          height: devHeight * 0.07,
                          child: ElevatedButton(
                            onPressed: state is loadingstate
                                ? null
                                : () async {
                                    if (!formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            S.of(context).plsfixformerrors,
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    if (selectedGender == null) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            S.of(context).plsfixformerrors,
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    FocusScope.of(context).unfocus();

                                    final authCubit =
                                        BlocProvider.of<Authcubit>(context);
                                    authCubit.firstname = _firstController.text
                                        .trim();
                                    authCubit.lastname = _lastController.text
                                        .trim();
                                    authCubit.email = _emailController.text
                                        .trim();
                                    authCubit.password =
                                        _passwordController.text;
                                    authCubit.confirmpassword =
                                        _confirmController.text;
                                    authCubit.username = _userNameController
                                        .text
                                        .trim();
                                    authCubit.phone = _phoneNumberController
                                        .text
                                        .trim();
                                    authCubit.gender = selectedGender;
                                    authCubit.role = "patient";

                                    final response = await authCubit.signup();

                                    if (!mounted) return;

                                    if (response.success) {
                                      final today = DateTime.now();
                                      context.read<DoctorCubit>().loadDoctors();
                                      context
                                          .read<DailyScheduleCubit>()
                                          .loadSchedule(today);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Homepage(),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(response.message),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2260FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: state is loadingstate
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    S.of(context).signup,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: devWidth * 0.045,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'Cairo',
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: devHeight * 0.01),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(S.of(context).alreadyhaveanaccount),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  PageRouteBuilder(
                                    transitionDuration: const Duration(
                                      milliseconds: 800,
                                    ),
                                    reverseTransitionDuration: const Duration(
                                      milliseconds: 500,
                                    ),
                                    pageBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                        ) => const Signin(),
                                    transitionsBuilder:
                                        (
                                          context,
                                          animation,
                                          secondaryAnimation,
                                          child,
                                        ) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                              ),
                              child: Text(
                                S.of(context).signin,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: devWidth * 0.04,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: devHeight * 0.02),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
