// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/screens/signupscreen2.dart';
import 'package:grad_project/screens/verifyidentity.dart';
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
                  'SIGN IN',
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
                          "Forgot Password ?",
                          style: TextStyle(
                            color: Colors.black,

                            fontSize:
                                devWidth * 0.04, // ✅ Added responsive font size
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Hero(
                  tag: 'first',
                  child: SizedBox(
                    width: double.infinity,
                    height: devHeight * 0.07,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2260FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Sign In',
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
                Center(child: Text("OR")),
                SizedBox(height: devHeight * 0.04),
                SizedBox(
                  width: devWidth * 0.9,
                  height: devHeight * 0.075,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xfff3f1f8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/Icons2.svg"),
                        SizedBox(width: devWidth * 0.01),
                        Text(
                          "Sign Up With Google",
                          style: TextStyle(
                            color: Color(0xFF676767),
                            fontSize: devWidth * 0.045, // ✅ Changed from 18
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: devHeight * 0.02),
                SizedBox(
                  width: devWidth * 0.9,
                  height: devHeight * 0.075,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Color(0xff0d61ec),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),

                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/images/Icons.svg"),
                        SizedBox(width: devWidth * 0.01),
                        Text(
                          "Sign Up With Facebook",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: devWidth * 0.045, // ✅ Changed from 18
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Dont Have Account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(3),
                          minimumSize: Size.zero,
                        ),
                        child: Text(
                          "Sign Up",
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
