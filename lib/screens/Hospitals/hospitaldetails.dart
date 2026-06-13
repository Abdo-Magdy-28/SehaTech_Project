import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/models/hospitals.dart';
import 'package:grad_project/screens/map.dart';
import 'package:grad_project/widgets/pharmacies/ourservicescard.dart';

class Hospitaldetails extends StatefulWidget {
  const Hospitaldetails({
    super.key,
    required this.hospital,
    required this.devheight,
  });

  final Hospital hospital;
  final double devheight;

  @override
  State<Hospitaldetails> createState() => _HospitaldetailsState();
}

class _HospitaldetailsState extends State<Hospitaldetails> {
  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    final dw = MediaQuery.of(context).size.width;
    final scale = (dw / 360).clamp(0.85, 1.3);

    final locale = Localizations.localeOf(context).languageCode;
    final displayName = locale == 'ar'
        ? widget.hospital.nameAr
        : widget.hospital.name;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── HERO SECTION (same as PharmacyDetails) ─────────────────
            SizedBox(
              height: dh * 0.38,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: _BottomCurveClipper(),
                      child: SizedBox(
                        height: dh * 0.55,
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              "assets/images/pharmacies/bg.png",
                              fit: BoxFit.cover,
                            ),
                            Image.asset(
                              "assets/images/pharmacies/Mask group.png",
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // AppBar row
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: dw * 0.04,
                        vertical: 8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          Text(
                            S.of(context).hospitalinfo,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(width: 24),
                        ],
                      ),
                    ),
                  ),

                  // Hospital SVG icon — centered
                  Positioned(
                    top: dh * 0.15,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/images/hospitals/Frame2147226186.svg",
                        height: dh * 0.14,
                        width: dh * 0.14,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── INFO CARD (same as PharmacyDetails) ────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: dw * 0.04),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffF6F6F6),
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name + map icon
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            displayName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              Navigator.of(context, rootNavigator: true).push(
                                MaterialPageRoute(
                                  builder: (_) => Mapscreen(
                                    targetLat: widget.hospital.latitude,
                                    targetLng: widget.hospital.longitude,
                                    targetName: displayName,
                                  ),
                                ),
                              ),
                          child: SizedBox(
                            height: 40 * scale,
                            width: 40 * scale,
                            child: Image.asset(
                              "assets/images/alldoctors/Frame2147226191.png",
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Subtitle (category)
                    Text(
                      widget.hospital.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black38,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Rating
                    Row(
                      children: [
                        Text(
                          "4.5",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SizedBox(
                          height: 18,
                          width: 18,
                          child: Image.asset("assets/images/Star.png"),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Stats row: working hours | specialties count
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statItem(
                            widget.hospital.openTime,
                            S.of(context).worktime,
                          ),
                          Container(
                            width: 1,
                            color: Colors.black12,
                            height: 40,
                          ),
                          _statItem(
                            "${widget.hospital.specialties.length}",
                            S.of(context).ourservices,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Contact Us button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1555D8), Color(0xFF2260FF)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            S.of(context).contactus,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ── Our Services (specialties) ──────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: dw * 0.04, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).ourservices,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  widget.hospital.specialties.isNotEmpty
                      ? GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: dw * 0.023,
                          mainAxisSpacing: dh * 0.015,
                          childAspectRatio: 1.9,
                          children: widget.hospital.specialties
                              .map(
                                (s) => Ourservicescard(
                                  image:
                                      'assets/images/pharmacies/Frame 2147226268.png',
                                  title: s,
                                  subtitle: '',
                                ),
                              )
                              .toList(),
                        )
                      : GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: dw * 0.023,
                          mainAxisSpacing: dh * 0.015,
                          childAspectRatio: 1.9,
                          children: [
                            Ourservicescard(
                              image:
                                  'assets/images/pharmacies/Frame 2147226268.png',
                              title: 'Emergency Care',
                              subtitle: '24/7 emergency medical assistance.',
                            ),
                            Ourservicescard(
                              image:
                                  'assets/images/pharmacies/Frame 2147226268.png',
                              title: 'Outpatient',
                              subtitle:
                                  'Consultations without admission needed.',
                            ),
                            Ourservicescard(
                              image:
                                  'assets/images/pharmacies/Frame 2147226268.png',
                              title: 'Surgery',
                              subtitle:
                                  'Advanced surgical procedures available.',
                            ),
                            Ourservicescard(
                              image:
                                  'assets/images/pharmacies/Frame 2147226268.png',
                              title: 'Laboratory',
                              subtitle: 'Accurate and fast lab test results.',
                            ),
                          ],
                        ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom Curve Clipper ──────────────────────────────────────────────
class _BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height - 80,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
