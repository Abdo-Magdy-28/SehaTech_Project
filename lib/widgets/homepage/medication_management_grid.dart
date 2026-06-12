import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/cubit/Reminder/ReminderCubit.dart';
import 'package:grad_project/cubit/profile/Health%20Matrix/HealthmatrixCubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Profile/healthmatrix.dart';
import 'package:grad_project/screens/medicines/allmedicines.dart';
import 'package:grad_project/screens/prescriptions/all_prescriptions.dart';
import 'package:grad_project/screens/prescriptions/reminder_screen.dart';
import 'package:grad_project/services/Authservice.dart';

class MedicationManagementGrid extends StatefulWidget {
  const MedicationManagementGrid({
    super.key,
    required this.devwidth,
    required this.devheight,
  });
  final double devwidth;
  final double devheight;

  @override
  State<MedicationManagementGrid> createState() =>
      _MedicationManagementGridState();
}

class _MedicationManagementGridState extends State<MedicationManagementGrid> {
  String userName = '';
  String subtitle = '';
  String id = '';
  String token = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = await AuthService().getUserData();
      if (mounted) {
        setState(() {
          if (user != null) {
            userName = user.fullName;
            subtitle = user.email;
            id = user.id;
            token = user.token;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to load profile. Please restart the app.'),
          ),
        );
      }
    }
  }

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
                  height: widget.devheight * 0.18,
                  width: widget.devwidth * 0.44,
                  child: Image.asset(
                    'assets/images/Sign-up-cards-BG.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.04,
                  child: SvgPicture.asset('assets/images/timeicon.svg'),
                ),
                Positioned(
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.16,
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
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.3,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AllPrescriptions(),
                        ),
                      );
                    },
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
                  height: widget.devheight * 0.18,
                  width: widget.devwidth * 0.44,
                  child: Image.asset(
                    'assets/images/Sign-up-cards-BG.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.04,
                  child: SvgPicture.asset('assets/images/searchicon.svg'),
                ),
                Positioned(
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.16,
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
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.3,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Allmedicines()),
                      );
                    },
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
        SizedBox(height: widget.devheight * 0.018),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: widget.devheight * 0.18,
                  width: widget.devwidth * 0.44,
                  child: Image.asset(
                    'assets/images/Sign-up-cards-BG.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.04,
                  child: SvgPicture.asset('assets/images/calendaricon.svg'),
                ),
                Positioned(
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.16,
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
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.3,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => ReminderCubit(),
                            child: ReminderScreen(
                              medicineName: '',
                              medicineSize: '',
                            ),
                          ),
                        ),
                      );
                    },
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
                  height: widget.devheight * 0.18,
                  width: widget.devwidth * 0.44,
                  child: Image.asset(
                    'assets/images/Sign-up-cards-BG.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.04,
                  child: SvgPicture.asset('assets/images/hearticon.svg'),
                ),
                Positioned(
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.16,
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
                  left: widget.devwidth * 0.03,
                  top: widget.devwidth * 0.3,
                  child: InkWell(
                    onTap: () {
                      if (id.isEmpty || token.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please wait...')),
                        );
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) =>
                                HealthMatrixCubit(userId: id, token: token)
                                  ..loadHealthMatrix(),
                            child: HealthMatrixScreen(),
                          ),
                        ),
                      );
                    },
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
