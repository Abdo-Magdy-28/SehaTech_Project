import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';

class prevent_diseases extends StatelessWidget {
  const prevent_diseases({super.key});

  Future<void> _launchUrl() async {
    final Uri url = Uri.parse(
      'https://www.webteb.com/articles/%D8%A7%D9%84%D9%88%D9%82%D8%A7%D9%8A%D8%A9-%D9%85%D9%86-%D8%A7%D9%84%D8%A7%D9%85%D8%B1%D8%A7%D8%B6-%D8%A7%D9%84%D9%85%D8%B9%D8%AF%D9%8A%D8%A9_26518',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 149,
      width: 298,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset("assets/images/Group 24090.png"),
          Positioned(
            top: 20,
            left: 10,
            child: Text(
              S.of(context).preventDiseasesTitle,
              style: TextStyle(
                color: Color(0xff111111),
                fontFamily: 'Cairo',
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
          Positioned(
            right: 1,
            top: -15,
            child: SizedBox(
              height: 160,
              width: 140,
              child: Image.asset(
                "assets/images/Health technology and medical monitoring device.png",
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
                      color: Color(0xff111111),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: SvgPicture.asset("assets/images/Icons10.svg"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
