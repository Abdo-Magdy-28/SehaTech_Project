import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/screens/Hospitals/hospitaldetails.dart';
import 'package:grad_project/screens/map.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({super.key, required this.hospital});
  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final locale = Localizations.localeOf(context).languageCode;
    final isAr = locale == 'ar';
    final displayName = isAr ? hospital.nameAr : hospital.name;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Hospitaldetails(hospital: hospital, devheight: devheight),
          ),
        );
      },
      child: Directionality(
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            constraints: const BoxConstraints(minHeight: 75),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xffF0F0F0),
              border: Border.all(
                color: const Color.fromARGB(115, 199, 198, 198),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 8.0,
                            ),
                            child: SizedBox(
                              width: 37,
                              child: SvgPicture.asset(
                                "assets/images/hospitals/Frame2147226186.svg",
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    displayName,
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff33384B),
                                      fontFamily: 'Cairo',
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    hospital.category,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff6d6d6d),
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
                      // ── bottom row: rating + time ──────────────
                      Padding(
                        padding: const EdgeInsetsDirectional.only(
                          start: 32.0,
                          top: 4,
                          bottom: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "4.5",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xff33384B),
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: Image.asset('assets/images/Star.png'),
                                ),
                              ],
                            ),
                            const SizedBox(width: 15),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: Image.asset('assets/images/Time.png'),
                                ),
                                Text(
                                  hospital.openTime,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    color: Color(0xff33384B),
                                    fontFamily: 'Cairo',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // ── right column: view button + directions ──────────
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    end: 10,
                    top: 10,
                    bottom: 8,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 27,
                        width: 71,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff0D61EC),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).view,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Mapscreen(
                                targetLat: hospital.latitude,
                                targetLng: hospital.longitude,
                                targetName: displayName,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: SvgPicture.asset(
                                'assets/images/lets-icons_map-duotone.svg',
                              ),
                            ),
                            Text(
                              S.of(context).directions,
                              style: const TextStyle(
                                fontSize: 10,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w400,
                                color: Color(0xffAAB6C3),
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
      ),
    );
  }
}
