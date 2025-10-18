// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grad_project/screens/verificationview.dart';
import 'package:grad_project/widgets/textformfield.dart';

class Verifyidentity extends StatefulWidget {
  const Verifyidentity({super.key});

  @override
  State<Verifyidentity> createState() => _VerifyidentityState();
}

class _VerifyidentityState extends State<Verifyidentity> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: devHeight * 0.04),
                  Text(
                    "Verify Your Identity",
                    style: TextStyle(
                      fontSize: devWidth * 0.06,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: devHeight * 0.01),
                  Text(
                    "Enter your email or phone number to receive reset Code",
                    style: TextStyle(
                      fontSize: devWidth * 0.036,
                      fontFamily: 'Cairo',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: devHeight * 0.04),

                  // ===== EMAIL FIELD =====
                  Textformfield(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    hinttext: 'Email Address',
                    validator: EmailValidator(errorText: "Invalid Email").call,
                    bordercolor: const Color(0xFFF3F1F7),
                    prefixicon: "assets/images/carbon_email.svg",
                    textInputAction: TextInputAction.next,
                  ),

                  SizedBox(height: devHeight * 0.02),

                  Text(
                    "OR",
                    style: TextStyle(
                      fontSize: devWidth * 0.055,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff8e9399),
                    ),
                  ),

                  SizedBox(height: devHeight * 0.02),

                  // ===== PHONE FIELD =====
                  Textformfield(
                    keyboardType: TextInputType.number,
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    hinttext: 'Phone Number',
                    validator: MultiValidator([
                      PatternValidator(
                        r'^01[0-9]+$',
                        errorText: "Invalid Phone Number",
                      ),
                      MaxLengthValidator(11, errorText: "Invalid Phone Number"),
                    ]),
                    bordercolor: const Color(0xFFF3F1F7),
                    prefixicon: "assets/images/carbon_phone.svg",
                    textInputAction: TextInputAction.done,
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
                        'Continue',
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
    );
  }

  void _submitForm() {
    final bothEmpty =
        _emailController.text.isEmpty && _phoneController.text.isEmpty;
    final bothFilled =
        _emailController.text.isNotEmpty && _phoneController.text.isNotEmpty;

    if (bothEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter either Email or Phone Number'),
        ),
      );
      return;
    } else if (bothFilled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter either Email or Phone Number'),
        ),
      );
      return;
    }

    if (formKey.currentState!.validate()) {
      //Email Entered
      if (_emailController.text.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email entered — go to Email Reset page'),
          ),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Verificationview(verifyer: _emailController.text);
            },
          ),
        );
      }
      // Phone Number Entered
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Phone entered — go to SMS Reset page')),
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Verificationview(verifyer: _phoneController.text);
            },
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fix errors.')));
    }
  }
}
