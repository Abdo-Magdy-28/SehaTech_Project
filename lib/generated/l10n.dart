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

  /// `Popular Doctors`
  String get populardoctors {
    return Intl.message(
      'Popular Doctors',
      name: 'populardoctors',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacies`
  String get pharmacies {
    return Intl.message('Pharmacies', name: 'pharmacies', desc: '', args: []);
  }

  /// `Popular Pharmacies`
  String get popularpharmacies {
    return Intl.message(
      'Popular Pharmacies',
      name: 'popularpharmacies',
      desc: '',
      args: [],
    );
  }

  /// `Hospitals`
  String get hospitals {
    return Intl.message('Hospitals', name: 'hospitals', desc: '', args: []);
  }

  /// `Popular Hospitals`
  String get popularhospitals {
    return Intl.message(
      'Popular Hospitals',
      name: 'popularhospitals',
      desc: '',
      args: [],
    );
  }

  /// `Medicines`
  String get medicines {
    return Intl.message('Medicines', name: 'medicines', desc: '', args: []);
  }

  /// `Most Searched Medicines`
  String get mostsearchedmedicines {
    return Intl.message(
      'Most Searched Medicines',
      name: 'mostsearchedmedicines',
      desc: '',
      args: [],
    );
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

  /// `Scan the Medicine`
  String get scanmedicines {
    return Intl.message(
      'Scan the Medicine',
      name: 'scanmedicines',
      desc: '',
      args: [],
    );
  }

  /// `Scan the Perscriptions`
  String get scanperscriptions {
    return Intl.message(
      'Scan the Perscriptions',
      name: 'scanperscriptions',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Notification settings`
  String get notificationssettings {
    return Intl.message(
      'Notification settings',
      name: 'notificationssettings',
      desc: '',
      args: [],
    );
  }

  /// `Security Settings`
  String get securitysettings {
    return Intl.message(
      'Security Settings',
      name: 'securitysettings',
      desc: '',
      args: [],
    );
  }

  /// `Language Settings`
  String get languagesettings {
    return Intl.message(
      'Language Settings',
      name: 'languagesettings',
      desc: '',
      args: [],
    );
  }

  /// `Select Language`
  String get selectlanguage {
    return Intl.message(
      'Select Language',
      name: 'selectlanguage',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message('English', name: 'english', desc: '', args: []);
  }

  /// `Arabic`
  String get arabic {
    return Intl.message('Arabic', name: 'arabic', desc: '', args: []);
  }

  /// `Personal Info`
  String get personalinfo {
    return Intl.message(
      'Personal Info',
      name: 'personalinfo',
      desc: '',
      args: [],
    );
  }

  /// `Delete Photo`
  String get deletephoto {
    return Intl.message(
      'Delete Photo',
      name: 'deletephoto',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstname {
    return Intl.message('First Name', name: 'firstname', desc: '', args: []);
  }

  /// `Last Name`
  String get lastname {
    return Intl.message('Last Name', name: 'lastname', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Phone Number`
  String get phonenumber {
    return Intl.message(
      'Phone Number',
      name: 'phonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Date of Birth`
  String get dateofbirth {
    return Intl.message(
      'Date of Birth',
      name: 'dateofbirth',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmpassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmpassword',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changepassword {
    return Intl.message(
      'Change Password',
      name: 'changepassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentpassword {
    return Intl.message(
      'Current Password',
      name: 'currentpassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newpassword {
    return Intl.message(
      'New Password',
      name: 'newpassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your New Password`
  String get enternewpassword {
    return Intl.message(
      'Enter Your New Password',
      name: 'enternewpassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password is required`
  String get currentpasswordrequiered {
    return Intl.message(
      'Current Password is required',
      name: 'currentpasswordrequiered',
      desc: '',
      args: [],
    );
  }

  /// `New Password Required`
  String get newpasswordrequiered {
    return Intl.message(
      'New Password Required',
      name: 'newpasswordrequiered',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password is required`
  String get confirmpasswordrequiered {
    return Intl.message(
      'Confirm Password is required',
      name: 'confirmpasswordrequiered',
      desc: '',
      args: [],
    );
  }

  /// `Password doesn't match`
  String get passwordnotmatch {
    return Intl.message(
      'Password doesn\'t match',
      name: 'passwordnotmatch',
      desc: '',
      args: [],
    );
  }

  /// `Password Must be atleast 6 Characters`
  String get passwordmustbeatleast {
    return Intl.message(
      'Password Must be atleast 6 Characters',
      name: 'passwordmustbeatleast',
      desc: '',
      args: [],
    );
  }

  /// `Finish`
  String get finish {
    return Intl.message('Finish', name: 'finish', desc: '', args: []);
  }

  /// `Blood Type`
  String get bloodtype {
    return Intl.message('Blood Type', name: 'bloodtype', desc: '', args: []);
  }

  /// `Profile Updated Successfully`
  String get profileupdatedsuccessfully {
    return Intl.message(
      'Profile Updated Successfully',
      name: 'profileupdatedsuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update profile. please try again`
  String get failedtoupdateprofilepleasetryagain {
    return Intl.message(
      'Failed to update profile. please try again',
      name: 'failedtoupdateprofilepleasetryagain',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred, please try again later`
  String get erroroccured {
    return Intl.message(
      'An error occurred, please try again later',
      name: 'erroroccured',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get savechanges {
    return Intl.message(
      'Save Changes',
      name: 'savechanges',
      desc: '',
      args: [],
    );
  }

  /// `Discard Changes ?`
  String get discardchanges {
    return Intl.message(
      'Discard Changes ?',
      name: 'discardchanges',
      desc: '',
      args: [],
    );
  }

  /// `Unsaved changes will be lost`
  String get unsavedchangeswillbelost {
    return Intl.message(
      'Unsaved changes will be lost',
      name: 'unsavedchangeswillbelost',
      desc: '',
      args: [],
    );
  }

  /// `Yes, Discard`
  String get yesdiscard {
    return Intl.message('Yes, Discard', name: 'yesdiscard', desc: '', args: []);
  }

  /// `No, Keep Changes`
  String get nokeepchanges {
    return Intl.message(
      'No, Keep Changes',
      name: 'nokeepchanges',
      desc: '',
      args: [],
    );
  }

  /// `Change Notification Settings`
  String get changenotificationsettings {
    return Intl.message(
      'Change Notification Settings',
      name: 'changenotificationsettings',
      desc: '',
      args: [],
    );
  }

  /// `Medication Reminder`
  String get medicationreminder {
    return Intl.message(
      'Medication Reminder',
      name: 'medicationreminder',
      desc: '',
      args: [],
    );
  }

  /// `Email Notification`
  String get emailnotification {
    return Intl.message(
      'Email Notification',
      name: 'emailnotification',
      desc: '',
      args: [],
    );
  }

  /// `Push Notification`
  String get pushnotification {
    return Intl.message(
      'Push Notification',
      name: 'pushnotification',
      desc: '',
      args: [],
    );
  }

  /// `Security Notification`
  String get securitynotification {
    return Intl.message(
      'Security Notification',
      name: 'securitynotification',
      desc: '',
      args: [],
    );
  }

  /// `SMS Notification`
  String get smsnotification {
    return Intl.message(
      'SMS Notification',
      name: 'smsnotification',
      desc: '',
      args: [],
    );
  }

  /// `What can help you?`
  String get whaticanhelp {
    return Intl.message(
      'What can help you?',
      name: 'whaticanhelp',
      desc: '',
      args: [],
    );
  }

  /// `Diagnoses`
  String get diagnoses {
    return Intl.message('Diagnoses', name: 'diagnoses', desc: '', args: []);
  }

  /// `Active Ingredients`
  String get activeingredients {
    return Intl.message(
      'Active Ingredients',
      name: 'activeingredients',
      desc: '',
      args: [],
    );
  }

  /// `Drug Price`
  String get drugprice {
    return Intl.message('Drug Price', name: 'drugprice', desc: '', args: []);
  }

  /// `Chronic Diseases`
  String get chronicdiseases {
    return Intl.message(
      'Chronic Diseases',
      name: 'chronicdiseases',
      desc: '',
      args: [],
    );
  }

  /// `Diseases symptoms`
  String get diseasessymptoms {
    return Intl.message(
      'Diseases symptoms',
      name: 'diseasessymptoms',
      desc: '',
      args: [],
    );
  }

  /// `View Your History`
  String get viewyourhistory {
    return Intl.message(
      'View Your History',
      name: 'viewyourhistory',
      desc: '',
      args: [],
    );
  }

  /// `Ask AI Assistant Any Thing You Need`
  String get askaiassistant {
    return Intl.message(
      'Ask AI Assistant Any Thing You Need',
      name: 'askaiassistant',
      desc: '',
      args: [],
    );
  }

  /// `Ask Anything`
  String get askanything {
    return Intl.message(
      'Ask Anything',
      name: 'askanything',
      desc: '',
      args: [],
    );
  }

  /// `Copied to clipboard`
  String get copiedtoclipboard {
    return Intl.message(
      'Copied to clipboard',
      name: 'copiedtoclipboard',
      desc: '',
      args: [],
    );
  }

  /// `Typing...`
  String get typing {
    return Intl.message('Typing...', name: 'typing', desc: '', args: []);
  }

  /// `Search...`
  String get searching {
    return Intl.message('Search...', name: 'searching', desc: '', args: []);
  }

  /// `Find what you need`
  String get findwhatyouneed {
    return Intl.message(
      'Find what you need',
      name: 'findwhatyouneed',
      desc: '',
      args: [],
    );
  }

  /// `Failed to select image`
  String get failedtoselectimage {
    return Intl.message(
      'Failed to select image',
      name: 'failedtoselectimage',
      desc: '',
      args: [],
    );
  }

  /// `Attach Image`
  String get attachimage {
    return Intl.message(
      'Attach Image',
      name: 'attachimage',
      desc: '',
      args: [],
    );
  }

  /// `Take Photo`
  String get takephoto {
    return Intl.message('Take Photo', name: 'takephoto', desc: '', args: []);
  }

  /// `Choose Image from gallery`
  String get chooseimage {
    return Intl.message(
      'Choose Image from gallery',
      name: 'chooseimage',
      desc: '',
      args: [],
    );
  }

  /// `Try different search term`
  String get trydifferentsearchterm {
    return Intl.message(
      'Try different search term',
      name: 'trydifferentsearchterm',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, no result found`
  String get sorrynoresultfound {
    return Intl.message(
      'Sorry, no result found',
      name: 'sorrynoresultfound',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message('View', name: 'view', desc: '', args: []);
  }

  /// `Pharmacy`
  String get pharmacy {
    return Intl.message('Pharmacy', name: 'pharmacy', desc: '', args: []);
  }

  /// `Hospital`
  String get hospital {
    return Intl.message('Hospital', name: 'hospital', desc: '', args: []);
  }

  /// `Closed`
  String get closed {
    return Intl.message('Closed', name: 'closed', desc: '', args: []);
  }

  /// `24 hours`
  String get hours24 {
    return Intl.message('24 hours', name: 'hours24', desc: '', args: []);
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `Capsule`
  String get capsule {
    return Intl.message('Capsule', name: 'capsule', desc: '', args: []);
  }

  /// `Medicine Information`
  String get medicineinfo {
    return Intl.message(
      'Medicine Information',
      name: 'medicineinfo',
      desc: '',
      args: [],
    );
  }

  /// `Add Reminder`
  String get addreminder {
    return Intl.message(
      'Add Reminder',
      name: 'addreminder',
      desc: '',
      args: [],
    );
  }

  /// `Product Overview`
  String get productoverview {
    return Intl.message(
      'Product Overview',
      name: 'productoverview',
      desc: '',
      args: [],
    );
  }

  /// `Key Benefits`
  String get keybenefits {
    return Intl.message(
      'Key Benefits',
      name: 'keybenefits',
      desc: '',
      args: [],
    );
  }

  /// `Side Effects`
  String get sideeffects {
    return Intl.message(
      'Side Effects',
      name: 'sideeffects',
      desc: '',
      args: [],
    );
  }

  /// `Book Appointment`
  String get bookappointment {
    return Intl.message(
      'Book Appointment',
      name: 'bookappointment',
      desc: '',
      args: [],
    );
  }

  /// `Available Time`
  String get availabletime {
    return Intl.message(
      'Available Time',
      name: 'availabletime',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Details`
  String get doctordetails {
    return Intl.message(
      'Doctor Details',
      name: 'doctordetails',
      desc: '',
      args: [],
    );
  }

  /// `Experience`
  String get experience {
    return Intl.message('Experience', name: 'experience', desc: '', args: []);
  }

  /// `Treated`
  String get treated {
    return Intl.message('Treated', name: 'treated', desc: '', args: []);
  }

  /// `Hourly Rate`
  String get hourlyrate {
    return Intl.message('Hourly Rate', name: 'hourlyrate', desc: '', args: []);
  }

  /// `6 Slots`
  String get slots6 {
    return Intl.message('6 Slots', name: 'slots6', desc: '', args: []);
  }

  /// `Hospital Information`
  String get hospitalinfo {
    return Intl.message(
      'Hospital Information',
      name: 'hospitalinfo',
      desc: '',
      args: [],
    );
  }

  /// `Pharmacy Information`
  String get pharmacyinfo {
    return Intl.message(
      'Pharmacy Information',
      name: 'pharmacyinfo',
      desc: '',
      args: [],
    );
  }

  /// `Contact Us`
  String get contactus {
    return Intl.message('Contact Us', name: 'contactus', desc: '', args: []);
  }

  /// `Our Services`
  String get ourservices {
    return Intl.message(
      'Our Services',
      name: 'ourservices',
      desc: '',
      args: [],
    );
  }

  /// `Branches`
  String get branches {
    return Intl.message('Branches', name: 'branches', desc: '', args: []);
  }

  /// `Work time`
  String get worktime {
    return Intl.message('Work time', name: 'worktime', desc: '', args: []);
  }

  /// `Delivering`
  String get deliviringtime {
    return Intl.message(
      'Delivering',
      name: 'deliviringtime',
      desc: '',
      args: [],
    );
  }

  /// `Explore Nearby`
  String get explorenearby {
    return Intl.message(
      'Explore Nearby',
      name: 'explorenearby',
      desc: '',
      args: [],
    );
  }

  /// `Nearest`
  String get nearest {
    return Intl.message('Nearest', name: 'nearest', desc: '', args: []);
  }

  /// `See All...`
  String get seeall {
    return Intl.message('See All...', name: 'seeall', desc: '', args: []);
  }

  /// `Actual`
  String get actual {
    return Intl.message('Actual', name: 'actual', desc: '', args: []);
  }

  /// `History`
  String get history {
    return Intl.message('History', name: 'history', desc: '', args: []);
  }

  /// `All Perscriptions`
  String get allperscriptions {
    return Intl.message(
      'All Perscriptions',
      name: 'allperscriptions',
      desc: '',
      args: [],
    );
  }

  /// `No perscriptions found`
  String get noperscriptionsfound {
    return Intl.message(
      'No perscriptions found',
      name: 'noperscriptionsfound',
      desc: '',
      args: [],
    );
  }

  /// `Health Matrix`
  String get healthmatrix {
    return Intl.message(
      'Health Matrix',
      name: 'healthmatrix',
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

  /// `Allergies`
  String get allergies {
    return Intl.message('Allergies', name: 'allergies', desc: '', args: []);
  }

  /// `+ Add Allergies`
  String get addAllergies {
    return Intl.message(
      '+ Add Allergies',
      name: 'addAllergies',
      desc: '',
      args: [],
    );
  }

  /// `+ Add Condition`
  String get addCondition {
    return Intl.message(
      '+ Add Condition',
      name: 'addCondition',
      desc: '',
      args: [],
    );
  }

  /// `Change Type`
  String get changeType {
    return Intl.message('Change Type', name: 'changeType', desc: '', args: []);
  }

  /// `A Positive`
  String get aPositive {
    return Intl.message('A Positive', name: 'aPositive', desc: '', args: []);
  }

  /// `You Are A Positive Blood Type`
  String get aPositiveBloodTypeDesc {
    return Intl.message(
      'You Are A Positive Blood Type',
      name: 'aPositiveBloodTypeDesc',
      desc: '',
      args: [],
    );
  }

  /// `Always Inform Healthcare About Your Allergies`
  String get alwaysInformHealthcare {
    return Intl.message(
      'Always Inform Healthcare About Your Allergies',
      name: 'alwaysInformHealthcare',
      desc: '',
      args: [],
    );
  }

  /// `Keep Your Condition Under Control And Follow Your Care Plan`
  String get keepConditionUnderControl {
    return Intl.message(
      'Keep Your Condition Under Control And Follow Your Care Plan',
      name: 'keepConditionUnderControl',
      desc: '',
      args: [],
    );
  }

  /// `Managed`
  String get managed {
    return Intl.message('Managed', name: 'managed', desc: '', args: []);
  }

  /// `Mild`
  String get mild {
    return Intl.message('Mild', name: 'mild', desc: '', args: []);
  }

  /// `Moderate`
  String get moderate {
    return Intl.message('Moderate', name: 'moderate', desc: '', args: []);
  }

  /// `Severe`
  String get severe {
    return Intl.message('Severe', name: 'severe', desc: '', args: []);
  }

  /// `Antibiotic`
  String get antibiotic {
    return Intl.message('Antibiotic', name: 'antibiotic', desc: '', args: []);
  }

  /// `Seasonal Allergy`
  String get seasonalAllergy {
    return Intl.message(
      'Seasonal Allergy',
      name: 'seasonalAllergy',
      desc: '',
      args: [],
    );
  }

  /// `Food Allergy`
  String get foodAllergy {
    return Intl.message(
      'Food Allergy',
      name: 'foodAllergy',
      desc: '',
      args: [],
    );
  }

  /// `Penicillin`
  String get penicillin {
    return Intl.message('Penicillin', name: 'penicillin', desc: '', args: []);
  }

  /// `Pollen`
  String get pollen {
    return Intl.message('Pollen', name: 'pollen', desc: '', args: []);
  }

  /// `Shellfish`
  String get shellfish {
    return Intl.message('Shellfish', name: 'shellfish', desc: '', args: []);
  }

  /// `Diabetes`
  String get diabetes {
    return Intl.message('Diabetes', name: 'diabetes', desc: '', args: []);
  }

  /// `Hypertension`
  String get hypertension {
    return Intl.message(
      'Hypertension',
      name: 'hypertension',
      desc: '',
      args: [],
    );
  }

  /// `Severity`
  String get severity {
    return Intl.message('Severity', name: 'severity', desc: '', args: []);
  }

  /// `Psychiatrist`
  String get psychiatrist {
    return Intl.message(
      'Psychiatrist',
      name: 'psychiatrist',
      desc: '',
      args: [],
    );
  }

  /// `Dentist`
  String get dentist {
    return Intl.message('Dentist', name: 'dentist', desc: '', args: []);
  }

  /// `Cardiologist`
  String get cardiologist {
    return Intl.message(
      'Cardiologist',
      name: 'cardiologist',
      desc: '',
      args: [],
    );
  }

  /// `Dermatologist`
  String get dermatologist {
    return Intl.message(
      'Dermatologist',
      name: 'dermatologist',
      desc: '',
      args: [],
    );
  }

  /// `Search for Doctors by Name`
  String get searchfordoctorsbyname {
    return Intl.message(
      'Search for Doctors by Name',
      name: 'searchfordoctorsbyname',
      desc: '',
      args: [],
    );
  }

  /// `Search for Hospitals by Name`
  String get searchforhospitalsbyname {
    return Intl.message(
      'Search for Hospitals by Name',
      name: 'searchforhospitalsbyname',
      desc: '',
      args: [],
    );
  }

  /// `Search for Pharmacies by Name`
  String get searchforpharmaciesbyname {
    return Intl.message(
      'Search for Pharmacies by Name',
      name: 'searchforpharmaciesbyname',
      desc: '',
      args: [],
    );
  }

  /// `Try Again`
  String get tryagain {
    return Intl.message('Try Again', name: 'tryagain', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Location :nearest first`
  String get locationnearestfirst {
    return Intl.message(
      'Location :nearest first',
      name: 'locationnearestfirst',
      desc: '',
      args: [],
    );
  }

  /// `Rating : The best first`
  String get ratingthebestfirst {
    return Intl.message(
      'Rating : The best first',
      name: 'ratingthebestfirst',
      desc: '',
      args: [],
    );
  }

  /// `Rating : The worst first`
  String get ratingtheworstfirst {
    return Intl.message(
      'Rating : The worst first',
      name: 'ratingtheworstfirst',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Price: Low to high`
  String get pricelowtohigh {
    return Intl.message(
      'Price: Low to high',
      name: 'pricelowtohigh',
      desc: '',
      args: [],
    );
  }

  /// `Price: High to low`
  String get pricehightolow {
    return Intl.message(
      'Price: High to low',
      name: 'pricehightolow',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message('Distance', name: 'distance', desc: '', args: []);
  }

  /// `Nearest first`
  String get nearestfirst {
    return Intl.message(
      'Nearest first',
      name: 'nearestfirst',
      desc: '',
      args: [],
    );
  }

  /// `Farthest first`
  String get farthestfirst {
    return Intl.message(
      'Farthest first',
      name: 'farthestfirst',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Alphabet: From A>Z`
  String get alphabetfromatoz {
    return Intl.message(
      'Alphabet: From A>Z',
      name: 'alphabetfromatoz',
      desc: '',
      args: [],
    );
  }

  /// `Experience: More experience first`
  String get moreexperinencefirst {
    return Intl.message(
      'Experience: More experience first',
      name: 'moreexperinencefirst',
      desc: '',
      args: [],
    );
  }

  /// `Experience: Less experience first`
  String get lessexperinencefirst {
    return Intl.message(
      'Experience: Less experience first',
      name: 'lessexperinencefirst',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `By Location`
  String get bylocation {
    return Intl.message('By Location', name: 'bylocation', desc: '', args: []);
  }

  /// `By Rating`
  String get byrating {
    return Intl.message('By Rating', name: 'byrating', desc: '', args: []);
  }

  /// `By Distance`
  String get bydistance {
    return Intl.message('By Distance', name: 'bydistance', desc: '', args: []);
  }

  /// `By Name`
  String get byname {
    return Intl.message('By Name', name: 'byname', desc: '', args: []);
  }

  /// `Alphabetically`
  String get byalphabet {
    return Intl.message(
      'Alphabetically',
      name: 'byalphabet',
      desc: '',
      args: [],
    );
  }

  /// `By Experience`
  String get byexperience {
    return Intl.message(
      'By Experience',
      name: 'byexperience',
      desc: '',
      args: [],
    );
  }

  /// `By Price`
  String get byprice {
    return Intl.message('By Price', name: 'byprice', desc: '', args: []);
  }

  /// `Eczema`
  String get eczema {
    return Intl.message('Eczema', name: 'eczema', desc: '', args: []);
  }

  /// `Nasal`
  String get nasal {
    return Intl.message('Nasal', name: 'nasal', desc: '', args: []);
  }

  /// `Fever`
  String get fever {
    return Intl.message('Fever', name: 'fever', desc: '', args: []);
  }

  /// `Infection`
  String get infection {
    return Intl.message('Infection', name: 'infection', desc: '', args: []);
  }

  /// `Spasm`
  String get spasm {
    return Intl.message('Spasm', name: 'spasm', desc: '', args: []);
  }

  /// `Pain`
  String get pain {
    return Intl.message('Pain', name: 'pain', desc: '', args: []);
  }

  /// `Easily Consult Top Doctors Online & In-Person.`
  String get carousel1 {
    return Intl.message(
      'Easily Consult Top Doctors Online & In-Person.',
      name: 'carousel1',
      desc: '',
      args: [],
    );
  }

  /// `Consult today. Find top doctors. Start your health journey with ease and confidence now!`
  String get carousel1hint {
    return Intl.message(
      'Consult today. Find top doctors. Start your health journey with ease and confidence now!',
      name: 'carousel1hint',
      desc: '',
      args: [],
    );
  }

  /// `Easily Access a Smart Chatbot for Instant Support & Guidance.`
  String get carousel2 {
    return Intl.message(
      'Easily Access a Smart Chatbot for Instant Support & Guidance.',
      name: 'carousel2',
      desc: '',
      args: [],
    );
  }

  /// `Get instant support. Receive guided medical advice with confidence now!`
  String get carousel2hint {
    return Intl.message(
      'Get instant support. Receive guided medical advice with confidence now!',
      name: 'carousel2hint',
      desc: '',
      args: [],
    );
  }

  /// `Easily Access Top Hospitals Online & In-Person`
  String get carousel3 {
    return Intl.message(
      'Easily Access Top Hospitals Online & In-Person',
      name: 'carousel3',
      desc: '',
      args: [],
    );
  }

  /// `Find trusted hospitals. Start your treatment journey with ease and confidence now!`
  String get carousel3hint {
    return Intl.message(
      'Find trusted hospitals. Start your treatment journey with ease and confidence now!',
      name: 'carousel3hint',
      desc: '',
      args: [],
    );
  }

  /// `SEHA TECH helps you track, manage, and improve your\n`
  String get logindescription1 {
    return Intl.message(
      'SEHA TECH helps you track, manage, and improve your\n',
      name: 'logindescription1',
      desc: '',
      args: [],
    );
  }

  /// `health with smart tools designed for every stage of life.`
  String get logindescription2 {
    return Intl.message(
      'health with smart tools designed for every stage of life.',
      name: 'logindescription2',
      desc: '',
      args: [],
    );
  }

  /// `Sign up with Google`
  String get signupwithgoogle {
    return Intl.message(
      'Sign up with Google',
      name: 'signupwithgoogle',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyhaveanaccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyhaveanaccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get signin {
    return Intl.message('Sign in', name: 'signin', desc: '', args: []);
  }

  /// `Sign up`
  String get signup {
    return Intl.message('Sign up', name: 'signup', desc: '', args: []);
  }

  /// `Swipe to create an account`
  String get swiptocreateaccount {
    return Intl.message(
      'Swipe to create an account',
      name: 'swiptocreateaccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotpassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotpassword',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailrequired {
    return Intl.message(
      'Email is required',
      name: 'emailrequired',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get passwordrequired {
    return Intl.message(
      'Password is required',
      name: 'passwordrequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password is required`
  String get confirmpasswordrequired {
    return Intl.message(
      'Confirm Password is required',
      name: 'confirmpasswordrequired',
      desc: '',
      args: [],
    );
  }

  /// `Email is invaild`
  String get emailisnotvalid {
    return Intl.message(
      'Email is invaild',
      name: 'emailisnotvalid',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get donothaveanaccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'donothaveanaccount',
      desc: '',
      args: [],
    );
  }

  /// `First`
  String get first {
    return Intl.message('First', name: 'first', desc: '', args: []);
  }

  /// `Or`
  String get or {
    return Intl.message('Or', name: 'or', desc: '', args: []);
  }

  /// `First Name is required`
  String get firstnamerequired {
    return Intl.message(
      'First Name is required',
      name: 'firstnamerequired',
      desc: '',
      args: [],
    );
  }

  /// `Last Name is required`
  String get lastnamerequired {
    return Intl.message(
      'Last Name is required',
      name: 'lastnamerequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number is required`
  String get phonenumberrequired {
    return Intl.message(
      'Phone Number is required',
      name: 'phonenumberrequired',
      desc: '',
      args: [],
    );
  }

  /// `Address is required`
  String get addressrequired {
    return Intl.message(
      'Address is required',
      name: 'addressrequired',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth is required`
  String get dateofbirthrequired {
    return Intl.message(
      'Date of Birth is required',
      name: 'dateofbirthrequired',
      desc: '',
      args: [],
    );
  }

  /// `Form is valid! Signing up...`
  String get formisvalid {
    return Intl.message(
      'Form is valid! Signing up...',
      name: 'formisvalid',
      desc: '',
      args: [],
    );
  }

  /// `Please fix errors`
  String get plsfixformerrors {
    return Intl.message(
      'Please fix errors',
      name: 'plsfixformerrors',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message('Username', name: 'username', desc: '', args: []);
  }

  /// `Username is required`
  String get usernamerequired {
    return Intl.message(
      'Username is required',
      name: 'usernamerequired',
      desc: '',
      args: [],
    );
  }

  /// `Must be 11 numbers`
  String get mustbe11numbers {
    return Intl.message(
      'Must be 11 numbers',
      name: 'mustbe11numbers',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Phone Number`
  String get invaliphonenumber {
    return Intl.message(
      'Invalid Phone Number',
      name: 'invaliphonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Doctor`
  String get doctor {
    return Intl.message('Doctor', name: 'doctor', desc: '', args: []);
  }

  /// `Patient`
  String get patient {
    return Intl.message('Patient', name: 'patient', desc: '', args: []);
  }

  /// `Email Verification`
  String get emailvarification {
    return Intl.message(
      'Email Verification',
      name: 'emailvarification',
      desc: '',
      args: [],
    );
  }

  /// `We sent you an email with a verification code.`
  String get wesentyouanemail {
    return Intl.message(
      'We sent you an email with a verification code.',
      name: 'wesentyouanemail',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `Didn't receive the email?`
  String get didnotreceiveemail {
    return Intl.message(
      'Didn\'t receive the email?',
      name: 'didnotreceiveemail',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `Code is required`
  String get coderequired {
    return Intl.message(
      'Code is required',
      name: 'coderequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to receive reset code`
  String get enteremailtoreceivecode {
    return Intl.message(
      'Enter your email to receive reset code',
      name: 'enteremailtoreceivecode',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continuee {
    return Intl.message('Continue', name: 'continuee', desc: '', args: []);
  }

  /// `Verify Your Identity`
  String get verifiyyouridentity {
    return Intl.message(
      'Verify Your Identity',
      name: 'verifiyyouridentity',
      desc: '',
      args: [],
    );
  }

  /// `Reminder Info`
  String get reminderInfoTitle {
    return Intl.message(
      'Reminder Info',
      name: 'reminderInfoTitle',
      desc: '',
      args: [],
    );
  }

  /// `Provide Information`
  String get reminderProvideInfo {
    return Intl.message(
      'Provide Information',
      name: 'reminderProvideInfo',
      desc: '',
      args: [],
    );
  }

  /// `Name:`
  String get reminderLabelName {
    return Intl.message('Name:', name: 'reminderLabelName', desc: '', args: []);
  }

  /// `Dosage :`
  String get reminderLabelDosage {
    return Intl.message(
      'Dosage :',
      name: 'reminderLabelDosage',
      desc: '',
      args: [],
    );
  }

  /// `Frequency :`
  String get reminderLabelFrequency {
    return Intl.message(
      'Frequency :',
      name: 'reminderLabelFrequency',
      desc: '',
      args: [],
    );
  }

  /// `Type :`
  String get reminderLabelType {
    return Intl.message(
      'Type :',
      name: 'reminderLabelType',
      desc: '',
      args: [],
    );
  }

  /// `Duration:`
  String get reminderLabelDuration {
    return Intl.message(
      'Duration:',
      name: 'reminderLabelDuration',
      desc: '',
      args: [],
    );
  }

  /// `From:`
  String get reminderFrom {
    return Intl.message('From:', name: 'reminderFrom', desc: '', args: []);
  }

  /// `To:`
  String get reminderTo {
    return Intl.message('To:', name: 'reminderTo', desc: '', args: []);
  }

  /// `Select time`
  String get reminderSelectTime {
    return Intl.message(
      'Select time',
      name: 'reminderSelectTime',
      desc: '',
      args: [],
    );
  }

  /// `Maximum 3 times`
  String get reminderMaxTimes {
    return Intl.message(
      'Maximum 3 times',
      name: 'reminderMaxTimes',
      desc: '',
      args: [],
    );
  }

  /// `You can only select {count} time(s)`
  String reminderMaxTimesError(int count) {
    return Intl.message(
      'You can only select $count time(s)',
      name: 'reminderMaxTimesError',
      desc: '',
      args: [count],
    );
  }

  /// `Drug Interactions Checker`
  String get druginteractioncheaker {
    return Intl.message(
      'Drug Interactions Checker',
      name: 'druginteractioncheaker',
      desc: '',
      args: [],
    );
  }

  /// `Cheak Interactions`
  String get cheakInteractions {
    return Intl.message(
      'Cheak Interactions',
      name: 'cheakInteractions',
      desc: '',
      args: [],
    );
  }

  /// `Medicines 1`
  String get medicine1 {
    return Intl.message('Medicines 1', name: 'medicine1', desc: '', args: []);
  }

  /// `Medicines 2`
  String get medicine2 {
    return Intl.message('Medicines 2', name: 'medicine2', desc: '', args: []);
  }

  /// `Refill`
  String get reminderButtonRefill {
    return Intl.message(
      'Refill',
      name: 'reminderButtonRefill',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Reminder`
  String get reminderButtonCancel {
    return Intl.message(
      'Cancel Reminder',
      name: 'reminderButtonCancel',
      desc: '',
      args: [],
    );
  }

  /// `Once`
  String get reminderFreqOnce {
    return Intl.message('Once', name: 'reminderFreqOnce', desc: '', args: []);
  }

  /// `Twice`
  String get reminderFreqTwice {
    return Intl.message('Twice', name: 'reminderFreqTwice', desc: '', args: []);
  }

  /// `Three times`
  String get reminderFreqThreeTimes {
    return Intl.message(
      'Three times',
      name: 'reminderFreqThreeTimes',
      desc: '',
      args: [],
    );
  }

  /// `Every Day`
  String get reminderPeriodEveryDay {
    return Intl.message(
      'Every Day',
      name: 'reminderPeriodEveryDay',
      desc: '',
      args: [],
    );
  }

  /// `Every Week`
  String get reminderPeriodEveryWeek {
    return Intl.message(
      'Every Week',
      name: 'reminderPeriodEveryWeek',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newLabel {
    return Intl.message('New', name: 'newLabel', desc: '', args: []);
  }

  /// `Drug Interaction Checker`
  String get drugInteractionChecker {
    return Intl.message(
      'Drug Interaction Checker',
      name: 'drugInteractionChecker',
      desc: '',
      args: [],
    );
  }

  /// `Check Interactions Between Medicines Accurately`
  String get drugInteractionSubtitle {
    return Intl.message(
      'Check Interactions Between Medicines Accurately',
      name: 'drugInteractionSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Find Your Drugs Interactions`
  String get findYourDrugsInteractions {
    return Intl.message(
      'Find Your Drugs Interactions',
      name: 'findYourDrugsInteractions',
      desc: '',
      args: [],
    );
  }

  /// `Every Month`
  String get reminderPeriodEveryMonth {
    return Intl.message(
      'Every Month',
      name: 'reminderPeriodEveryMonth',
      desc: '',
      args: [],
    );
  }

  /// `Capsule`
  String get reminderTypeCapsule {
    return Intl.message(
      'Capsule',
      name: 'reminderTypeCapsule',
      desc: '',
      args: [],
    );
  }

  /// `Syrup`
  String get reminderTypeSyrup {
    return Intl.message('Syrup', name: 'reminderTypeSyrup', desc: '', args: []);
  }

  /// `Password changed successfully`
  String get passwordchangedsuccess {
    return Intl.message(
      'Password changed successfully',
      name: 'passwordchangedsuccess',
      desc: '',
      args: [],
    );
  }

  /// `Your current password is incorrect`
  String get wrongCurrentPassword {
    return Intl.message(
      'Your current password is incorrect',
      name: 'wrongCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `You are not logged in`
  String get notLoggedIn {
    return Intl.message(
      'You are not logged in',
      name: 'notLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `No internet connection`
  String get noInternet {
    return Intl.message(
      'No internet connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Network error occurred, please try again`
  String get networkError {
    return Intl.message(
      'Network error occurred, please try again',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred`
  String get unexpectedError {
    return Intl.message(
      'An unexpected error occurred',
      name: 'unexpectedError',
      desc: '',
      args: [],
    );
  }

  /// `All Chats`
  String get allchats {
    return Intl.message('All Chats', name: 'allchats', desc: '', args: []);
  }

  /// `New Chat`
  String get newchat {
    return Intl.message('New Chat', name: 'newchat', desc: '', args: []);
  }

  /// `Remove History`
  String get removehistory {
    return Intl.message(
      'Remove History',
      name: 'removehistory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all chats? This cannot be undone.`
  String get removehistoryconfirm {
    return Intl.message(
      'Are you sure you want to delete all chats? This cannot be undone.',
      name: 'removehistoryconfirm',
      desc: '',
      args: [],
    );
  }

  /// `History removed`
  String get historyremoved {
    return Intl.message(
      'History removed',
      name: 'historyremoved',
      desc: '',
      args: [],
    );
  }

  /// `Delete Chat`
  String get deletechat {
    return Intl.message('Delete Chat', name: 'deletechat', desc: '', args: []);
  }

  /// `Are you sure you want to delete this chat? This action cannot be undone.`
  String get deletechatconfirm {
    return Intl.message(
      'Are you sure you want to delete this chat? This action cannot be undone.',
      name: 'deletechatconfirm',
      desc: '',
      args: [],
    );
  }

  /// `Chat deleted`
  String get chatdeleted {
    return Intl.message(
      'Chat deleted',
      name: 'chatdeleted',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete chat`
  String get failedtodeletechat {
    return Intl.message(
      'Failed to delete chat',
      name: 'failedtodeletechat',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load chats.`
  String get failedtoloadchats {
    return Intl.message(
      'Failed to load chats.',
      name: 'failedtoloadchats',
      desc: '',
      args: [],
    );
  }

  /// `Could not load chat`
  String get couldnotloadchat {
    return Intl.message(
      'Could not load chat',
      name: 'couldnotloadchat',
      desc: '',
      args: [],
    );
  }

  /// `No previous chats`
  String get nopreviouschats {
    return Intl.message(
      'No previous chats',
      name: 'nopreviouschats',
      desc: '',
      args: [],
    );
  }

  /// `Start a new conversation to see it here.`
  String get startnewconversation {
    return Intl.message(
      'Start a new conversation to see it here.',
      name: 'startnewconversation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Yesterday`
  String get yesterday {
    return Intl.message('Yesterday', name: 'yesterday', desc: '', args: []);
  }

  /// `Add reminder`
  String get Addreminder {
    return Intl.message(
      'Add reminder',
      name: 'Addreminder',
      desc: '',
      args: [],
    );
  }

  /// `Now, upcoming reminders today`
  String get Nowupcomingreminderstoday {
    return Intl.message(
      'Now, upcoming reminders today',
      name: 'Nowupcomingreminderstoday',
      desc: '',
      args: [],
    );
  }

  /// `{count}m ago`
  String minutesago(int count) {
    return Intl.message(
      '${count}m ago',
      name: 'minutesago',
      desc: '',
      args: [count],
    );
  }

  /// `{count}h ago`
  String hoursago(int count) {
    return Intl.message(
      '${count}h ago',
      name: 'hoursago',
      desc: '',
      args: [count],
    );
  }

  /// `{count}d ago`
  String daysago(int count) {
    return Intl.message(
      '${count}d ago',
      name: 'daysago',
      desc: '',
      args: [count],
    );
  }

  /// `This Tool Does Not Replace Professional Medical Advice. Always Consult Doctor.`
  String get drugInteractionDisclaimer {
    return Intl.message(
      'This Tool Does Not Replace Professional Medical Advice. Always Consult Doctor.',
      name: 'drugInteractionDisclaimer',
      desc: '',
      args: [],
    );
  }

  /// `Show All Details`
  String get showAllDetails {
    return Intl.message(
      'Show All Details',
      name: 'showAllDetails',
      desc: '',
      args: [],
    );
  }

  /// `Drug Information Unavailable`
  String get drugInfoUnavailable {
    return Intl.message(
      'Drug Information Unavailable',
      name: 'drugInfoUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `No interaction data was found for this medication. The drug may be unavailable in our current database or entered incorrectly.`
  String get drugInfoUnavailableSubtitle {
    return Intl.message(
      'No interaction data was found for this medication. The drug may be unavailable in our current database or entered incorrectly.',
      name: 'drugInfoUnavailableSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `No Interactions Found`
  String get noInteractionsFound {
    return Intl.message(
      'No Interactions Found',
      name: 'noInteractionsFound',
      desc: '',
      args: [],
    );
  }

  /// `No known clinically significant interactions were detected between these two medications.`
  String get noInteractionsSubtitle {
    return Intl.message(
      'No known clinically significant interactions were detected between these two medications.',
      name: 'noInteractionsSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `1 Potential Drug Interaction Found`
  String get interactionFound {
    return Intl.message(
      '1 Potential Drug Interaction Found',
      name: 'interactionFound',
      desc: '',
      args: [],
    );
  }

  /// `This combination may affect treatment safety or increase the risk of side effects. Please review the interaction details and consult your healthcare provider if necessary.`
  String get interactionFoundSubtitle {
    return Intl.message(
      'This combination may affect treatment safety or increase the risk of side effects. Please review the interaction details and consult your healthcare provider if necessary.',
      name: 'interactionFoundSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Something Went Wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something Went Wrong',
      name: 'somethingWentWrong',
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
