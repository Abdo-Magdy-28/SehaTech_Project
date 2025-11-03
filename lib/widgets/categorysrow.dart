import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class categorysrow extends StatelessWidget {
  const categorysrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              SvgPicture.asset('assets/images/doctor.svg'),
              Text(
                "Doctors",
                style: TextStyle(
                  color: Color(0xff0D61EC),
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SvgPicture.asset('assets/images/pharmacies.svg'),
              Text(
                "Pharmacies",
                style: TextStyle(
                  color: Color(0xff0D61EC),
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SvgPicture.asset('assets/images/hospital.svg'),
              Text(
                "Hospitals",
                style: TextStyle(
                  color: Color(0xff0D61EC),
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SvgPicture.asset('assets/images/medicine.svg'),
              Text(
                "Medicines",
                style: TextStyle(
                  color: Color(0xff0D61EC),
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
