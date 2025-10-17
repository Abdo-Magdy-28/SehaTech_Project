import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grad_project/screens/signin.dart';
import 'package:grad_project/screens/signupform.dart';
import 'package:grad_project/screens/signupscreen2.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const Signupform(),
    );
  }
}
