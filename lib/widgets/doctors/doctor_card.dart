import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/widgets/doctors/doctor_details.dart';

class Doctorcard extends StatelessWidget {
  const Doctorcard({
    super.key,
    required this.job,
    required this.hospital,
    required this.rate,
    required this.begindate,
    required this.enddate,
    required this.name,
    required this.doctorimage,
    required this.profile,
  });

  final Image doctorimage;
  final double rate;
  final String job, hospital, begindate, enddate, name, profile;

  void _showImagePopup(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(16), // ✅ كان 32، كبّرناه
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: double.infinity, // ✅ بدل الـ fixed width
                  height: 500, // ✅ ارفع الرقم ده براحتك
                  child: FittedBox(fit: BoxFit.cover, child: doctorimage),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                S.of(context).doctorTitle(name),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "$job | $hospital",
                style: const TextStyle(
                  color: Colors.white70,
                  fontFamily: 'Cairo',
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final scale = (screenWidth / 360).clamp(0.85, 1.3);

    final double imageSize = 40 * scale;
    final double nameFontSize = 13 * scale;
    final double subFontSize = 11 * scale;
    final double rateFontSize = 12 * scale;
    final double starSize = 15 * scale;
    final double btnHeight = 26 * scale;
    final double btnWidth = 68 * scale;
    final double btnFontSize = 9 * scale;
    final double dirIconSize = 22 * scale;
    final double dirFontSize = 9 * scale;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoctorDetails(
                name: name,
                begindate: begindate,
                enddate: enddate,
                hospital: hospital,
                job: job,
                rate: rate,
                doctorimage: doctorimage,
                urlprofile: profile,
              ),
            ),
          );
        },
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ── Doctor image with tap ──
                            GestureDetector(
                              onTap: () => _showImagePopup(context),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: SizedBox(
                                  width: imageSize,
                                  height: imageSize,
                                  child: ClipOval(child: doctorimage),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).doctorTitle(name),
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
                                      "$job | $hospital",
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
                        Padding(
                          padding: EdgeInsetsDirectional.only(
                            start: imageSize + 16,
                            top: 4,
                            bottom: 6,
                          ),
                          child: Row(
                            children: [
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
                      Container(
                        height: btnHeight,
                        width: btnWidth,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: const Color(0xff0D61EC),
                        ),
                        child: Center(
                          child: Text(
                            S.of(context).bookNow,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w400,
                              fontSize: btnFontSize,
                            ),
                          ),
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
