import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';

class MedicationManagementGrid extends StatelessWidget {
  const MedicationManagementGrid({
    super.key,
    required this.devwidth,
    required this.devheight,
  });
  final double devwidth;
  final double devheight;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: devheight * 0.18,
                  width: devwidth * 0.44,
                  child: Image.asset(
                    'assets/images/Sign-up-cards-BG.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.04,
                  child: SvgPicture.asset('assets/images/timeicon.svg'),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.16,
                  child: Text(
                    S.of(context).getRemindersPills,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.3,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          S.of(context).learnMore,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SizedBox(
                  height: devheight * 0.18,
                  width: devwidth * 0.44,
                  child: Image.asset(
                    'assets/images/Sign-up-cards-BG.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.04,
                  child: SvgPicture.asset('assets/images/searchicon.svg'),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.16,
                  child: Text(
                    S.of(context).findAboutMedicine,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.3,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          S.of(context).learnMore,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: devheight * 0.018),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: devheight * 0.18,
                  width: devwidth * 0.44,
                  child: Image.asset(
                    'assets/images/Sign-up-cards-BG.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.04,
                  child: SvgPicture.asset('assets/images/calendaricon.svg'),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.16,
                  child: Text(
                    S.of(context).setRemindersTime,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.3,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          S.of(context).learnMore,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Stack(
              children: [
                SizedBox(
                  height: devheight * 0.18,
                  width: devwidth * 0.44,
                  child: Image.asset(
                    'assets/images/Sign-up-cards-BG.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.04,
                  child: SvgPicture.asset('assets/images/hearticon.svg'),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.16,
                  child: Text(
                    S.of(context).keepTrackMedicine,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Positioned(
                  left: devwidth * 0.03,
                  top: devwidth * 0.3,
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(
                          S.of(context).learnMore,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        Icon(
                          Icons.arrow_outward,
                          color: Colors.white,
                          size: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
