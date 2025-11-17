import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarouselCard2 extends StatelessWidget {
  const CarouselCard2({
    super.key,
    required this.title,
    required this.hint,
    required this.image,
  });

  final String title, hint, image;

  @override
  Widget build(BuildContext context) {
    final dev = MediaQuery.of(context).size;
    final cardWidth = dev.width * 0.9;
    final cardHeight = dev.height * 0.20;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background container
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: const DecorationImage(
              image: AssetImage("assets/images/Sign-up-cards-BG.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Text section
        Positioned(
          left: cardWidth * 0.02,
          top: cardHeight * 0.05,
          child: SizedBox(
            width: cardWidth * 0.5,
            child: Column(
              spacing: 5,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  hint,
                  style: const TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Main image
        Positioned(
          right: -30,
          top: -40,
          child: SizedBox(
            width: cardWidth * 0.7,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
      ],
    );
  }
}
