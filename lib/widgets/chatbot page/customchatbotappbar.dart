import 'package:flutter/material.dart';

class Customchatbotappbar extends StatelessWidget {
  const Customchatbotappbar({super.key});

  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: devheight * 0.08,
      width: devwidth * 0.8,
      child: SizedBox(
        height: 40,
        width: 40,
        child: Center(
          child: Text(
            "Chat Bot",
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              color: Color(0xff111111),
              fontSize: 24,
            ),
          ),
        ),
      ),
    );
  }
}
