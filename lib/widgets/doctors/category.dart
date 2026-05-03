import 'package:flutter/material.dart';

Padding alldoctorscategory({required String name, required String image}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Color(0xff0D61EC),
          ),
          child: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(image, fit: BoxFit.contain),
            ),
          ),
        ),
        Text(name, style: TextStyle(color: Color(0xff0D5FA7), fontSize: 10)),
      ],
    ),
  );
}
