import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
        const Text(
          'Total',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                const Text(
                  'Today',
                  style: TextStyle(fontSize: 16),
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
                const Text(
                  'All time',
                  style: TextStyle(fontSize: 16),
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
