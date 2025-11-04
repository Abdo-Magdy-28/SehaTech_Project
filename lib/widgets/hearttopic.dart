import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class hearttopic extends StatelessWidget {
  const hearttopic({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: SizedBox(
        width: 298,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset("assets/images/Sign-up-cards-BG.png"),
            Positioned(
              top: 20,
              left: 10,
              child: Text(
                "How to deal with \nchronic diseases ?",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            Positioned(
              right: -15,
              top: -15,
              child: SizedBox(
                height: 160,
                width: 138,
                child: Image.asset(
                  "assets/images/49214 1.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 100,
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  children: [
                    Text(
                      "Learn more",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset("assets/images/Vector10.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
