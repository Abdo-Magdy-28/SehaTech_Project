import 'package:flutter/material.dart';
import 'package:grad_project/widgets/textformfield.dart';

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
          reverse: true, // ensures bottom field stays visible
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: devHeight * 0.02),
                Text(
                  'SIGN UP',
                  style: TextStyle(
                    fontSize: devWidth * 0.06,
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
                  bordercolor: const Color(0xFF727880),
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
                  bordercolor: const Color(0xFF727880),
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
                  bordercolor: const Color(0xFF727880),
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
                  obsecure: true,
                  bordercolor: const Color(0xFF727880),
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
                  obsecure: true,
                  bordercolor: const Color(0xFF727880),
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
                SizedBox(height: devHeight * 0.02),
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
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fix errors.')));
    }
  }
}
