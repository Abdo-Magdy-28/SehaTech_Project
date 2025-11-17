// ====== LOGIN PAGE (FULLY FIXED FADE + SLIDE ANIMATION) ======

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/screens/signin.dart';
import 'package:grad_project/screens/signupform.dart';
import 'package:grad_project/widgets/carousel_card.dart';
import 'package:grad_project/widgets/carouselcard2.dart';
import 'package:grad_project/widgets/carouselcard3.dart';
import 'package:grad_project/widgets/customgradientslide.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final CarouselSliderController outerCarouselController =
      CarouselSliderController();

  int outerCurrentPage = 0;
  double _slideProgress = 0.0;

  // ====== NEW — Perfect fade curves like the video ======
  double get _carouselOpacity {
    return (1 - (_slideProgress * 1.2)).clamp(0.0, 1.0);
  }

  double get _contentOpacity {
    return (1 - (_slideProgress * 1.4)).clamp(0.0, 1.0);
  }

  double get _bottomButtonOpacity {
    if (_slideProgress < 0.5) return 1.0;
    return (1 - ((_slideProgress - 0.5) * 2)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 0),
            top: _slideProgress * devheight * 0.25, // Smooth slide like video
            left: 0,
            right: 0,
            child: IgnorePointer(
              ignoring: _slideProgress > 0.2,
              child: Opacity(
                opacity: 1,
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: devheight * 0.15),

                      // ====== CAROUSEL with Perf Fade ======
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 130),
                        opacity: _carouselOpacity,
                        child: CarouselSlider(
                          carouselController: outerCarouselController,
                          options: CarouselOptions(
                            height: devheight * 0.22,
                            viewportFraction: 0.95,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            onPageChanged: (index, reason) {
                              setState(() {
                                outerCurrentPage = index;
                              });
                            },
                          ),
                          items: [
                            CarouselCard(
                              title:
                                  'Easily Consult Top Doctors Online & In-Person.',
                              hint:
                                  'Consult today. Find top doctors. Start your health journey with ease and confidence now!',
                              image: 'assets/images/Card01-illu2.png',
                            ),
                            CarouselCard2(
                              title:
                                  'Easily Access a Smart Chatbot for Instant Support',
                              hint:
                                  '"Get instant support. Receive guided medical advice now!"',
                              image:
                                  'assets/images/AI assistant and chat interface.png',
                            ),
                            CarouselCard3(
                              title:
                                  'Easily Access Top Hospitals Online & In-Person',
                              hint:
                                  '"Find trusted hospitals and start your treatment journey!"',
                              image: 'assets/images/Layer 7.png',
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: devheight * 0.03),

                      // ====== CONTENT ======
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 120),
                        opacity: _contentOpacity,
                        child: Column(
                          children: [
                            Text(
                              "SEHA TECH",
                              style: TextStyle(
                                fontSize: devwidth * 0.06,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'SEHA TECH helps you track, manage, and improve your\n'
                              'health with smart tools designed for every stage of life.',
                              style: TextStyle(
                                fontSize: devwidth * 0.028,
                                fontWeight: FontWeight.w400,
                                color: Colors.black54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: devheight * 0.035),

                            // GOOGLE BUTTON
                            _buildGoogleButton(devwidth, devheight),

                            SizedBox(height: devheight * 0.02),

                            // FACEBOOK BUTTON
                            _buildFacebookButton(devwidth, devheight),

                            SizedBox(height: devheight * 0.03),

                            // Sign In text
                            _buildSignInRow(devwidth),
                            SizedBox(height: devheight * 0.04),
                          ],
                        ),
                      ),

                      // ====== SLIDE BUTTON ======
                      AnimatedOpacity(
                        duration: Duration(milliseconds: 180),
                        opacity: _bottomButtonOpacity,
                        child: GradientSlideToAct(
                          width: devwidth * 0.9,
                          height: devheight * 0.075,
                          text: "Swap To Create Account",
                          onProgressChanged: (progress) {
                            setState(() => _slideProgress = progress);
                          },
                          onSubmit: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => Signupform(),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ====== Small Builders ======

  Widget _buildGoogleButton(double w, double h) {
    return SizedBox(
      width: w * 0.9,
      height: h * 0.075,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xfff3f1f8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/Icons2.svg"),
            SizedBox(width: w * 0.01),
            Text(
              "Sign Up With Google",
              style: TextStyle(
                color: Color(0xFF676767),
                fontSize: w * 0.045,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacebookButton(double w, double h) {
    return SizedBox(
      width: w * 0.9,
      height: h * 0.075,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xff0d61ec),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/Icons.svg"),
            SizedBox(width: w * 0.01),
            Text(
              "Sign Up With Facebook",
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.045,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignInRow(double w) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account?",
          style: TextStyle(
            color: Colors.black87,
            fontFamily: 'Cairo',
            fontSize: w * 0.035,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => Signin()));
          },
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: w * 0.035,
            ),
          ),
        ),
      ],
    );
  }
}
