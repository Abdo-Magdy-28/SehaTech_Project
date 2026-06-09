// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `SEHA TECH`
  String get appName {
    return Intl.message('SEHA TECH', name: 'appName', desc: '', args: []);
  }

  /// `Health Comes First`
  String get appTagline {
    return Intl.message(
      'Health Comes First',
      name: 'appTagline',
      desc: '',
      args: [],
    );
  }

  /// `Hello`
  String get hello {
    return Intl.message('Hello', name: 'hello', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Find Doctors`
  String get findDoctors {
    return Intl.message(
      'Find Doctors',
      name: 'findDoctors',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get seeAll {
    return Intl.message('See all', name: 'seeAll', desc: '', args: []);
  }

  /// `Neurologist`
  String get neurologist {
    return Intl.message('Neurologist', name: 'neurologist', desc: '', args: []);
  }

  /// `El-Demerdash Hospital`
  String get elDemerdashHospital {
    return Intl.message(
      'El-Demerdash Hospital',
      name: 'elDemerdashHospital',
      desc: '',
      args: [],
    );
  }

  /// `Youssef Ali`
  String get youssefAli {
    return Intl.message('Youssef Ali', name: 'youssefAli', desc: '', args: []);
  }

  /// `10:30am`
  String get startTime {
    return Intl.message('10:30am', name: 'startTime', desc: '', args: []);
  }

  /// `5:30pm`
  String get endTime {
    return Intl.message('5:30pm', name: 'endTime', desc: '', args: []);
  }

  /// `Medication Management`
  String get medicationManagement {
    return Intl.message(
      'Medication Management',
      name: 'medicationManagement',
      desc: '',
      args: [],
    );
  }

  /// `Belladonna 30`
  String get belladonna30 {
    return Intl.message(
      'Belladonna 30',
      name: 'belladonna30',
      desc: '',
      args: [],
    );
  }

  /// `2 Drops | Every 2 Hour`
  String get dosage {
    return Intl.message(
      '2 Drops | Every 2 Hour',
      name: 'dosage',
      desc: '',
      args: [],
    );
  }

  /// `09:30 AM`
  String get reminderTime {
    return Intl.message('09:30 AM', name: 'reminderTime', desc: '', args: []);
  }

  /// `2 Drops`
  String get drops {
    return Intl.message('2 Drops', name: 'drops', desc: '', args: []);
  }

  /// `Every 2 Hour`
  String get everyTwoHours {
    return Intl.message(
      'Every 2 Hour',
      name: 'everyTwoHours',
      desc: '',
      args: [],
    );
  }

  /// `Important Topics`
  String get importantTopics {
    return Intl.message(
      'Important Topics',
      name: 'importantTopics',
      desc: '',
      args: [],
    );
  }

  /// `BANHA`
  String get banha {
    return Intl.message('BANHA', name: 'banha', desc: '', args: []);
  }

  /// `QALUBIA`
  String get qalubia {
    return Intl.message('QALUBIA', name: 'qalubia', desc: '', args: []);
  }

  /// `Discover Our Healthcare`
  String get discoverHealthcare {
    return Intl.message(
      'Discover Our Healthcare',
      name: 'discoverHealthcare',
      desc: '',
      args: [],
    );
  }

  /// `AI Assistant`
  String get aiAssistant {
    return Intl.message(
      'AI Assistant',
      name: 'aiAssistant',
      desc: '',
      args: [],
    );
  }

  /// `Doctors`
  String get doctors {
    return Intl.message('Doctors', name: 'doctors', desc: '', args: []);
  }

  /// `Pharmacies`
  String get pharmacies {
    return Intl.message('Pharmacies', name: 'pharmacies', desc: '', args: []);
  }

  /// `Hospitals`
  String get hospitals {
    return Intl.message('Hospitals', name: 'hospitals', desc: '', args: []);
  }

  /// `Medicines`
  String get medicines {
    return Intl.message('Medicines', name: 'medicines', desc: '', args: []);
  }

  /// `Appointment Reminder`
  String get appointmentReminder {
    return Intl.message(
      'Appointment Reminder',
      name: 'appointmentReminder',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Your Next`
  String get scheduleYourNext {
    return Intl.message(
      'Schedule Your Next',
      name: 'scheduleYourNext',
      desc: '',
      args: [],
    );
  }

  /// `Appointment`
  String get appointment {
    return Intl.message('Appointment', name: 'appointment', desc: '', args: []);
  }

  /// `with your preferred`
  String get withYourPreferred {
    return Intl.message(
      'with your preferred',
      name: 'withYourPreferred',
      desc: '',
      args: [],
    );
  }

  /// `doctors in just a few taps.`
  String get doctorsInJustFewTaps {
    return Intl.message(
      'doctors in just a few taps.',
      name: 'doctorsInJustFewTaps',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Now`
  String get scheduleNow {
    return Intl.message(
      'Schedule Now',
      name: 'scheduleNow',
      desc: '',
      args: [],
    );
  }

  /// `Dr : {name}`
  String doctorTitle(Object name) {
    return Intl.message(
      'Dr : $name',
      name: 'doctorTitle',
      desc: '',
      args: [name],
    );
  }

  /// `BOOK Now`
  String get bookNow {
    return Intl.message('BOOK Now', name: 'bookNow', desc: '', args: []);
  }

  /// `Directions`
  String get directions {
    return Intl.message('Directions', name: 'directions', desc: '', args: []);
  }

  /// `Learn more`
  String get learnMore {
    return Intl.message('Learn more', name: 'learnMore', desc: '', args: []);
  }

  /// `Get reminders for\nyour pills.`
  String get getRemindersPills {
    return Intl.message(
      'Get reminders for\nyour pills.',
      name: 'getRemindersPills',
      desc: '',
      args: [],
    );
  }

  /// `Find out about your\nmedicine.`
  String get findAboutMedicine {
    return Intl.message(
      'Find out about your\nmedicine.',
      name: 'findAboutMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Set reminders for\ndifferent times.`
  String get setRemindersTime {
    return Intl.message(
      'Set reminders for\ndifferent times.',
      name: 'setRemindersTime',
      desc: '',
      args: [],
    );
  }

  /// `Keep track of what\nyou take.`
  String get keepTrackMedicine {
    return Intl.message(
      'Keep track of what\nyou take.',
      name: 'keepTrackMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming Reminder`
  String get UpcomingReminder {
    return Intl.message(
      'Upcoming Reminder',
      name: 'UpcomingReminder',
      desc: '',
      args: [],
    );
  }

  /// `Mark as Taken`
  String get MarkasTaken {
    return Intl.message(
      'Mark as Taken',
      name: 'MarkasTaken',
      desc: '',
      args: [],
    );
  }

  /// `Remind Later`
  String get RemindLater {
    return Intl.message(
      'Remind Later',
      name: 'RemindLater',
      desc: '',
      args: [],
    );
  }

  /// `Quick Scan`
  String get quickscan {
    return Intl.message('Quick Scan', name: 'quickscan', desc: '', args: []);
  }

  /// `Weekly Streak`
  String get weeklyStreak {
    return Intl.message(
      'Weekly Streak',
      name: 'weeklyStreak',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Scan`
  String get scan {
    return Intl.message('Scan', name: 'scan', desc: '', args: []);
  }

  /// `Chatbot`
  String get chatbot {
    return Intl.message('Chatbot', name: 'chatbot', desc: '', args: []);
  }

  /// `Search`
  String get search {
    return Intl.message('Search', name: 'search', desc: '', args: []);
  }

  /// `Perscriptions`
  String get perscriptions {
    return Intl.message(
      'Perscriptions',
      name: 'perscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Scanning`
  String get scanning {
    return Intl.message('Scanning', name: 'scanning', desc: '', args: []);
  }

  /// `Scan your perscriptions and medications \nInstantly to Access Accurate Details,\n Dosage Instructions, and Safety\n Information`
  String get scanarticle1 {
    return Intl.message(
      'Scan your perscriptions and medications \nInstantly to Access Accurate Details,\n Dosage Instructions, and Safety\n Information',
      name: 'scanarticle1',
      desc: '',
      args: [],
    );
  }

  /// `Easily scan any prescription or medicine QR code\n to view complete information, including usage\n guidelines, warnings, interactions, and important\n notes — all in one place, in seconds.`
  String get scanarticle2 {
    return Intl.message(
      'Easily scan any prescription or medicine QR code\n to view complete information, including usage\n guidelines, warnings, interactions, and important\n notes — all in one place, in seconds.',
      name: 'scanarticle2',
      desc: '',
      args: [],
    );
  }

  /// ` 'Point your camera at the QR code and get the full\n medication profile in seconds.'`
  String get scanarticle3 {
    return Intl.message(
      ' \'Point your camera at the QR code and get the full\n medication profile in seconds.\'',
      name: 'scanarticle3',
      desc: '',
      args: [],
    );
  }

  /// `{count} Missed This Week`
  String missedThisWeek(int count) {
    return Intl.message(
      '$count Missed This Week',
      name: 'missedThisWeek',
      desc: '',
      args: [count],
    );
  }

  /// `{percent}%`
  String weeklyPercentage(int percent) {
    return Intl.message(
      '$percent%',
      name: 'weeklyPercentage',
      desc: '',
      args: [percent],
    );
  }

  /// `View weekly report`
  String get viewWeeklyReport {
    return Intl.message(
      'View weekly report',
      name: 'viewWeeklyReport',
      desc: '',
      args: [],
    );
  }

  /// `Today's Schedule`
  String get TodaysSchedule {
    return Intl.message(
      'Today\'s Schedule',
      name: 'TodaysSchedule',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get Upcoming {
    return Intl.message('Upcoming', name: 'Upcoming', desc: '', args: []);
  }

  /// `missed`
  String get missed {
    return Intl.message('missed', name: 'missed', desc: '', args: []);
  }

  /// `Taken`
  String get taken {
    return Intl.message('Taken', name: 'taken', desc: '', args: []);
  }

  /// `How to deal with \nchronic diseases ?`
  String get heartTopicTitle {
    return Intl.message(
      'How to deal with \nchronic diseases ?',
      name: 'heartTopicTitle',
      desc: '',
      args: [],
    );
  }

  /// `Tips for preventing \ninfectious diseases`
  String get preventDiseasesTitle {
    return Intl.message(
      'Tips for preventing \ninfectious diseases',
      name: 'preventDiseasesTitle',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
