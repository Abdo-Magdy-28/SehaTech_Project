import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({
    super.key,
    required this.title,
    required this.hint,
    required this.image,
  });
  final String title, hint, image;

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: Container(
            width: devwidth * 0.9,
            height: devheight * 0.2,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: AssetImage("assets/images/Sign-up-cards-BG.png"),
              ),
            ),
          ),
        ),
        Positioned(
          left: 30,
          top: 15,
          child: SizedBox(
            width: devwidth * 0.45,
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,

                    fontSize: 18,
                  ),
                ),
                Text(
                  hint,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: devwidth * 0.05,
          bottom: devheight * 0.004,
          child: SizedBox(
            width: devwidth * 0.45,
            child: Image.asset(image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: 130,
          bottom: 50,
          child: SvgPicture.asset(
            "assets/images/Button container.svg",
            width: devwidth * 0.13,
          ),
        ),
        Positioned(
          right: 15,
          bottom: 1,
          child: SvgPicture.asset(
            "assets/images/Switch container.svg",
            width: devwidth * 0.11,
          ),
        ),
      ],
    );
  }
}

/*Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    width: devwidth * 0.9,
                    height: devheight * 0.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: AssetImage("assets/images/Sign-up-cards-BG.png"),
                      ),
                    ),
                  ),
                ),

                Positioned(
                  bottom: 10,
                  right: 25,
                  child: SizedBox(
                    width: devwidth * 0.95,
                    height: devheight * 0.25,
                    child: Image.asset(
                      'assets/images/Sign-up-card01.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),*/
