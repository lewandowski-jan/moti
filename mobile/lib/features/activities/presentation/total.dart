import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moti/l10n/l10n.dart';

class Total extends StatelessWidget {
  const Total({
    super.key,
    required this.totalToday,
    required this.total,
  });

  final int totalToday;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.total_total,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  context.l10n.total_today_total,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  totalToday.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Text(
                  context.l10n.total_all_time_total,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  total.toString(),
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
