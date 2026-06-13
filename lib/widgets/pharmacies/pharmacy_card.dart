import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/map.dart';

class PharmacyCard extends StatelessWidget {
  const PharmacyCard({
    super.key,
    required this.rate,
    required this.name,
    required this.isopen24,
    required this.longitude,
    required this.latitude,
  });
  final double rate, longitude, latitude;
  final String name;
  final bool isopen24;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / 360).clamp(0.85, 1.3);

    final double iconSize = 40 * scale;
    final double nameFontSize = 13 * scale;
    final double subFontSize = 11 * scale;
    final double rateFontSize = 12 * scale;
    final double starSize = 15 * scale;
    final double timeFontSize = 11 * scale;
    final double timeIconSize = 14 * scale;
    final double btnHeight = 26 * scale;
    final double btnWidth = 68 * scale;
    final double btnFontSize = 9 * scale;
    final double dirIconSize = 22 * scale;
    final double dirFontSize = 9 * scale;

    final String open24 = isopen24
        ? S.of(context).hours24
        : S.of(context).closed;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xffF0F0F0),
          border: Border.all(color: const Color.fromARGB(115, 199, 198, 198)),
        ),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Main content ─────────────────────────────────────
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon + Name + Subtitle
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: SizedBox(
                              width: iconSize,
                              height: iconSize,
                              child: SvgPicture.asset(
                                "assets/images/pharmacies/pharmacy_icon.svg",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontSize: nameFontSize,
                                      color: const Color(0xff33384B),
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    S.of(context).pharmacy,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: subFontSize,
                                      color: const Color(0xff6d6d6d),
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Rating + Open hours (محاذاة مع النص فوق)
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: iconSize + 16,
                          top: 4,
                          bottom: 6,
                        ),
                        child: Row(
                          children: [
                            // Rating
                            Text(
                              "$rate",
                              style: TextStyle(
                                fontSize: rateFontSize,
                                color: const Color(0xff33384B),
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(width: 2),
                            SizedBox(
                              height: starSize,
                              width: starSize,
                              child: Image.asset('assets/images/Star.png'),
                            ),
                            const SizedBox(width: 10),
                            // Open/Closed
                            SizedBox(
                              height: timeIconSize,
                              width: timeIconSize,
                              child: Image.asset('assets/images/Time.png'),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              open24,
                              style: TextStyle(
                                fontSize: timeFontSize,
                                color: const Color(0xff33384B),
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // ── Actions column ────────────────────────────────────
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  end: 10,
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // View button
                    Container(
                      height: btnHeight,
                      width: btnWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff0D61EC),
                      ),
                      child: Center(
                        child: Text(
                          S.of(context).view,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.w400,
                            fontSize: btnFontSize,
                          ),
                        ),
                      ),
                    ),

                    // Directions
                    GestureDetector(
                      onTap: () =>
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder: (_) => Mapscreen(
                                targetLat: latitude,
                                targetLng: longitude,
                                targetName: name,
                              ),
                            ),
                          ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: dirIconSize,
                            width: dirIconSize,
                            child: SvgPicture.asset(
                              'assets/images/lets-icons_map-duotone.svg',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            S.of(context).directions,
                            style: TextStyle(
                              fontSize: dirFontSize,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffAAB6C3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
