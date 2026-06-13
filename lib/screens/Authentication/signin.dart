// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/cubit/Authentication/Authcubit.dart';
import 'package:grad_project/cubit/Authentication/Authstates.dart';
import 'package:grad_project/cubit/Reminder/DailyReminder.dart';
import 'package:grad_project/cubit/doctors/popular/popularcubit.dart';
import 'package:grad_project/cubit/google_auth.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Authentication/signupform.dart';
import 'package:grad_project/screens/Authentication/signupscreen2.dart';
import 'package:grad_project/screens/Authentication/verifyidentity.dart';
import 'package:grad_project/screens/Homepage.dart';
import 'package:grad_project/widgets/textformfield.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String Email, Password;
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<Authcubit, Authstates>(
      builder: (context, state) {
        return Scaffold(
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
                      S.of(context).signin,
                      style: TextStyle(
                        fontSize: devWidth * 0.08,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    SizedBox(height: devHeight * 0.04),

                    // Email
                    Textformfield(
                      controller: _emailController,
                      focusNode: _emailFocus,
                      hinttext: S.of(context).email,
                      onchange: (value) {
                        Email = value;
                      },
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
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_passwordFocus),
                    ),

                    // Password
                    Textformfield(
                      controller: _passwordController,
                      focusNode: _passwordFocus,
                      hinttext: S.of(context).password,
                      ispassword: true,
                      onchange: (value) {
                        Password = value;
                      },
                      validator: MultiValidator([
                        RequiredValidator(
                          errorText: S.of(context).passwordrequired,
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
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _submitForm(),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Verifyidentity();
                                  },
                                ),
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              minimumSize: Size.zero,
                            ),
                            child: Text(
                              S.of(context).forgotpassword,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize:
                                    devWidth *
                                    0.04, // ✅ Added responsive font size
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Hero(
                      tag: S.of(context).first,
                      child: SizedBox(
                        width: double.infinity,
                        height: devHeight * 0.07,
                        child: ElevatedButton(
                          onPressed: state is loadingstate
                              ? null // ✅ Disable button while loading
                              : () async {
                                  // ✅ Validate form first
                                  if (!formKey.currentState!.validate()) {
                                    return;
                                  }

                                  // ✅ Hide keyboard
                                  FocusScope.of(context).unfocus();

                                  try {
                                    final response =
                                        await BlocProvider.of<Authcubit>(
                                          context,
                                        ).login(
                                          email: _emailController.text.trim(),
                                          password: _passwordController.text,
                                        );

                                    //✅  Check if widget is still mounted
                                    if (!mounted) return;

                                    if (response.success) {
                                      final today = DateTime.now();
                                      context.read<DoctorCubit>().loadDoctors();
                                      context
                                          .read<DailyScheduleCubit>()
                                          .loadSchedule(today);
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Homepage(),
                                        ),
                                        (route) => false,
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
                                  } catch (e) {
                                    // ✅ Catch any unexpected errors
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${S.of(context).erroroccured}: $e',
                                        ),
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
                                  S.of(context).signin,
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
                    SizedBox(height: devHeight * 0.04),
                    Center(child: Text(S.of(context).or)),
                    SizedBox(height: devHeight * 0.04),

                    // Sign in with Google
                    BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
                      listener: (context, googleState) {
                        if (googleState is GoogleAuthSuccess) {
                          final today = DateTime.now();
                          context.read<DoctorCubit>().loadDoctors();
                          context.read<DailyScheduleCubit>().loadSchedule(
                            today,
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Homepage(),
                            ),
                            (route) => false,
                          );
                        } else if (googleState is GoogleAuthFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(googleState.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, googleState) {
                        return SizedBox(
                          width: devWidth * 0.9,
                          height: devHeight * 0.075,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: const Color(0xfff3f1f8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            onPressed: googleState is GoogleAuthLoading
                                ? null
                                : () => context
                                      .read<GoogleAuthCubit>()
                                      .signInWithGoogle(),
                            child: googleState is GoogleAuthLoading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/Icons2.svg",
                                      ),
                                      SizedBox(width: devWidth * 0.01),
                                      Text(
                                        S.of(context).signupwithgoogle,
                                        style: TextStyle(
                                          color: const Color(0xFF676767),
                                          fontSize: devWidth * 0.045,
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: devHeight * 0.02),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(S.of(context).donothaveanaccount),
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
                                      ) => const Signupform(),
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
                              padding: EdgeInsets.all(3),
                              minimumSize: Size.zero,
                            ),
                            child: Text(
                              S.of(context).signup,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    devWidth *
                                    0.04, // ✅ Added responsive font size
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitForm() {}
}
