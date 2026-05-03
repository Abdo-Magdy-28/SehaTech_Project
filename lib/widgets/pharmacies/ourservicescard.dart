import 'package:flutter/material.dart';

class Ourservicescard extends StatelessWidget {
  const Ourservicescard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });
  final String image;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Container(
      width: devwidth * 0.45,
      height: devheight * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xff0D61EC),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: devheight * 0.003),
          Image.asset(image, scale: devwidth * 0.01),
          SizedBox(height: devheight * 0.004),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: devheight * 0.004),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
