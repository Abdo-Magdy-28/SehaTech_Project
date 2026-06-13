import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/cubit/notification/notificationcubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Profile/profile.dart';
import 'package:grad_project/screens/notifications/notification_screen.dart';
import 'package:grad_project/services/Notification/notificationservice.dart';

class Customappbar extends StatelessWidget {
  const Customappbar({super.key});

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: devheight * 0.06,
      width: devwidth * 0.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/images/profile.svg',
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Row(
            children: [
              Icon(Icons.location_on, size: 16),
              Text(
                S.of(context).qalubia,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  color: Color(0xff111111),
                ),
              ),
              Text(","),
              Text(
                S.of(context).banha,
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  color: Color(0xff111111),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider(
                    create: (context) =>
                        NotificationCubit(NotificationService()),
                    child: NotificationScreen(),
                  ),
                ),
              );
            },
            child: Badge(
              backgroundColor: Colors.red,
              smallSize: 13,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  'assets/images/bell.svg',
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
