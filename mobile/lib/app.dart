import 'package:flutter/material.dart';
import 'package:moti/features/activities/presentation/activity_screen.dart';
import 'package:moti/l10n/localizations.dart';

class MtApp extends StatelessWidget {
  const MtApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
      home: AcitivityScreen(),
    );
  }
}
