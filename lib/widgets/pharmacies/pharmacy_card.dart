import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({
    super.key,
    required this.devheight,
    required this.rate,
    required this.name,
    required this.isopen24,
  });
  final double devheight, rate;
  final String name;
  final bool isopen24;

  @override
  Widget build(BuildContext context) {
    final String open24 = isopen24 ? "24-hours" : "Closed";
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: devheight * 0.12,
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
                              "assets/images/pharmacies/pharmacy_icon.svg",
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
                                      "Pharmacy",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 14,
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
                      padding: const EdgeInsets.only(left: 32.0, top: 7),
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
                                open24,
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
            ),
            Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 10),
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
