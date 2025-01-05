import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moti/core/context.dart';

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
          context.l10n.moti_points,
          style: context.textTheme.titleLarge,
        ),
        Column(
          children: [
            Text(
              context.l10n.total_today_total,
              style: context.textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              totalToday.toString(),
              style: context.textTheme.headlineSmall,
            ),
          ],
        ),
        const SizedBox(width: 16),
        Column(
          children: [
            Text(
              context.l10n.total_all_time_total,
              style: context.textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              total.toString(),
              style: context.textTheme.headlineSmall,
            ),
          ],
        ),
      ],
    );
  }
}
