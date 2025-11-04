import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class medicinecard extends StatelessWidget {
  const medicinecard({
    super.key,
    required this.name,
    required this.time,
    required this.quatity,
    required this.scheduletime,
    required this.image,
    required this.condition,
  });
  final String name, time, quatity, scheduletime, condition;
  final Image image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 94,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(0xffCCCCCC)),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 10,
              top: 10,
              child: SizedBox(height: 70, width: 70, child: image),
            ),
            Positioned(
              left: 80,
              top: 10,
              child: Text(
                name,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: 35,
              child: Text(
                "$quatity | $scheduletime",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Color(0xff111111),
                ),
              ),
            ),
            Positioned(right: 10, top: 10, child: conditionWidget(condition)),
            Positioned(
              left: 80,
              top: 60,
              child: SvgPicture.asset("assets/images/Alarm.svg"),
            ),
            Positioned(
              left: 100,
              top: 60,
              child: Text(
                time,
                style: TextStyle(
                  color: Color(0xffF9783C),
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: SizedBox(
                height: 24,
                width: 24,
                child: Image.asset("assets/images/angle-right-small.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class missed extends StatelessWidget {
  const missed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      width: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        color: Color.fromARGB(51, 239, 68, 68),
      ),
      child: Center(
        child: Text(
          "Missed",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Color(0xffEF4444),
          ),
        ),
      ),
    );
  }
}

class upcoming extends StatelessWidget {
  const upcoming({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      width: 67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        color: Color.fromARGB(65, 249, 120, 60),
      ),
      child: Center(
        child: Text(
          "Upcoming",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Color(0xffF9783C),
          ),
        ),
      ),
    );
  }
}

class taken extends StatelessWidget {
  const taken({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 33,
      width: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        color: Color.fromARGB(50, 0, 161, 169),
      ),
      child: Center(
        child: Text(
          "Taken",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Color(0xff00A1A9),
          ),
        ),
      ),
    );
  }
}

Widget conditionWidget(String condition) {
  if (condition == 'taken') {
    return const taken();
  }
  if (condition == 'missed') {
    return const missed();
  } else {
    return const upcoming();
  }
}
