import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_en.dart';
import 'localizations_pl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pl')
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Moti'**
  String get app_name;

  /// No description provided for @generic_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong!'**
  String get generic_error;

  /// No description provided for @activity_screen_pushups_done.
  ///
  /// In en, this message translates to:
  /// **'You have already done pushups today, you will carry the logs!'**
  String get activity_screen_pushups_done;

  /// No description provided for @activity_screen_pushups_not_done.
  ///
  /// In en, this message translates to:
  /// **'You have not done pushups today, who\'s gonna carry the logs?'**
  String get activity_screen_pushups_not_done;

  /// No description provided for @add_activity_add_pushups.
  ///
  /// In en, this message translates to:
  /// **'Add pushups'**
  String get add_activity_add_pushups;

  /// No description provided for @add_activity_amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get add_activity_amount;

  /// No description provided for @add_activity_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add_activity_add;

  /// No description provided for @streak_streak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak_streak;

  /// No description provided for @streak_current_streak.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get streak_current_streak;

  /// No description provided for @streak_longest_streak.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get streak_longest_streak;

  /// No description provided for @total_total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total_total;

  /// No description provided for @total_today_total.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get total_today_total;

  /// No description provided for @total_all_time_total.
  ///
  /// In en, this message translates to:
  /// **'All time'**
  String get total_all_time_total;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @settings_theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme;

  /// No description provided for @theme_system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get theme_system;

  /// No description provided for @theme_light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get theme_light;

  /// No description provided for @theme_dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get theme_dark;

  /// No description provided for @settings_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language;

  /// No description provided for @language_polish.
  ///
  /// In en, this message translates to:
  /// **'Polish'**
  String get language_polish;

  /// No description provided for @language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_english;

  /// No description provided for @reminders_reminder_title.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminders_reminder_title;

  /// No description provided for @reminders_motivation_1.
  ///
  /// In en, this message translates to:
  /// **'Get comfortable with being uncomfortable.'**
  String get reminders_motivation_1;

  /// No description provided for @reminders_motivation_2.
  ///
  /// In en, this message translates to:
  /// **'Embrace the suck and keep pushing forward.'**
  String get reminders_motivation_2;

  /// No description provided for @reminders_motivation_3.
  ///
  /// In en, this message translates to:
  /// **'Your mind will quit a thousand times before your body will.'**
  String get reminders_motivation_3;

  /// No description provided for @reminders_motivation_4.
  ///
  /// In en, this message translates to:
  /// **'Stay hard. Stay hungry. Stay alive.'**
  String get reminders_motivation_4;

  /// No description provided for @reminders_motivation_5.
  ///
  /// In en, this message translates to:
  /// **'Be the hardest worker in the room, no matter what.'**
  String get reminders_motivation_5;

  /// No description provided for @reminders_motivation_6.
  ///
  /// In en, this message translates to:
  /// **'You\'re the master of your fate. Start acting like it.'**
  String get reminders_motivation_6;

  /// No description provided for @reminders_motivation_7.
  ///
  /// In en, this message translates to:
  /// **'The only way to grow is to suffer. Embrace it.'**
  String get reminders_motivation_7;

  /// No description provided for @reminders_motivation_8.
  ///
  /// In en, this message translates to:
  /// **'Don\'t let your past dictate your future.'**
  String get reminders_motivation_8;

  /// No description provided for @reminders_motivation_9.
  ///
  /// In en, this message translates to:
  /// **'Pain is temporary. Regret lasts forever.'**
  String get reminders_motivation_9;

  /// No description provided for @reminders_motivation_10.
  ///
  /// In en, this message translates to:
  /// **'Become obsessed with becoming the best version of yourself.'**
  String get reminders_motivation_10;

  /// No description provided for @reminders_motivation_11.
  ///
  /// In en, this message translates to:
  /// **'The only limits that exist are the ones you place on yourself.'**
  String get reminders_motivation_11;

  /// No description provided for @reminders_motivation_12.
  ///
  /// In en, this message translates to:
  /// **'Stop making excuses. Start making progress.'**
  String get reminders_motivation_12;

  /// No description provided for @reminders_motivation_13.
  ///
  /// In en, this message translates to:
  /// **'Greatness is earned, never given.'**
  String get reminders_motivation_13;

  /// No description provided for @reminders_motivation_14.
  ///
  /// In en, this message translates to:
  /// **'You can\'t cheat the grind.'**
  String get reminders_motivation_14;

  /// No description provided for @reminders_motivation_15.
  ///
  /// In en, this message translates to:
  /// **'When you think you\'re done, you\'re only at 40% of your body\'s capability.'**
  String get reminders_motivation_15;

  /// No description provided for @reminders_motivation_16.
  ///
  /// In en, this message translates to:
  /// **'Embrace the struggle. It\'s where growth happens.'**
  String get reminders_motivation_16;

  /// No description provided for @reminders_motivation_17.
  ///
  /// In en, this message translates to:
  /// **'Stay hard when it\'s easy. Stay hard when it\'s tough. Stay hard always.'**
  String get reminders_motivation_17;

  /// No description provided for @reminders_motivation_18.
  ///
  /// In en, this message translates to:
  /// **'Don\'t wait for inspiration. Be the inspiration.'**
  String get reminders_motivation_18;

  /// No description provided for @reminders_motivation_19.
  ///
  /// In en, this message translates to:
  /// **'The path to greatness is paved with pain. Walk it proudly.'**
  String get reminders_motivation_19;

  /// No description provided for @reminders_motivation_20.
  ///
  /// In en, this message translates to:
  /// **'Make the sacrifice today so you can become who you\'re meant to be tomorrow.'**
  String get reminders_motivation_20;

  /// No description provided for @reminders_motivation_21.
  ///
  /// In en, this message translates to:
  /// **'Feel the pain and do it anyway.'**
  String get reminders_motivation_21;

  /// No description provided for @reminders_motivation_22.
  ///
  /// In en, this message translates to:
  /// **'Rewrite your story, starting now.'**
  String get reminders_motivation_22;

  /// No description provided for @reminders_motivation_23.
  ///
  /// In en, this message translates to:
  /// **'Who\'s gonna carry the boats?'**
  String get reminders_motivation_23;

  /// No description provided for @reminders_motivation_24.
  ///
  /// In en, this message translates to:
  /// **'Don\'t be a bitch!'**
  String get reminders_motivation_24;

  /// No description provided for @reminders_motivation_25.
  ///
  /// In en, this message translates to:
  /// **'They don\'t know me son!'**
  String get reminders_motivation_25;

  /// No description provided for @reminders_motivation_26.
  ///
  /// In en, this message translates to:
  /// **'If you want to shine like sun first you have to burn like it.'**
  String get reminders_motivation_26;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'pl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pl':
      return AppLocalizationsPl();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
