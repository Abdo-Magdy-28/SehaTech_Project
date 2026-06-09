// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/generated/l10n.dart';

void showCustomDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      final size = MediaQuery.of(context).size;
      return Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(maxWidth: 400),
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.06,
            vertical: size.height * 0.03,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/images/Profile/spot-icon.svg'),

              SizedBox(height: size.height * 0.02),

              Text(
                S.of(context).discardchanges,
                style: TextStyle(
                  fontSize: size.width * 0.05,
                  fontFamily: 'Syne',
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 8),

              Text(
                S.of(context).unsavedchangeswillbelost,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.width * 0.035,
                  color: Color(0xff2b2d3f),
                  fontFamily: 'Syne',
                ),
              ),

              SizedBox(height: size.height * 0.03),

              // Discard Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: Color(0xff2260ff),
                  ),
                  child: Text(
                    S.of(context).yesdiscard,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12),

              // Keep Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    side: BorderSide(color: Color(0xff2260ff), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    S.of(context).nokeepchanges,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                      color: Color(0xff2260ff),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
