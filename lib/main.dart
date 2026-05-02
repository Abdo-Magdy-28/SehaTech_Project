import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Authcubit.dart';
import 'package:grad_project/firebase_options.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:grad_project/screens/Homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
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
        locale: Locale('en'),
        localizationsDelegates: [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        debugShowCheckedModeBanner: false,
        title: 'SEHA TECH',
        theme: ThemeData(),
        home: Homepage(),
      ),
    );
  }
}
