import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/cubit/Reminder/DailyReminder.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/Reminders/DailyReminder.dart';

class UpcomingReminder extends StatefulWidget {
  const UpcomingReminder({super.key, required this.medicine});
  final DailyMedications medicine;

  @override
  State<UpcomingReminder> createState() => _UpcomingReminderState();
}

class _UpcomingReminderState extends State<UpcomingReminder> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isNarrow = width < 320;
        final hPad = (width * 0.04).clamp(12.0, 24.0);
        final iconGap = (width * 0.02).clamp(6.0, 12.0);

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xffefefef), width: 2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(hPad, hPad, hPad, hPad * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/i.svg',
                          width: 16,
                          height: 16,
                        ),
                        SizedBox(width: iconGap),
                        Expanded(
                          child: Text(
                            S.of(context).UpcomingReminder,
                            style: TextStyle(
                              color: const Color(0xff707070),
                              fontSize: isNarrow ? 12 : 14,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        // Time badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xfffdecec),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            widget.medicine.time,
                            style: TextStyle(
                              color: const Color(0xffda3e3e),
                              fontSize: isNarrow ? 10 : 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      widget.medicine.medicationName,
                      style: TextStyle(
                        fontSize: (width * 0.045).clamp(14.0, 20.0),
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff111111),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 2),

                    Text(
                      widget.medicine.dosage,
                      style: TextStyle(
                        fontSize: (width * 0.035).clamp(11.0, 15.0),
                        color: const Color(0xff808080),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              const Divider(color: Color(0xffe2e2e2), thickness: 1, height: 1),

              // ── Action buttons ───────────────────────────────────────────
              IntrinsicHeight(
                child: Row(
                  children: [
                    // Remind Later
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          context.read<DailyScheduleCubit>().remindLater();
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: iconGap,
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.alarm,
                              color: const Color(0xfff9783c),
                              size: (width * 0.06).clamp(18.0, 26.0),
                            ),
                            SizedBox(width: iconGap * 0.5),
                            Flexible(
                              child: Text(
                                S.of(context).RemindLater,
                                style: TextStyle(
                                  color: const Color(0xfff9783c),
                                  fontFamily: 'cairo',
                                  fontWeight: FontWeight.w600,
                                  fontSize: isNarrow ? 11 : 13,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const VerticalDivider(
                      color: Color(0xffe2e2e2),
                      thickness: 1,
                      width: 1,
                    ),

                    // Mark as Taken
                    Expanded(
                      child:
                          BlocBuilder<DailyScheduleCubit, DailyScheduleState>(
                            builder: (context, state) {
                              return TextButton(
                                onPressed: state is MarkingTaken
                                    ? null
                                    : () {
                                        context
                                            .read<DailyScheduleCubit>()
                                            .markTaken(
                                              widget.medicine,
                                              context
                                                  .read<DailyScheduleCubit>()
                                                  .selectedDate,
                                            );
                                      },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: iconGap,
                                  ),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (state is MarkingTaken)
                                      const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Color(0xff2260ff),
                                        ),
                                      )
                                    else
                                      Icon(
                                        Icons.check,
                                        color: const Color(0xff2260ff),
                                        size: (width * 0.06).clamp(18.0, 26.0),
                                      ),
                                    SizedBox(width: iconGap * 0.5),
                                    Flexible(
                                      child: Text(
                                        S.of(context).MarkasTaken,
                                        style: TextStyle(
                                          color: const Color(0xff2260ff),
                                          fontFamily: 'cairo',
                                          fontWeight: FontWeight.w600,
                                          fontSize: isNarrow ? 11 : 13,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
