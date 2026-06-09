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
