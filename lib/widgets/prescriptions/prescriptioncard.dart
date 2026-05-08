import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/models/prescription_model.dart';

class PrescriptionCard extends StatelessWidget {
  final Prescription prescription;
  final VoidCallback? onMorePressed;

  const PrescriptionCard({
    super.key,
    required this.prescription,
    this.onMorePressed,
  });

  Color get _dateBackgroundColor {
    switch (prescription.status) {
      case PrescriptionStatus.active:
        return const Color(0xFF53cc79); // green
      case PrescriptionStatus.upcoming:
        return const Color(0xFFFEF3C7); // yellow/amber
      case PrescriptionStatus.expired:
        return const Color(0xFFFEE2E2); // red/pink
    }
  }

  Color get _dateTextColor {
    switch (prescription.status) {
      case PrescriptionStatus.active:
        return Colors.white;
      case PrescriptionStatus.upcoming:
        return const Color(0xFFD97706);
      case PrescriptionStatus.expired:
        return const Color(0xFFDC2626);
    }
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;

    final double cardPadding = sw * 0.04;
    final double iconSize = sw * 0.10;
    final double titleSize = sw * 0.042;
    final double subtitleSize = sw * 0.0384;
    final double badgeFontSize = sw * 0.035;
    final double verticalGap = sh * 0.008;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: sw * 0.04, vertical: sh * 0.006),
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        color: const Color(0xffebebeb),
        borderRadius: BorderRadius.circular(sw * 0.04),
        border: Border.all(color: const Color(0xFFbfbfbf), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // LEFT CONTENT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ICON + NAME
                Row(
                  children: [
                    //Icon
                    Container(
                      width: iconSize,
                      height: iconSize,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEFF6FF),
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "assets/images/prescribtions/Frame2147226186.svg",
                      ),
                    ),

                    SizedBox(width: sw * 0.02),
                    //  Medicine Name
                    Expanded(
                      child: Text(
                        prescription.medicineName,
                        style: TextStyle(
                          fontSize: titleSize,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Cairo',
                          color: const Color(0xFF111111),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalGap),

                // DESCRIPTION
                Row(
                  children: [
                    SizedBox(width: sw * 0.02),
                    Expanded(
                      child: Text(
                        prescription.description,
                        style: TextStyle(
                          fontSize: subtitleSize,
                          color: const Color(0xFF686868),
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: verticalGap),

                // CAPSULES + DATE
                Row(
                  children: [
                    // Capsule badge
                    Container(
                      height: sh * 0.04,
                      width: sw * 0.36,
                      padding: EdgeInsets.symmetric(
                        horizontal: sw * 0.01,
                        vertical: sh * 0.004,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(sw * 0.05),
                      ),
                      child: Center(
                        child: Text(
                          prescription.capsuleCount,
                          style: TextStyle(
                            fontSize: badgeFontSize,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: sw * 0.05),

                    // Date range badge
                    Flexible(
                      child: Container(
                        height: sh * 0.04,
                        width: sw * 0.35,
                        padding: EdgeInsets.symmetric(
                          horizontal: sw * 0.03,
                          vertical: sh * 0.004,
                        ),
                        decoration: BoxDecoration(
                          color: _dateBackgroundColor,
                          borderRadius: BorderRadius.circular(sw * 0.05),
                        ),
                        child: Center(
                          child: Text(
                            prescription.dateRange,
                            style: TextStyle(
                              fontSize: badgeFontSize,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w600,
                              color: _dateTextColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onMorePressed,
            child: SizedBox(
              width: sw * 0.08,
              height: sw * 0.08,
              child: SvgPicture.asset('assets/images/prescribtions/CTA.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
