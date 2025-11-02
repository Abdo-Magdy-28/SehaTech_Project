import 'package:flutter/material.dart';

class chatbotslider extends StatelessWidget {
  const chatbotslider({super.key, required this.devheight});

  final double devheight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: devheight * 0.08,
      decoration: BoxDecoration(
        color: Color(0xff0D61EC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: Color(0xff111111),
              size: 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(7.0),
            child: Column(
              children: [
                Text(
                  "Discover Our Healthcare ",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "AI Assistant",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Cairo',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_forward,
              color: Color(0xff111111),
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}
