import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:grad_project/screens/Homepage.dart';
import 'package:grad_project/screens/loginpage.dart';
import 'package:grad_project/screens/map.dart';
import 'package:grad_project/screens/splashscreen.dart';

Future<void> main() async {
  debugPaintSizeEnabled = false;
  // await dotenv.load();
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
      home: Loginpage(),
    );
  }
}
