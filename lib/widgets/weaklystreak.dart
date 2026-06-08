import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';

class Weaklystreak extends StatefulWidget {
  const Weaklystreak({super.key});

  @override
  State<Weaklystreak> createState() => _WeaklystreakState();
}

class _WeaklystreakState extends State<Weaklystreak> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Container(
      width: devwidth * 0.15,
      height: devheight * 0.2,
      decoration: BoxDecoration(
        color: Color(0xffedf6ff),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: devwidth * 0.007),
                  SvgPicture.asset('assets/images/Frame 3.svg'),
                  SizedBox(width: devwidth * 0.03),
                  Text(
                    S.of(context).weeklyStreak,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              SizedBox(height: devheight * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: devwidth * 0.01),
                  Text(
                    S.of(context).weeklyPercentage(72),
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(width: devwidth * 0.03),
                  SvgPicture.asset('assets/images/Frame 2147226112.svg'),
                  SizedBox(width: devwidth * 0.004),
                  Text(
                    S.of(context).missedThisWeek(3),
                    style: TextStyle(
                      color: Color(0xffef4444),
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              SizedBox(height: devheight * 0.008),
              TextButton(
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      S.of(context).viewWeeklyReport,
                      style: TextStyle(
                        color: Color(0xff0d61ec),
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(width: devwidth * 0.01),
                    Icon(
                      Icons.arrow_circle_right_rounded,
                      color: Color(0xff0d61ec),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SvgPicture.asset('assets/images/Frame 2147226115.svg'),
        ],
      ),
    );
  }
}
