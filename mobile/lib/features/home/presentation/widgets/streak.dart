import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moti/core/context.dart';

class Streak extends StatelessWidget {
  const Streak({
    super.key,
    required this.streak,
    required this.maxStreak,
  });

  final int streak;
  final int maxStreak;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.streak_streak,
          style: context.textTheme.titleLarge,
        ),
        Column(
          children: [
            Text(
              context.l10n.streak_current_streak,
              style: context.textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              streak.toString(),
              style: context.textTheme.headlineSmall,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          children: [
            Text(
              context.l10n.streak_longest_streak,
              style: context.textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              maxStreak.toString(),
              style: context.textTheme.headlineSmall,
            ),
          ],
        ),
      ],
    );
  }
}
