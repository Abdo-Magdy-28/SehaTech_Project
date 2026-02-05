import 'package:flutter/material.dart';

class Customchatbotappbar extends StatelessWidget
    implements PreferredSizeWidget {
  const Customchatbotappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,

      title: Text(
        "Chat Bot",
        style: TextStyle(
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700,
          color: Color(0xff111111),
          fontSize: 20,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
