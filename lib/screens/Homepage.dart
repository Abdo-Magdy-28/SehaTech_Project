import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/models/medicineremindercardmodel.dart';
import 'package:grad_project/widgets/categorysrow.dart';
import 'package:grad_project/widgets/chatbotslider.dart';
import 'package:grad_project/widgets/customappbar.dart';
import 'package:grad_project/widgets/doctor_card.dart';
import 'package:grad_project/widgets/home_carouselcard.dart';
import 'package:grad_project/widgets/medication_management_grid.dart';
import 'package:grad_project/widgets/medicinereminder.dart';
import 'package:grad_project/widgets/weakcalender.dart';
import 'package:grad_project/widgets/weaklystreak.dart';

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
                home_crouselcard(devwidth: devwidth, devheight: devheight),
                SizedBox(height: devheight * 0.025),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Find Doctors",
                      style: TextStyle(
                        color: Color(0xff33384B),
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "See all",
                        style: TextStyle(
                          color: Color(0xff2E6FF3),
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Doctorcard(devheight: devheight);
                  },
                ),
                SizedBox(height: devheight * 0.025),
                Text(
                  "Medication Management",
                  style: TextStyle(
                    color: Color(0xff33384B),
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: devheight * 0.02),
                MedicationManagementGrid(
                  devheight: devheight,
                  devwidth: devwidth,
                ),
                SizedBox(height: devheight * 0.025),
                Medicinereminder(
                  medicine: MedicineReminderCard(
                    medicineName: 'Belladonna 30',
                    dosage: '2 Drops | Every 2 Hour',
                    reminderTime: '09:30 AM',
                  ),
                ),
                SizedBox(height: devheight * 0.025),
                Weaklystreak(),
                SizedBox(height: devheight * 0.025),
                WeekScheduleWidget(),
                SizedBox(height: devheight * 0.025),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
