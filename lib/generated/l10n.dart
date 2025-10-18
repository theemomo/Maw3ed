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

  /// `Welcome to Maw’ed`
  String get introPage1Title {
    return Intl.message(
      'Welcome to Maw’ed',
      name: 'introPage1Title',
      desc: '',
      args: [],
    );
  }

  /// `Manage all your appointments in one smart app. simple, organized, and always on time.`
  String get introPage1Description {
    return Intl.message(
      'Manage all your appointments in one smart app. simple, organized, and always on time.',
      name: 'introPage1Description',
      desc: '',
      args: [],
    );
  }

  /// `Never Miss an Appointment`
  String get introPage2Title {
    return Intl.message(
      'Never Miss an Appointment',
      name: 'introPage2Title',
      desc: '',
      args: [],
    );
  }

  /// `Get automatic reminders and notifications to stay on track wherever you are.`
  String get introPage2Description {
    return Intl.message(
      'Get automatic reminders and notifications to stay on track wherever you are.',
      name: 'introPage2Description',
      desc: '',
      args: [],
    );
  }

  /// `Your Time, Your Way`
  String get introPage3Title {
    return Intl.message(
      'Your Time, Your Way',
      name: 'introPage3Title',
      desc: '',
      args: [],
    );
  }

  /// `Customize your schedule colors, organize your week, and make Maw’ed fit your lifestyle.`
  String get introPage3Description {
    return Intl.message(
      'Customize your schedule colors, organize your week, and make Maw’ed fit your lifestyle.',
      name: 'introPage3Description',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginScreenTitle {
    return Intl.message('Login', name: 'loginScreenTitle', desc: '', args: []);
  }

  /// `Register`
  String get registerScreenTitle {
    return Intl.message(
      'Register',
      name: 'registerScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get emailFieldEmptyError {
    return Intl.message(
      'Please enter your email',
      name: 'emailFieldEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get emailFieldValidationError {
    return Intl.message(
      'Please enter a valid email address',
      name: 'emailFieldValidationError',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email`
  String get emailFieldHint {
    return Intl.message(
      'Please Enter Your Email',
      name: 'emailFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailFieldLabel {
    return Intl.message('Email', name: 'emailFieldLabel', desc: '', args: []);
  }

  /// `Please Enter Your Password`
  String get passwordFieldHint {
    return Intl.message(
      'Please Enter Your Password',
      name: 'passwordFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordFieldLabel {
    return Intl.message(
      'Password',
      name: 'passwordFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please Confirm Your Password`
  String get confirmPasswordFieldHint {
    return Intl.message(
      'Please Confirm Your Password',
      name: 'confirmPasswordFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPasswordFieldLabel {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPasswordFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get passwordFieldEmptyError {
    return Intl.message(
      'Please enter your password',
      name: 'passwordFieldEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get passwordFieldLengthError {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'passwordFieldLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one uppercase letter`
  String get passwordFieldUppercaseError {
    return Intl.message(
      'Password must contain at least one uppercase letter',
      name: 'passwordFieldUppercaseError',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one lowercase letter`
  String get passwordFieldLowercaseError {
    return Intl.message(
      'Password must contain at least one lowercase letter',
      name: 'passwordFieldLowercaseError',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one number`
  String get passwordFieldDigitError {
    return Intl.message(
      'Password must contain at least one number',
      name: 'passwordFieldDigitError',
      desc: '',
      args: [],
    );
  }

  /// `Password must contain at least one special character (!, @, #, $, &, *, ~)`
  String get passwordFieldSpecialCharError {
    return Intl.message(
      'Password must contain at least one special character (!, @, #, \$, &, *, ~)',
      name: 'passwordFieldSpecialCharError',
      desc: '',
      args: [],
    );
  }

  /// `Dont have any account?`
  String get dontHaveAccount {
    return Intl.message(
      'Dont have any account?',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message('Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `Already have an account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message('Sign In', name: 'signIn', desc: '', args: []);
  }

  /// `Please Enter Your Name`
  String get nameFieldHint {
    return Intl.message(
      'Please Enter Your Name',
      name: 'nameFieldHint',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get nameFieldLabel {
    return Intl.message('Name', name: 'nameFieldLabel', desc: '', args: []);
  }

  /// `Please enter your name`
  String get nameFieldEmptyError {
    return Intl.message(
      'Please enter your name',
      name: 'nameFieldEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `Name can only contain letters and spaces`
  String get nameFieldOnlyLettersError {
    return Intl.message(
      'Name can only contain letters and spaces',
      name: 'nameFieldOnlyLettersError',
      desc: '',
      args: [],
    );
  }

  /// `Name must be at least 3 characters long`
  String get nameFieldMinLengthError {
    return Intl.message(
      'Name must be at least 3 characters long',
      name: 'nameFieldMinLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message('Today', name: 'today', desc: '', args: []);
  }

  /// `Calender`
  String get calender {
    return Intl.message('Calender', name: 'calender', desc: '', args: []);
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Time`
  String get time {
    return Intl.message('Time', name: 'time', desc: '', args: []);
  }

  /// `Date & Time`
  String get dataAndTime {
    return Intl.message('Date & Time', name: 'dataAndTime', desc: '', args: []);
  }

  /// `Location`
  String get location {
    return Intl.message('Location', name: 'location', desc: '', args: []);
  }

  /// `Add Event`
  String get addEvent {
    return Intl.message('Add Event', name: 'addEvent', desc: '', args: []);
  }

  /// `Select Location`
  String get selectLocation {
    return Intl.message(
      'Select Location',
      name: 'selectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Event Title`
  String get eventTitle {
    return Intl.message('Event Title', name: 'eventTitle', desc: '', args: []);
  }

  /// `Event Description`
  String get eventDescription {
    return Intl.message(
      'Event Description',
      name: 'eventDescription',
      desc: '',
      args: [],
    );
  }

  /// `Event Date`
  String get eventDate {
    return Intl.message('Event Date', name: 'eventDate', desc: '', args: []);
  }

  /// `Event Time`
  String get eventTime {
    return Intl.message('Event Time', name: 'eventTime', desc: '', args: []);
  }

  /// `Event Location`
  String get eventLocation {
    return Intl.message(
      'Event Location',
      name: 'eventLocation',
      desc: '',
      args: [],
    );
  }

  /// `Select Time`
  String get selectTime {
    return Intl.message('Select Time', name: 'selectTime', desc: '', args: []);
  }

  /// `Select Date`
  String get selectDate {
    return Intl.message('Select Date', name: 'selectDate', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Maps`
  String get maps {
    return Intl.message('Maps', name: 'maps', desc: '', args: []);
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

  /// `Event added successfully! You will get a reminder notification.`
  String get eventAddedSuccessfully {
    return Intl.message(
      'Event added successfully! You will get a reminder notification.',
      name: 'eventAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Please fill in all fields`
  String get fillAllFields {
    return Intl.message(
      'Please fill in all fields',
      name: 'fillAllFields',
      desc: '',
      args: [],
    );
  }

  /// `Event must be scheduled for a future time.`
  String get eventMustBeInFuture {
    return Intl.message(
      'Event must be scheduled for a future time.',
      name: 'eventMustBeInFuture',
      desc: '',
      args: [],
    );
  }

  /// `No Events For Today`
  String get noEventsFotToday {
    return Intl.message(
      'No Events For Today',
      name: 'noEventsFotToday',
      desc: '',
      args: [],
    );
  }

  /// `Go To Your Event`
  String get goToEvent {
    return Intl.message(
      'Go To Your Event',
      name: 'goToEvent',
      desc: '',
      args: [],
    );
  }

  /// `Delete Event`
  String get deleteEvent {
    return Intl.message(
      'Delete Event',
      name: 'deleteEvent',
      desc: '',
      args: [],
    );
  }

  /// `Event deleted successfully`
  String get eventDeleted {
    return Intl.message(
      'Event deleted successfully',
      name: 'eventDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Find your event in the maps`
  String get findYourEventInMaps {
    return Intl.message(
      'Find your event in the maps',
      name: 'findYourEventInMaps',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
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
