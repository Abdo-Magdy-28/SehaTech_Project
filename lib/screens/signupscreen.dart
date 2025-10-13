import 'package:flutter/material.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 131),

          Container(
            width: 378,
            height: 256,
            child: Stack(
              children: [
                Image.asset("assets/images/Sign-up-cards-BG.png"),
                Image.asset("assets/images/Sign-up-card01.png"),
              ],
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "SEHA TECH",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Container(
                  width: 282,
                  height: 58,
                  child: Text(
                    "SEHA TECH helps you track, manage, and improve your health with smart tools designed for every stage of life. ",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
