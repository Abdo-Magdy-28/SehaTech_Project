import 'package:flutter/material.dart';
import 'package:grad_project/screens/signupform.dart';
import 'package:slide_to_act/slide_to_act.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),

            ////// Doctor Photo
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: 'first',
                  child: SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/Sign-up-cards-BG.png",
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          child: Image.asset(
                            "assets/images/Sign-up-card01.png",

                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            /// THe Text
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 50),
                    child: Text(
                      "SEHA TECH",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'SEHA TECH helps you track, manage, and improve your\n'
                      'health with smart tools designed for every stage of life.',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            /// Sign up With GOOGLE BUTTON
            SizedBox(
              width: 340,
              height: 55,
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
                    Image.asset("assets/images/Google_Icon.png"),
                    SizedBox(width: 4),
                    Text("Sign Up With Google", style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            /// Sign up WIth facebook Button
            SizedBox(
              width: 340,
              height: 55,
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
                    Image.asset("assets/images/Facebook_icon.png"),
                    SizedBox(width: 4),
                    Text(
                      "Sign Up With Facebook",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            /// "Already Have An Account"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Already have an account?"),
                TextButton(onPressed: () {}, child: Text("Sign In")),
              ],
            ),
            SizedBox(height: 80),

            /// Slider
            Container(
              width: 340,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.4),
                borderRadius: BorderRadius.circular(25),
              ),
              child: SlideAction(
                height: 55,
                text: "Swap To Create Account",
                elevation: 0,
                textStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
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
    );
  }
}
