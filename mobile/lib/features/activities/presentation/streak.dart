import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moti/l10n/l10n.dart';

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
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  context.l10n.streak_current_streak,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  streak.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Text(
                  context.l10n.streak_longest_streak,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  maxStreak.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
