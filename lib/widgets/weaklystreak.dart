import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Reminder/StreakReminder.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class Weaklystreak extends StatelessWidget {
  const Weaklystreak({super.key});

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => StreakCubit()..loadStreak(),
      child: BlocBuilder<StreakCubit, StreakState>(
        builder: (context, state) {
          if (state is StreakLoading) {
            // 🔥 Shimmer effect only on text placeholders
            return Container(
              width: devwidth * 0.15,
              height: devheight * 0.2,
              decoration: BoxDecoration(
                color: const Color(0xffedf6ff),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: devwidth * 0.007),
                          SvgPicture.asset(
                            'assets/images/Frame 3.svg',
                          ), // ✅ keep image
                          SizedBox(width: devwidth * 0.03),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 100,
                              height: 16,
                              color: Colors.grey[300], // shimmer block
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: devheight * 0.01),
                      Row(
                        children: [
                          SizedBox(width: devwidth * 0.01),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 60,
                              height: 32,
                              color: Colors.grey[300],
                            ),
                          ),
                          SizedBox(width: devwidth * 0.03),
                          SvgPicture.asset(
                            'assets/images/Frame 2147226112.svg',
                          ), // ✅ keep image
                          SizedBox(width: devwidth * 0.004),
                          Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              width: 80,
                              height: 13,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/images/Frame 2147226115.svg',
                  ), // ✅ keep image
                ],
              ),
            );
          } else if (state is StreakLoaded) {
            final streak = state.streak;

            return Container(
              width: devwidth * 0.15,
              height: devheight * 0.2,
              decoration: BoxDecoration(
                color: const Color(0xffedf6ff),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: devwidth * 0.007),
                          SvgPicture.asset('assets/images/Frame 3.svg'),
                          SizedBox(width: devwidth * 0.03),
                          Text(
                            S.of(context).weeklyStreak,
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: devheight * 0.01),
                      Row(
                        children: [
                          SizedBox(width: devwidth * 0.01),
                          Text(
                            S
                                .of(context)
                                .weeklyPercentage(streak.streakPercentage),
                            style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            ),
                          ),
                          SizedBox(width: devwidth * 0.03),
                          SvgPicture.asset(
                            'assets/images/Frame 2147226112.svg',
                          ),
                          SizedBox(width: devwidth * 0.004),
                          Text(
                            S.of(context).missedThisWeek(streak.missedDays),
                            style: const TextStyle(
                              color: Color(0xffef4444),
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset('assets/images/Frame 2147226115.svg'),
                ],
              ),
            );
          } else if (state is StreakError) {
            return Text("Error: ${state.message}");
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
