// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Authcubit.dart';
import 'package:grad_project/cubit/Authstates.dart';
import 'package:grad_project/models/user.dart';
import 'package:grad_project/screens/Authentication/signin.dart';
import 'package:grad_project/screens/Authentication/signupscreen2.dart';
import 'package:grad_project/widgets/textformfield.dart';
import 'package:form_field_validator/form_field_validator.dart';

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

  final _firstController = TextEditingController();
  final _lastController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _firstFocus.dispose();
    _lastFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    _firstController.dispose();
    _lastController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String Firstname, Lastname, Email, Password, confirmpassword;
    final devHeight = MediaQuery.of(context).size.height;
    final devWidth = MediaQuery.of(context).size.width;

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
                  'SIGN UP',
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
                  hinttext: 'First Name',
                  onchange: (value) {
                    Firstname = value;
                    // BlocProvider.of<Authcubit>(context).firstname = value;
                  },
                  validator: RequiredValidator(
                    errorText: "First Name required",
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
                  hinttext: 'Last Name',
                  onchange: (value) {
                    Lastname = value;
                    // BlocProvider.of<Authcubit>(context).lastname = value;
                  },
                  validator: RequiredValidator(errorText: "Last Name required"),
                  bordercolor: const Color(0xFFF3F1F7),
                  prefixicon: "assets/images/iconamoon_profile-light.svg",
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_emailFocus),
                ),

                // Email
                Textformfield(
                  controller: _emailController,
                  focusNode: _emailFocus,
                  hinttext: 'Email',
                  onchange: (value) {
                    Email = value;
                    // BlocProvider.of<Authcubit>(context).email = value;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Email required "),
                    EmailValidator(errorText: "Email Is Invalid"),
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
                  hinttext: 'Password',
                  ispassword: true,
                  onchange: (value) {
                    Password = value;
                    // BlocProvider.of<Authcubit>(context).password = value;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Password required"),
                    MinLengthValidator(
                      8,
                      errorText: 'Password must be at least 8 characters',
                    ),
                  ]),
                  obsecure: true,
                  bordercolor: const Color(0xFFF3F1F7),
                  prefixicon: "assets/images/teenyicons_password-outline.svg",
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) =>
                      FocusScope.of(context).requestFocus(_confirmFocus),
                ),

                // Confirm Password
                Textformfield(
                  controller: _confirmController,
                  focusNode: _confirmFocus,
                  hinttext: 'Confirm Password',
                  onchange: (value) {
                    confirmpassword = value;
                    // BlocProvider.of<Authcubit>(context).confirmpassword =
                    //     value;
                  },
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
                  prefixicon: "assets/images/teenyicons_password-outline.svg",
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submitForm(),
                ),

                SizedBox(height: devHeight * 0.04),
                Hero(
                  tag: 'first',
                  child: SizedBox(
                    width: double.infinity,
                    height: devHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          final authCubit = BlocProvider.of<Authcubit>(context);
                          authCubit.firstname = _firstController.text;
                          authCubit.lastname = _lastController.text;
                          authCubit.email = _emailController.text;
                          authCubit.password = _passwordController.text;
                          authCubit.confirmpassword = _confirmController.text;
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Form is valid! Signing up...'),
                            ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<Authcubit>(context),
                                child: Signupscreen2(),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fix errors.')),
                          );
                        }
                      }, /////////////////////
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2260FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Sign Up',
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
                      Text("Already have an account?"),
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
                                  (context, animation, secondaryAnimation) =>
                                      const Signin(),
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
                          "Sign In",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                devWidth * 0.04, // ✅ Added responsive font size
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
  }

  void _submitForm() {}
}
