import 'package:flutter/material.dart';
import 'package:grad_project/models/medicineremindercardmodel.dart';
import 'package:grad_project/screens/alldoctors.dart';
import 'package:grad_project/widgets/categorysrow.dart';
import 'package:grad_project/widgets/chatbotslider.dart';
import 'package:grad_project/widgets/customappbar.dart';
import 'package:grad_project/widgets/doctor_card.dart';
import 'package:grad_project/widgets/hearttopic.dart';
import 'package:grad_project/widgets/homepage/home_carouselcard.dart';
import 'package:grad_project/widgets/medication_management_grid.dart';
import 'package:grad_project/widgets/medicencard.dart';
import 'package:grad_project/widgets/medicinereminder.dart';
import 'package:grad_project/widgets/prevent_diseases.dart';
import 'package:grad_project/widgets/weakcalender.dart';
import 'package:grad_project/widgets/weaklystreak.dart';

class Homepagewidget extends StatefulWidget {
  const Homepagewidget({super.key});

  @override
  State<Homepagewidget> createState() => _HomepagewidgetState();
}

class _HomepagewidgetState extends State<Homepagewidget> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: devwidth * 0.9,
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),

            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.02)),
              SliverToBoxAdapter(child: Customappbar()),
              SliverToBoxAdapter(
                child: SizedBox(width: devwidth, child: Divider(thickness: 1)),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.01)),
              SliverToBoxAdapter(child: chatbotslider(devheight: devheight)),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(child: categorysrow()),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.030)),
              SliverToBoxAdapter(
                child: home_crouselcard(
                  devwidth: devwidth,
                  devheight: devheight,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: Row(
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
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Alldoctors()),
                        );
                      },
                      child: Padding(
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
                    ),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Doctorcard(
                    devheight: devheight,
                    doctorimage: Image.asset('assets/images/Pic.png'),
                    job: "Neurologist",
                    hospital: "El-Demerdash Hospital",
                    name: "Youssef Ali",
                    rate: 4.5,
                    begindate: "10:30am",
                    enddate: "5:30pm",
                  );
                }, childCount: 5),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: Text(
                  "Medication Management",
                  style: TextStyle(
                    color: Color(0xff33384B),
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.02)),
              SliverToBoxAdapter(
                child: MedicationManagementGrid(
                  devheight: devheight,
                  devwidth: devwidth,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: Medicinereminder(
                  medicine: MedicineReminderCard(
                    medicineName: 'Belladonna 30',
                    dosage: '2 Drops | Every 2 Hour',
                    reminderTime: '09:30 AM',
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(child: Weaklystreak()),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(child: WeekScheduleWidget()),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return medicinecard(
                    image: Image.asset("assets/images/Shape10.png"),
                    condition: 'missed',
                    name: "Belladonna 30",
                    quatity: "2 Drops",
                    scheduletime: "Every 2 Hour",
                    time: "09:30 AM",
                  );
                }, childCount: 3),
              ),
              SliverToBoxAdapter(child: SizedBox(height: devheight * 0.025)),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Important Topics",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Color(0xff33384B),
                      ),
                    ),
                    Text(
                      "See all",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff2E6FF3),
                      ),
                    ),
                  ],
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 170,
                  child: ListView(
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(right: 20, bottom: 15, top: 15),
                    children: [hearttopic(), prevent_diseases()],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
