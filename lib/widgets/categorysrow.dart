import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/screens/Hospitals/allhospitals.dart';
import 'package:grad_project/screens/alldoctors.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/medicines/allmedicines.dart';
import 'package:grad_project/screens/pharmacies/allpahramcies.dart';
import 'package:grad_project/widgets/mainscaffold.dart';

class categorysrow extends StatelessWidget {
  const categorysrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MainScaffold(currentIndex: 3, child: Alldoctors()),
                ),
              );
            },
            child: Column(
              children: [
                SvgPicture.asset('assets/images/doctor.svg'),
                Text(
                  S.of(context).doctors,
                  style: TextStyle(
                    color: Color(0xff0D61EC),
                    fontFamily: 'LeagueSpartan',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MainScaffold(currentIndex: 3, child: Allpahramcies()),
                ),
              );
            },
            child: Column(
              children: [
                SvgPicture.asset('assets/images/pharmacies.svg'),
                Text(
                  S.of(context).pharmacies,
                  style: TextStyle(
                    color: Color(0xff0D61EC),
                    fontFamily: 'LeagueSpartan',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MainScaffold(currentIndex: 3, child: Allhospitals()),
                ),
              );
            },
            child: Column(
              children: [
                SvgPicture.asset('assets/images/hospital.svg'),
                Text(
                  S.of(context).hospitals,
                  style: TextStyle(
                    color: Color(0xff0D61EC),
                    fontFamily: 'LeagueSpartan',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MainScaffold(currentIndex: 3, child: Allmedicines()),
                ),
              );
            },
            child: Column(
              children: [
                SvgPicture.asset('assets/images/medicine.svg'),
                Text(
                  S.of(context).medicines,
                  style: TextStyle(
                    color: Color(0xff0D61EC),
                    fontFamily: 'LeagueSpartan',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
