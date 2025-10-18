import 'package:flutter/material.dart';
import 'package:grad_project/screens/changepassword.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verificationview extends StatefulWidget {
  const Verificationview({super.key, required this.verifyer});
  final String verifyer;

  @override
  State<Verificationview> createState() => _VerificationviewState();
}

class _VerificationviewState extends State<Verificationview> {
  final OtpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String phonenumber = '';
    String email = '';
    String word = '';
    String visibleStart = '';
    String hidden = '';
    String visibleEnd = '';
    String domain = '';
    String finalemail = '';
    String username = '';
    List parts = [];
    if (widget.verifyer.contains('@')) {
      email = widget.verifyer;
      word = "Email";
      // Hashing email
      parts = email.split('@');
      username = parts[0];
      domain = parts[1];
      visibleStart = username.substring(0, username.length >= 2 ? 2 : 1);
      visibleEnd = username.length > 4
          ? username.substring(username.length - 1)
          : '';
      hidden =
          '*' * (username.length - visibleStart.length - visibleEnd.length);
      finalemail = visibleStart + hidden + visibleEnd + '@' + domain;
    }
    // hashing phone number
    else {
      phonenumber = widget.verifyer;
      word = "Phone";
      List<String> number = phonenumber.split('');
    }

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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: devHeight * 0.2),
                Text(
                  "$word Verification",
                  style: TextStyle(
                    fontSize: devWidth * 0.06,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Cairo',
                  ),
                ),
                Text("We sent a code to your $word "),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (email == widget.verifyer)
                      Text(
                        // Display masked email
                        '$finalemail',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    else
                      Text(
                        "01*****${phonenumber.substring(7)}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    TextButton(
                      style: ButtonStyle(),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "change",
                        style: TextStyle(
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                PinCodeTextField(
                  appContext: context,
                  length: 4,
                  onSubmitted: (value) {},
                  showCursor: true,
                  controller: OtpController,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(2),
                    activeColor: Color(0xffe5e9ef),
                    disabledColor: Color(0xffe5e9ef),
                    selectedColor: Color(0xff727880),
                    inactiveColor: Color(0xffe5e9ef),
                    fieldWidth: devWidth * 0.15,
                    fieldHeight: devHeight * 0.08,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Don't receive your code? "),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Resend",
                        style: TextStyle(
                          color: Color(0xff2260FF),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: devHeight * 0.04),

                SizedBox(
                  width: double.infinity,
                  height: devHeight * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Changepassword(),
                        ),
                      );
                    },
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
    );
  }
}
