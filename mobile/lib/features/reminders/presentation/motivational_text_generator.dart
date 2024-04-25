import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:moti/l10n/l10n.dart';

class MotivationalTextGenerator {
  static String generate(BuildContext context) {
    final number = Random().nextInt(26) + 1;

    return switch (number) {
      1 => context.l10n.reminders_motivation_1,
      2 => context.l10n.reminders_motivation_2,
      3 => context.l10n.reminders_motivation_3,
      4 => context.l10n.reminders_motivation_4,
      5 => context.l10n.reminders_motivation_5,
      6 => context.l10n.reminders_motivation_6,
      7 => context.l10n.reminders_motivation_7,
      8 => context.l10n.reminders_motivation_8,
      9 => context.l10n.reminders_motivation_9,
      10 => context.l10n.reminders_motivation_10,
      11 => context.l10n.reminders_motivation_11,
      12 => context.l10n.reminders_motivation_12,
      13 => context.l10n.reminders_motivation_13,
      14 => context.l10n.reminders_motivation_14,
      15 => context.l10n.reminders_motivation_15,
      16 => context.l10n.reminders_motivation_16,
      17 => context.l10n.reminders_motivation_17,
      18 => context.l10n.reminders_motivation_18,
      19 => context.l10n.reminders_motivation_19,
      20 => context.l10n.reminders_motivation_20,
      21 => context.l10n.reminders_motivation_21,
      22 => context.l10n.reminders_motivation_22,
      23 => context.l10n.reminders_motivation_23,
      24 => context.l10n.reminders_motivation_24,
      25 => context.l10n.reminders_motivation_25,
      _ => context.l10n.reminders_motivation_26,
    };
  }
}
