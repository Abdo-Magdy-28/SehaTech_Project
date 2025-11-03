import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/constants.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Container(
      height: devheight * 0.06,
      width: devwidth * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/images/profile.svg',
              fit: BoxFit.scaleDown,
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 16),
              Text(
                "QALUBIA,",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  color: Color(0xff111111),
                ),
              ),
              Text(
                "BANHA",
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  color: Color(0xff111111),
                ),
              ),
            ],
          ),
          Badge(
            backgroundColor: Colors.red,
            smallSize: 13,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/images/bell.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
