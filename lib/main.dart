import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Authcubit.dart';
import 'package:grad_project/firebase_options.dart';
import 'package:grad_project/screens/Homepage.dart';
import 'package:grad_project/screens/alldoctors.dart';
import 'package:grad_project/screens/doctor_details.dart';
import 'package:grad_project/screens/loginpage.dart';
import 'package:grad_project/screens/map.dart';
import 'package:grad_project/screens/splashscreen.dart';
import 'package:grad_project/screens/verifyidentity.dart';

Future<void> main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Authcubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SEHA TECH',
        theme: ThemeData(),
        home: Splashscreen(),
      ),
    );
  }
}
