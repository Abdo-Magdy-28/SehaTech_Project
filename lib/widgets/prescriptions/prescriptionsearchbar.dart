import 'package:flutter/material.dart';
import 'package:grad_project/generated/l10n.dart';

class PrescriptionsSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const PrescriptionsSearchBar({
    super.key,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final devwidth = MediaQuery.of(context).size.width;
    final devheight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: devwidth * 0.04,
        vertical: devheight * 0.012,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(devwidth * 0.08),
          border: Border.all(color: Color(0xff686868)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          style: TextStyle(fontSize: devwidth * 0.038, fontFamily: 'Cairo'),
          decoration: InputDecoration(
            hintText: S.of(context).searching,
            hintStyle: TextStyle(
              color: Color(0xff686868),
              fontSize: devwidth * 0.038,
              fontFamily: 'Cairo',
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Color(0xff686868),
              size: devwidth * 0.055,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(devwidth * 0.08),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: devheight * 0.015),
          ),
        ),
      ),
    );
  }
}
