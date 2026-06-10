// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grad_project/cubit/Authentication/Authcubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Authentication/verificationview.dart';
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
                    S.of(context).verifiyyouridentity,
                    style: TextStyle(
                      fontSize: devWidth * 0.06,
                      fontWeight: FontWeight.w800,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  SizedBox(height: devHeight * 0.01),
                  Text(
                    S.of(context).enteremailtoreceivecode,
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
                    hinttext: S.of(context).email,
                    validator: MultiValidator([
                      EmailValidator(errorText: S.of(context).emailisnotvalid),
                      RequiredValidator(errorText: S.of(context).emailrequired),
                    ]),
                    bordercolor: const Color(0xFFF3F1F7),
                    prefixicon: "assets/images/carbon_email.svg",
                    textInputAction: TextInputAction.next,
                  ),

                  SizedBox(height: devHeight * 0.02),

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
                        S.of(context).continuee,
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

  void _submitForm() async {
    if (formKey.currentState!.validate()) {
      //Email Entered
      if (_emailController.text.isNotEmpty) {
        await BlocProvider.of<Authcubit>(
          context,
        ).forgotpassword(email: _emailController.text);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return Verificationview(email: _emailController.text);
            },
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(S.of(context).plsfixformerrors)));
    }
  }
}
