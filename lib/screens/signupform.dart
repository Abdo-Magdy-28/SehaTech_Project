// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:grad_project/screens/signupscreen2.dart';
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
                  validator: MultiValidator([
                    RequiredValidator(errorText: "Password required"),
                    MinLengthValidator(
                      6,
                      errorText: 'Password must be at least 6 characters',
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
                SizedBox(
                  width: double.infinity,
                  height: devHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: _submitForm,
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
                SizedBox(height: devHeight * 0.01),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {},
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

  void _submitForm() {
    if (formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form is valid! Signing up...')),
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return Signupscreen2();
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fix errors.')));
    }
  }
}
