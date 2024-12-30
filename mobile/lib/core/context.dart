import 'package:flutter/material.dart';
import 'package:moti/core/colors.dart';
import 'package:moti/l10n/localizations.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  Locale get locale => Localizations.localeOf(this);

  MTColors get colors => MTColors.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  Brightness get brightness => Theme.of(this).brightness;
}
