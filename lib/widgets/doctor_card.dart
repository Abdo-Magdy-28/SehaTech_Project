import 'package:flutter/material.dart';

class Doctorcard extends StatelessWidget {
  const Doctorcard({super.key, required this.devheight});

  final double devheight;

  @override
  Widget build(BuildContext context) {
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
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: 32,
                        child: Image.asset('assets/images/Pic.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Jennifer Miller",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff33384B),
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "Pediatrician | ",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xffAAB6C3),
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Mercy Hospital",
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
                  ],
                ),
                Row(
                  spacing: 20,
                  children: [
                    Row(
                      children: [
                        Text("4.8", style: TextStyle(color: Colors.black)),
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
                        Text("10:30-"),
                        Text("5:30pm"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 22,
                  width: 71,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff1555D8),
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
          ],
        ),
      ),
    );
  }
}
