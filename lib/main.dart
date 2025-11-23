import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:grad_project/screens/map.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SEHA TECH',
      theme: ThemeData(),
      home: Mapscreen(),
    );
  }
}
