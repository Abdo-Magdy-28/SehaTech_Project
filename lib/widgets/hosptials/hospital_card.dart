import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({
    super.key,
    required this.devheight,
    required this.category,
    required this.rate,
    required this.name,
    required this.opendate,
    required this.closedate,
  });
  final double devheight, rate;
  final String category, opendate, closedate, name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: devheight * 0.11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xffF0F0F0),
          border: Border.all(color: const Color.fromARGB(115, 199, 198, 198)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  spacing: 0,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(
                            width: devheight * 0.06,
                            child: SvgPicture.asset(
                              "assets/images/hospitals/Frame2147226186.svg",
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              spacing: 4,
                              children: [
                                Text(
                                  S.of(context).doctorTitle(name),
                                  style: TextStyle(
                                    fontSize: devheight * 0.017,
                                    color: Color(0xff33384B),
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Text(
                                      category,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xff6d6d6d),
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: devheight * 0.03,
                        top: devheight * 0.00001,
                      ),
                      child: Row(
                        spacing: 15,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$rate",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xff33384B),
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                                width: 16,
                                child: Image.asset('assets/images/Star.png'),
                              ),
                            ],
                          ),

                          Row(
                            children: [
                              SizedBox(
                                height: devheight * 0.015,
                                width: devheight * 0.015,
                                child: Image.asset('assets/images/Time.png'),
                              ),
                              Text(
                                "$opendate - ",
                                style: TextStyle(
                                  color: Color(0xff33384B),
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                  fontSize: devheight * 0.015,
                                ),
                              ),
                              Text(
                                closedate,
                                style: TextStyle(
                                  color: Color(0xff33384B),
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                  fontSize: devheight * 0.015,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10, top: devheight * 0.008),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      height: 27,
                      width: 71,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff0D61EC),
                      ),
                      child: Center(
                        child: Text(
                          "View",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3, right: 9),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: SvgPicture.asset(
                          'assets/images/lets-icons_map-duotone.svg',
                        ),
                      ),
                      Text(
                        S.of(context).directions,
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          color: Color(0xffAAB6C3),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
