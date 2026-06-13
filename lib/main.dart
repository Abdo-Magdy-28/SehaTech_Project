import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/cubit/Authentication/Authcubit.dart';
import 'package:grad_project/cubit/Drug%20To%20Drug%20Interaction/drugToDrugCubit.dart';
import 'package:grad_project/cubit/Reminder/DailyReminder.dart';
import 'package:grad_project/cubit/Reminder/ReminderCubit.dart';
import 'package:grad_project/cubit/Reminder/StreakReminder.dart';
import 'package:grad_project/cubit/doctors/cubit/doctors_cubit.dart';
import 'package:grad_project/cubit/doctors/popular/popularcubit.dart';
import 'package:grad_project/cubit/language/locale_cubit.dart';
import 'package:grad_project/cubit/pharmacies/pharmaciesCubit.dart';
import 'package:grad_project/cubit/search/Hospitals/Hospitalcubit.dart';
import 'package:grad_project/cubit/search/medicine/medicine_search.dart';
import 'package:grad_project/firebase_options.dart';
import 'package:grad_project/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grad_project/screens/splashscreen.dart';
import 'package:grad_project/services/pharmacies/pharmaciesService.dart';
import 'package:grad_project/services/search%20services/doctors/search_service.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  debugPaintSizeEnabled = false;
  WidgetsFlutterBinding.ensureInitialized();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'medication_channel',
      channelName: 'Medication Reminders',
      channelDescription: 'Reminder notifications for medications',
      defaultColor: Colors.teal,
      importance: NotificationImportance.High,
      channelShowBadge: true,
    ),
  ]);
  AwesomeNotifications().isNotificationAllowed().then((allowed) {});
  cameras = await availableCameras();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(BlocProvider(create: (_) => LocaleCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DoctorCubit>(create: (_) => DoctorCubit()),
        BlocProvider(create: (_) => Authcubit()),
        BlocProvider(create: (_) => DailyScheduleCubit()),
        BlocProvider(create: (_) => StreakCubit()),
        BlocProvider(create: (_) => DrugInteractionCubit()),
        BlocProvider<PharmacyCubit>(
          create: (_) => PharmacyCubit(PharmacyService()),
        ),
        BlocProvider(create: (_) => HospitalCubit()),
        BlocProvider(create: (_) => MedicineCubit()),
        BlocProvider(create: (_) => ReminderCubit()),
        BlocProvider(
          create: (_) => SearchDoctorCubit(searchService: SearchService()),
        ),
      ],
      child: BlocBuilder<LocaleCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
            locale: locale,
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
            home: Splashscreen(),
          );
        },
      ),
    );
  }
}
