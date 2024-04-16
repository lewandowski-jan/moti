import 'package:flutter/material.dart';
import 'package:moti/l10n/localizations.dart';

extension BuildContextL10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;

  Locale get locale => Localizations.localeOf(this);
}
