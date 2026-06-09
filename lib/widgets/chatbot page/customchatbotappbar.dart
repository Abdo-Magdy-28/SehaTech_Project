import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';

class Customchatbotappbar extends StatelessWidget
    implements PreferredSizeWidget {
  const Customchatbotappbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,

      title: Text(
        S.of(context).chatbot,
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
