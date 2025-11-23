import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Mappharmacycard extends StatelessWidget {
  const Mappharmacycard({
    super.key,
    required this.devheight,
    required this.rate,
    required this.name,
  });

  final double devheight, rate;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          border: Border.all(color: const Color(0xff111111), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                spacing: 0,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SizedBox(
                          width: 37,
                          child: SvgPicture.asset(
                            "assets/images/pharmasvg.svg",
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 4,
                            children: [
                              Text(
                                name,
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
                                    "Pharmacy ",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Color(0xffAAB6C3),
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
                    padding: const EdgeInsets.only(left: 32.0, top: 4),
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
                              height: 18,
                              width: 18,
                              child: Image.asset('assets/images/Time.png'),
                            ),
                            Text(
                              "24-Hours ",
                              style: TextStyle(
                                color: Color(0xff33384B),
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
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
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 25,
                        width: 60,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
