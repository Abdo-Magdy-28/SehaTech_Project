import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/screens/signupform.dart';
import 'package:grad_project/widgets/carousel_card.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: devheight * 0.2),
            CarouselCard(
              title: 'Easily Consult Top Doctors Online & In-Person.',
              hint:
                  'Consult today. Find top doctors. Start your health journey with ease and confidence now!',
              image: 'assets/images/Card01-illu2.png',
            ),
            SizedBox(
              height: devheight * 0.6,
              width: devwidth * 0.88,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "SEHA TECH",
                    style: TextStyle(
                      fontSize: devwidth * 0.06,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'SEHA TECH helps you track, manage, and improve your\n'
                    'health with smart tools designed for every stage of life.',
                    style: TextStyle(
                      fontSize: devwidth * 0.025,
                      fontWeight: FontWeight.w400,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: devheight * 0.04),

                  /// Sign up With GOOGLE BUTTON
                  SizedBox(
                    width: devwidth * 0.9,
                    height: devheight * 0.075,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
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
                          SizedBox(width: devwidth * 0.01),
                          Text(
                            "Sign Up With Google",
                            style: TextStyle(
                              color: Color(0xFF676767),
                              fontSize: devwidth * 0.045, // ✅ Changed from 18
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: devheight * 0.02),

                  /// Sign up WIth facebook Button
                  SizedBox(
                    width: devwidth * 0.9,
                    height: devheight * 0.075,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
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
                          SizedBox(width: devwidth * 0.01),
                          Text(
                            "Sign Up With Facebook",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: devwidth * 0.045, // ✅ Changed from 18
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// "Already Have An Account"
                  Padding(
                    padding: EdgeInsets.only(left: devwidth * 0.028),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(
                              color: Colors.black87,
                              fontFamily: 'Cairo',
                              fontSize:
                                  devwidth *
                                  0.035, // ✅ Added responsive font size
                            ),
                          ),
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
                                    devwidth *
                                    0.035, // ✅ Added responsive font size
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: devheight * 0.05),

                  ///swap to act
                  Container(
                    width: devwidth * 0.9,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD1C9E2), width: 0.4),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: SlideAction(
                      height: devheight * 0.075,
                      text: "Swap To Create Account",
                      elevation: 0,
                      textStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: devwidth * 0.045, // ✅ Changed from 18
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                      ),
                      sliderButtonIcon: Icon(
                        Icons.double_arrow_rounded,
                        color: Colors.white,
                        size: 15,
                      ),
                      outerColor: Color(0xfffafafc),
                      innerColor: Color(0xff2260FF),

                      onSubmit: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return Signupform();
                            },
                          ),
                        );
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
