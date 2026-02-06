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
            width: devwidth * 0.89,
            height: devheight * 0.23,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [Color(0xFF143A99), Color(0xff2260FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(color: Color(0xffc9c9c9), width: 0.5),
            ),
            child: SvgPicture.asset(
              'assets/images/Mask group.svg',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: devwidth * -0.02,
          bottom: devwidth * -0.018,
          child: Image.asset(
            'assets/images/doctorssss.png',
            width: devwidth * 1.485,
            height: devheight * 0.278,
          ),
        ),

        Positioned(
          top: devheight * 0.015,
          left: devwidth * 0.028,
          child: Container(
            width: devwidth * 0.5,
            height: devheight * 0.032,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white),
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: devheight * 0.074,
          left: devwidth * 0.04,
          child: Text(
            "Appointment ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'cairo',
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: devheight * 0.112,
          left: devwidth * 0.04,
          child: Text(
            "with your preferred",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'cairo',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: devheight * 0.135,
          left: devwidth * 0.04,
          child: Text(
            "doctors in just a few taps.",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontFamily: 'cairo',
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          top: devheight * 0.174,
          left: devwidth * 0.04,
          child: InkWell(
            hoverColor: Colors.black,
            onTap: () {},
            child: Container(
              width: devwidth * 0.35,
              height: devheight * 0.038,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.white, width: 2),
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 3,
                    offset: Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 25,
                    spreadRadius: 5,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Schedule Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: devwidth * 0.038,
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
