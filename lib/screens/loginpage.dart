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

            // ================= CAROUSEL ================= //
            Stack(
              clipBehavior: Clip.none,
              children: [
                CarouselSlider(
                  carouselController: outerCarouselController,
                  options: CarouselOptions(
                    clipBehavior: Clip.none,
                    height: devheight * 0.2,
                    viewportFraction: 0.95,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayInterval: const Duration(seconds: 3),
                    onPageChanged: (index, reason) {
                      setState(() {
                        outerCurrentPage = index;
                      });
                    },
                  ),
                  items: [
                    CarouselCard(
                      title: 'Easily Consult Top Doctors Online & In-Person.',
                      hint:
                          'Consult today. Find top doctors. Start your health journey with ease and confidence now!',
                      image: 'assets/images/Card01-illu2.png',
                    ),
                    CarouselCard2(
                      title:
                          'Easily Access a Smart Chatbot for Instant Support & Guidance',
                      hint:
                          '“Get instant support. Receive guided medical advice with confidence now!"',
                      image:
                          'assets/images/AI assistant and chat interface.png',
                    ),
                    CarouselCard3(
                      title: 'Easily Access Top Hospitals Online & In-Person',
                      hint:
                          '"Find trusted hospitals. Start your treatment journey with ease and confidence now!"',
                      image: 'assets/images/Layer 7.png',
                    ),
                  ],
                ),

                // ================= INDICATORS ================= //
                Positioned(
                  bottom: 10,
                  left: devwidth * 0.4,
                  child: Row(
                    children: List.generate(3, (index) {
                      bool isSelected = outerCurrentPage == index;
                      return GestureDetector(
                        onTap: () {
                          outerCarouselController.animateToPage(index);
                        },
                        child: AnimatedContainer(
                          width: isSelected ? 35 : 5,
                          height: 5,
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.white54,
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),

            // ================= CONTENT BELOW CAROUSEL ================= //
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

                  // GOOGLE BUTTON
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
                              fontSize: devwidth * 0.045,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: devheight * 0.02),

                  // FACEBOOK BUTTON
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
                              fontSize: devwidth * 0.045,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // ALREADY HAVE ACCOUNT
                  Padding(
                    padding: EdgeInsets.only(left: devwidth * 0.028),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black87,
                            fontFamily: 'Cairo',
                            fontSize: devwidth * 0.035,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Signin()),
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
                              fontSize: devwidth * 0.035,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: devheight * 0.05),

                  // SLIDE TO ACT
                  GradientSlideToAct(
                    width: devwidth * 0.9,
                    height: devheight * 0.075,
                    text: "Swap To Create Account",
                    onSubmit: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Signupform()),
                      );
                    },
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
