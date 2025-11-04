import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class home_crouselcard extends StatelessWidget {
  const home_crouselcard({
    super.key,
    required this.devwidth,
    required this.devheight,
  });

  final double devwidth;
  final double devheight;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            width: devwidth * 0.9,
            height: devheight * 0.23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xfff0f0f0),
              border: Border.all(color: Color(0xffc9c9c9), width: 0.5),
            ),
          ),
        ),
        Positioned(
          left: devwidth * 0.015,
          child: Image.asset(
            'assets/images/Doctors.png',
            width: devwidth * 1.488,
            height: devheight * 0.23,
          ),
        ),
        Positioned(
          left: devwidth * 0.015,
          top: devheight * 0.07,
          child: Image.asset(
            'assets/images/boy.png',
            width: devwidth * 1.488,
            height: devheight * 0.16,
          ),
        ),
        Positioned(
          top: devheight * 0.015,
          left: devwidth * 0.028,
          child: Container(
            width: devwidth * 0.5,
            height: devheight * 0.032,
            decoration: BoxDecoration(
              color: Color(0xff1555d8),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: EdgeInsets.all(devwidth * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/calendar.svg'),
                  SizedBox(width: devwidth * 0.008),
                  Text(
                    "Appointment Reminder",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: devwidth * 0.034,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          top: devheight * 0.05,
          left: devwidth * 0.04,
          child: Text(
            "Schedule Your Next ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Positioned(
          top: devheight * 0.074,
          left: devwidth * 0.04,
          child: Text(
            "Appointment ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        Positioned(
          top: devheight * 0.105,
          left: devwidth * 0.04,
          child: Text(
            "with your preferred",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
        Positioned(
          top: devheight * 0.128,
          left: devwidth * 0.04,
          child: Text(
            "doctors in just a few taps.",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ),
        Positioned(
          top: devheight * 0.174,
          left: devwidth * 0.04,
          child: InkWell(
            onTap: () {},
            child: Container(
              width: devwidth * 0.35,
              height: devheight * 0.038,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff0B52C7), Color(0xff1778F2)],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  "Schedule Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
