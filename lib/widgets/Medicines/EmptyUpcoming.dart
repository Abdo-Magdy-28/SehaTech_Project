import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/Reminders/DailyReminder.dart';

class EmptyUpcoming extends StatefulWidget {
  const EmptyUpcoming({super.key, required this.medicine});
  final DailyMedications medicine;

  @override
  State<EmptyUpcoming> createState() => _EmptyUpcomingState();
}

class _EmptyUpcomingState extends State<EmptyUpcoming> {
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

              // ── Empty bottom row ─────────────────────────────────────────
              SizedBox(height: hPad),
            ],
          ),
        );
      },
    );
  }
}
