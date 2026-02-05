import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:grad_project/models/Chatbot%20Models/chathistorymodel.dart';

class Historywidget extends StatelessWidget {
  Historywidget({super.key, required this.model});
  final Chathistorymodel model;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,

          border: BorderDirectional(bottom: BorderSide()),
        ),
        child: Row(
          children: [
            SvgPicture.asset("assets/images/Caht-Bot01.svg"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(model.headtitle, style: TextStyle(fontSize: 15)),
                Text(model.secondtitle, style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
