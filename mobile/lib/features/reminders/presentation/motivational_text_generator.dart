import 'dart:math';

import 'package:moti/l10n/localizations.dart';

class MotivationalTextGenerator {
  static String generate(AppLocalizations l10n) {
    final number = Random().nextInt(26) + 1;

    return switch (number) {
      1 => l10n.reminders_motivation_1,
      2 => l10n.reminders_motivation_2,
      3 => l10n.reminders_motivation_3,
      4 => l10n.reminders_motivation_4,
      5 => l10n.reminders_motivation_5,
      6 => l10n.reminders_motivation_6,
      7 => l10n.reminders_motivation_7,
      8 => l10n.reminders_motivation_8,
      9 => l10n.reminders_motivation_9,
      10 => l10n.reminders_motivation_10,
      11 => l10n.reminders_motivation_11,
      12 => l10n.reminders_motivation_12,
      13 => l10n.reminders_motivation_13,
      14 => l10n.reminders_motivation_14,
      15 => l10n.reminders_motivation_15,
      16 => l10n.reminders_motivation_16,
      17 => l10n.reminders_motivation_17,
      18 => l10n.reminders_motivation_18,
      19 => l10n.reminders_motivation_19,
      20 => l10n.reminders_motivation_20,
      21 => l10n.reminders_motivation_21,
      22 => l10n.reminders_motivation_22,
      23 => l10n.reminders_motivation_23,
      24 => l10n.reminders_motivation_24,
      25 => l10n.reminders_motivation_25,
      _ => l10n.reminders_motivation_26,
    };
  }
}
