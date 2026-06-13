import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class hearttopic extends StatelessWidget {
  const hearttopic({super.key});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(
      'https://www.aljazeeramubasher.net/news/health/2025/1/15/%D9%83%D9%8A%D9%81-%D9%8A%D9%85%D9%83%D9%86-%D8%A7%D9%84%D8%AA%D8%B9%D8%A7%D9%85%D9%84-%D9%85%D8%B9-%D8%A7%D9%84%D8%A3%D9%85%D8%B1%D8%A7%D8%B6-%D8%A7%D9%84%D9%85%D8%B2%D9%85%D9%86%D8%A9',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 25.0),
      child: SizedBox(
        width: 298,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Image.asset("assets/images/Sign-up-cards-BG.png"),
            Positioned(
              top: 20,
              left: 10,
              child: Text(
                S.of(context).heartTopicTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
            ),
            Positioned(
              right: -15,
              top: -35,
              child: SizedBox(
                height: 190,
                width: 150,
                child: Image.asset(
                  "assets/images/Doctor.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              left: 10,
              top: 100,
              child: GestureDetector(
                onTap: _launchUrl, // 👈 updated
                child: Row(
                  children: [
                    Text(
                      S.of(context).learnMore,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SvgPicture.asset("assets/images/Vector10.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
