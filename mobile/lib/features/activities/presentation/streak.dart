import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        const Text(
          'Streak',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                const Text(
                  'Current',
                  style: TextStyle(fontSize: 16),
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
                const Text(
                  'Max',
                  style: TextStyle(fontSize: 16),
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
