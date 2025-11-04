import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class prevent_diseases extends StatelessWidget {
  const prevent_diseases({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 149,
      width: 298,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset("assets/images/Group 24090.png"),
          Positioned(
            top: 20,
            left: 10,
            child: Text(
              "Tips for preventing \ninfectious diseases",
              style: TextStyle(
                color: Color(0xff111111),
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            right: 1,
            top: -15,
            child: SizedBox(
              height: 160,
              width: 140,
              child: Image.asset(
                "assets/images/Health technology and medical monitoring device.png",
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
                      color: Color(0xff111111),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: SvgPicture.asset("assets/images/Icons10.svg"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
