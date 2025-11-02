import 'package:flutter/material.dart';

class categorysrow extends StatelessWidget {
  const categorysrow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Icon(Icons.access_alarms, color: Color(0xff0D61EC)),
              Text(
                "Doctors",
                style: TextStyle(
                  color: Color(0xff0D61EC),
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(Icons.access_alarms, color: Color(0xff0D61EC)),
              Text(
                "Doctors",
                style: TextStyle(
                  color: Color(0xff0D61EC),
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(Icons.access_alarms, color: Color(0xff0D61EC)),
              Text(
                "Doctors",
                style: TextStyle(
                  color: Color(0xff0D61EC),
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Icon(Icons.access_alarms, color: Color(0xff0D61EC)),
              Text(
                "Doctors",
                style: TextStyle(
                  color: Color(0xff0D61EC),
                  fontFamily: 'LeagueSpartan',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
