import 'package:flutter/material.dart';

class Chatsuggestedbuttons extends StatefulWidget {
  const Chatsuggestedbuttons({
    super.key,
    required this.func,
    required this.name,
  });
  final VoidCallback func;
  final String name;
  @override
  State<Chatsuggestedbuttons> createState() => _ChatsuggestedbuttonsState();
}

class _ChatsuggestedbuttonsState extends State<Chatsuggestedbuttons> {
  @override
  Widget build(BuildContext context) {
    final devheight = MediaQuery.of(context).size.height;
    final devwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.func,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xff6B9CEE)),
        ),
        child: Center(
          child: Text(
            widget.name,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
