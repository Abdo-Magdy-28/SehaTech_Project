import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/models/medicineremindercardmodel.dart';

class Medicinereminder extends StatefulWidget {
  const Medicinereminder({super.key, required this.medicine});
  final MedicineReminderCard medicine;

  @override
  State<Medicinereminder> createState() => _MedicinereminderState();
}

class _MedicinereminderState extends State<Medicinereminder> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Container(
      width: devwidth * 0.1,
      height: devheight * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xffefefef), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header section
          Padding(
            padding: EdgeInsets.all(devwidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset('assets/images/i.svg'),
                    // SizedBox(width: devwidth * 0.02),
                    Text(
                      'Upcoming Reminder',
                      style: TextStyle(color: Color(0xff707070), fontSize: 14),
                    ),
                    // SizedBox(width: devwidth * 0.25),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: devheight * 0.01,
                        vertical: devwidth * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfffdecec),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.medicine.reminderTime,
                        style: TextStyle(
                          color: Color(0xffda3e3e),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: devheight * 0.01),
                Text(
                  widget.medicine.medicineName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff111111),
                  ),
                ),
                SizedBox(height: devheight * 0.01),
                Text(
                  widget.medicine.dosage,
                  style: TextStyle(fontSize: 14, color: Color(0xff808080)),
                ),
              ],
            ),
          ),
          Divider(color: Color(0xffe2e2e2), thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: devwidth * 0.02),
                    Icon(Icons.alarm, color: Color(0xfff9783c), size: 25),
                    SizedBox(width: devwidth * 0.008),
                    Text(
                      'Remind Later',
                      style: TextStyle(
                        color: Color(0xfff9783c),
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: devwidth * 0.04),
              Container(height: 40, width: 1, color: Color(0xffe2e2e2)),
              TextButton(
                onPressed: () {},
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: devwidth * 0.02),
                    Icon(Icons.check, color: Color(0xff2260ff), size: 25),
                    SizedBox(width: devwidth * 0.008),
                    Text(
                      'Remind Later',
                      style: TextStyle(
                        color: Color(0xff2260ff),
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: devwidth * 0.02),
            ],
          ),
        ],
      ),
    );
  }
}
