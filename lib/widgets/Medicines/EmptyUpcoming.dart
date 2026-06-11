import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/cubit/Reminder/DailyReminder.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/Reminders/DailyReminder.dart';
import 'package:grad_project/models/medicineremindercardmodel.dart';

class EmptyUpcoming extends StatefulWidget {
  const EmptyUpcoming({super.key, required this.medicine});
  final DailyMedications medicine;

  @override
  State<EmptyUpcoming> createState() => _EmptyUpcomingState();
}

class _EmptyUpcomingState extends State<EmptyUpcoming> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Container(
      width: devwidth * 0.1,
      height: devheight * 0.22,
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
            padding: EdgeInsets.only(
              top: devwidth * 0.04,
              right: devwidth * 0.04,
              left: devwidth * 0.04,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset('assets/images/i.svg'),
                        SizedBox(width: devwidth * 0.02),
                        Text(
                          S.of(context).UpcomingReminder,
                          style: TextStyle(
                            color: Color(0xff707070),
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: devwidth * 0.2),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: devheight * 0.005,
                        vertical: devwidth * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xfffdecec),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.medicine.time,
                        style: TextStyle(
                          color: Color(0xffda3e3e),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                Text(
                  widget.medicine.medicationName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff111111),
                  ),
                ),

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
              SizedBox(width: devwidth * 0.04),
              Container(height: 40, width: 1, color: Color(0xffe2e2e2)),

              SizedBox(width: devwidth * 0.02),
            ],
          ),
        ],
      ),
    );
  }
}
