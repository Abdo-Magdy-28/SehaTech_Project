// ignore_for_file: implicit_call_tearoffs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:grad_project/cubit/Authentication/Authcubit.dart';
import 'package:grad_project/cubit/Authentication/Authstates.dart';
import 'package:grad_project/screens/Homepage.dart';
import 'package:grad_project/widgets/textformfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signupscreen2 extends StatefulWidget {
  const Signupscreen2({super.key});

  @override
  State<Signupscreen2> createState() => _Signupscreen2State();
}

class _Signupscreen2State extends State<Signupscreen2> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _userNameFocus = FocusNode();
  final _phoneNumberFocus = FocusNode();
  final _userNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String? selectedGender;
  String? selectedjob;
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
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: devHeight * 0.02),
                        InkWell(
                          child: Image.asset(
                            "assets/images/Frame.png",
                            width: devWidth * 0.4,
                          ),
                          onTap: () {},
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            devHeight * 0.04,
                            0,
                            0,
                          ),
                          child: Textformfield(
                            focusNode: _userNameFocus,
                            controller: _userNameController,
                            validator: RequiredValidator(
                              errorText: "User Name Requiered",
                            ),
                            hinttext: 'User Name',
                            bordercolor: const Color(0xFF727880),
                            prefixicon:
                                "assets/images/iconamoon_profile-light.svg",
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(
                              context,
                            ).requestFocus(_phoneNumberFocus),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                            0,
                            devHeight * 0.02,
                            0,
                            devHeight * 0.02,
                          ),
                          child: Textformfield(
                            focusNode: _phoneNumberFocus,
                            controller: _phoneNumberController,
                            validator: MultiValidator([
                              RequiredValidator(
                                errorText: "Phone Number Requiered",
                              ),
                              MinLengthValidator(
                                11,
                                errorText: "Must Be 11 Numbers ",
                              ),
                              PatternValidator(
                                r'^01[0-9]+$',
                                errorText: "Invalid Phone Number",
                              ),
                              MaxLengthValidator(
                                11,
                                errorText: "Must be 11 Numbers",
                              ),
                            ]),
                            hinttext: 'Phone Number',
                            bordercolor: const Color(0xFF727880),
                            prefixicon: "assets/images/carbon_phone.svg",
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) => FocusScope.of(
                              context,
                            ).requestFocus(_phoneNumberFocus),
                          ),
                        ),
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
                            const Text("Male"),
                            Radio<String>(
                              value: "female",
                              groupValue: selectedGender,
                              onChanged: (value) =>
                                  setState(() => selectedGender = value),
                            ),
                            const Text("Female"),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio<String>(
                              value: "doctor",
                              groupValue: selectedjob,
                              onChanged: (value) =>
                                  setState(() => selectedjob = value),
                            ),
                            const Text("Doctor"),
                            Radio<String>(
                              value: "patient",
                              groupValue: selectedjob,
                              onChanged: (value) =>
                                  setState(() => selectedjob = value),
                            ),
                            const Text("Patient"),
                          ],
                        ),
                        SizedBox(height: devHeight * 0.04),
                        SizedBox(
                          width: double.infinity,
                          height: devHeight * 0.07,
                          child: ElevatedButton(
                            onPressed: state is loadingstate
                                ? null // ✅ Disable button while loading
                                : () async {
                                    // ✅ Validate form first
                                    if (!formKey.currentState!.validate()) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Please fix errors.'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                      return;
                                    }

                                    // ✅ Hide keyboard
                                    FocusScope.of(context).unfocus();

                                    // ✅ Set values in cubit
                                    final authCubit =
                                        BlocProvider.of<Authcubit>(context);
                                    authCubit.username = _userNameController
                                        .text
                                        .trim();
                                    authCubit.phone = _phoneNumberController
                                        .text
                                        .trim();
                                    authCubit.gender = selectedGender;
                                    authCubit.role = selectedjob;

                                    // ✅ Call signup and GET the response
                                    final response = await authCubit.signup();

                                    // ✅ Check if widget is still mounted
                                    if (!mounted) return;

                                    // ✅ Handle response properly
                                    if (response.success) {
                                      // ✅ Navigate to login or home screen
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Homepage(), // or Homepage()
                                        ),
                                      );
                                    } else {
                                      // ✅ Show error message
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
                      ],
                    ),
                  ),
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
