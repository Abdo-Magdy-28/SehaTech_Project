import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Doctorcard extends StatelessWidget {
  const Doctorcard({
    super.key,
    required this.devheight,
    required this.job,
    required this.hospital,
    required this.rate,
    required this.begindate,
    required this.enddate,
    required this.name,
    required this.doctorimage,
  });
  final Image doctorimage;
  final double devheight, rate;
  final String job, hospital, begindate, enddate, name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: devheight * 0.13,
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
                  spacing: 2,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: SizedBox(width: 37, child: doctorimage),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr : $name",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff33384B),
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    Text(
                                      "$job | ",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Color(0xffAAB6C3),
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        hospital,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xffAAB6C3),
                                          fontFamily: 'Cairo',
                                          fontWeight: FontWeight.w400,
                                        ),
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
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Row(
                        spacing: 20,
                        children: [
                          Row(
                            children: [
                              Text(
                                "$rate",
                                style: TextStyle(
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
                                height: 18,
                                width: 18,
                                child: Image.asset('assets/images/Time.png'),
                              ),
                              Text(
                                "$begindate - ",
                                style: TextStyle(
                                  color: Color(0xff33384B),
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                enddate,
                                style: TextStyle(
                                  color: Color(0xff33384B),
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
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
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                          "BOOK Now",
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
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 26,
                        width: 30,
                        child: SvgPicture.asset(
                          'assets/images/lets-icons_map-duotone.svg',
                        ),
                      ),
                      Text(
                        "Directions",
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
