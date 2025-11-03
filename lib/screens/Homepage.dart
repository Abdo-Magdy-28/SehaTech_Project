import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/widgets/categorysrow.dart';
import 'package:grad_project/widgets/chatbotslider.dart';
import 'package:grad_project/widgets/customappbar.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        backgroundColor: Colors.white,
        color: Color(0xff1555d8),
        items: [
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/home-2.svg'),
            label: _selectedIndex == 0 ? 'Home' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/mingcute_scan-line.svg'),
            label: _selectedIndex == 1 ? 'Scan' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/Frame 48095567.svg'),
            label: _selectedIndex == 2 ? 'Chatbot' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/search.svg'),
            label: _selectedIndex == 3 ? 'Search' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
          CurvedNavigationBarItem(
            child: SvgPicture.asset('assets/images/reports.svg'),
            label: _selectedIndex == 4 ? 'Reports' : '',
            labelStyle: TextStyle(color: Colors.white),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          print(index);
        },
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: devwidth * 0.9,
            child: ListView(
              children: [
                SizedBox(height: devheight * 0.02),
                Customappbar(),
                SizedBox(width: devwidth, child: Divider(thickness: 1)),
                SizedBox(height: devheight * 0.01),
                chatbotslider(devheight: devheight),
                SizedBox(height: devheight * 0.025),
                categorysrow(),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Container(
                        width: devwidth * 0.9,
                        height: devheight * 0.23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Color(0xfff0f0f0),
                          border: Border.all(
                            color: Color(0xffc9c9c9),
                            width: 0.5,
                          ),
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
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      top: devheight * 0.105,
                      left: devwidth * 0.04,
                      child: Text(
                        "with your preferred",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Positioned(
                      top: devheight * 0.128,
                      left: devwidth * 0.04,
                      child: Text(
                        "doctors in just a few taps.",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Positioned(
                      top: devheight * 0.174,
                      left: devwidth * 0.04,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: devwidth * 0.35,
                          height: devheight * 0.032,
                          decoration: BoxDecoration(
                            color: Color(0xff1555d8),
                            borderRadius: BorderRadius.circular(16),
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
