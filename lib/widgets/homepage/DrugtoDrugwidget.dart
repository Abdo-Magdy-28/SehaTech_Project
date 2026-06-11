import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugCubit.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Drug%20Interactions/drugToDrugScreen.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DrugInteractionCheckerCard
//
// Fully responsive card widget.
// • Uses LayoutBuilder + MediaQuery so it looks good on phones, tablets,
//   and wide screens alike.
// • All copy goes through S.of(context) – see the four ARB keys below.
// • RTL-aware: arrow icon flips for Arabic.
// ─────────────────────────────────────────────────────────────────────────────

class DrugInteractionCheckerCard extends StatelessWidget {
  const DrugInteractionCheckerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final screenWidth = MediaQuery.of(context).size.width;

    // ── Responsive scale tokens ──────────────────────────────────────────────
    // Breakpoints: compact < 360, normal 360–599, wide ≥ 600
    final bool isCompact = screenWidth < 360;
    final bool isWide = screenWidth >= 600;

    final double hPadding = isCompact
        ? 12
        : isWide
        ? 24
        : 16;
    final double vPadding = isCompact
        ? 12
        : isWide
        ? 20
        : 16;
    final double hMargin = isWide ? screenWidth * 0.04 : 16;
    final double borderRadius = isWide ? 20 : 16;

    final double iconSize = isCompact
        ? 24
        : isWide
        ? 34
        : 28;
    final double overlayIconSize = isCompact
        ? 13
        : isWide
        ? 19
        : 16;
    final double iconContainerSize = isCompact
        ? 30
        : isWide
        ? 44
        : 36;

    final double badgeFontSize = isCompact
        ? 10
        : isWide
        ? 13
        : 12;
    final double badgePadH = isCompact
        ? 8
        : isWide
        ? 14
        : 12;
    final double badgePadV = isCompact
        ? 3
        : isWide
        ? 5
        : 4;

    final double titleFontSize = isCompact
        ? 16
        : isWide
        ? 22
        : 19;
    final double subtitleFontSize = isCompact
        ? 11
        : isWide
        ? 14
        : 13;
    final double ctaFontSize = isCompact
        ? 12
        : isWide
        ? 15
        : 14;
    final double ctaArrowSize = isCompact
        ? 20
        : isWide
        ? 28
        : 24;
    final double ctaArrowIconSize = isCompact
        ? 10
        : isWide
        ? 14
        : 12;

    final double gapAfterIcon = isCompact
        ? 8
        : isWide
        ? 14
        : 12;
    final double gapAfterSubtitle = isCompact
        ? 10
        : isWide
        ? 18
        : 14;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: hMargin, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F3F5),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPadding, vertical: vPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ── Top row: pill icon  ←→  "New" badge ─────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PillIcon(
                  containerSize: iconContainerSize,
                  iconSize: iconSize,
                  overlaySize: overlayIconSize,
                ),
                _NewBadge(
                  label: l.newLabel,
                  fontSize: badgeFontSize,
                  padH: badgePadH,
                  padV: badgePadV,
                ),
              ],
            ),

            SizedBox(height: gapAfterIcon),

            // ── Title ────────────────────────────────────────────────────────
            Text(
              l.drugInteractionChecker,
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF111827),
                height: 1.25,
              ),
            ),

            const SizedBox(height: 4),

            // ── Subtitle ─────────────────────────────────────────────────────
            Text(
              l.drugInteractionSubtitle,
              style: TextStyle(
                fontSize: subtitleFontSize,
                color: const Color(0xFF6B7280),
                height: 1.45,
              ),
            ),

            SizedBox(height: gapAfterSubtitle),

            // ── CTA ──────────────────────────────────────────────────────────
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => DrugInteractionCubit(),
                    child: const DrugInteractionScreen(),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      l.findYourDrugsInteractions,
                      style: TextStyle(
                        fontSize: ctaFontSize,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2563EB),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 6),
                  _ArrowCircle(
                    size: ctaArrowSize,
                    iconSize: ctaArrowIconSize,
                    isRtl: isRtl,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Sub-widgets ──────────────────────────────────────────────────────────────

class _PillIcon extends StatelessWidget {
  const _PillIcon({
    required this.containerSize,
    required this.iconSize,
    required this.overlaySize,
  });

  final double containerSize;
  final double iconSize;
  final double overlaySize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: containerSize,
      height: containerSize,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SvgPicture.asset("assets/images/Drugtodrug/Frame 2147226274.svg"),
        ],
      ),
    );
  }
}

class _NewBadge extends StatelessWidget {
  const _NewBadge({
    required this.label,
    required this.fontSize,
    required this.padH,
    required this.padV,
  });

  final String label;
  final double fontSize;
  final double padH;
  final double padV;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: padH, vertical: padV),
      decoration: BoxDecoration(
        color: const Color(0xFF2563EB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class _ArrowCircle extends StatelessWidget {
  const _ArrowCircle({
    required this.size,
    required this.iconSize,
    required this.isRtl,
  });

  final double size;
  final double iconSize;
  final bool isRtl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF2563EB),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isRtl
            ? Icons.arrow_back_ios_new_rounded
            : Icons.arrow_forward_ios_rounded,
        color: Colors.white,
        size: iconSize,
      ),
    );
  }
}

// ─── Placeholder destination ──────────────────────────────────────────────────
