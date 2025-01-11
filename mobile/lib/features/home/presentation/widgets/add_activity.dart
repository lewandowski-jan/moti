import 'package:flutter/material.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/core/context.dart';
import 'package:moti/core/routes.dart';

class AddActivity extends HookWidget {
  const AddActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AddActivityRoute().push(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
          left: 16,
          right: 6,
        ),
        height: 60,
        decoration: BoxDecoration(
          color: context.colors.primaryWeak,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.add_activity_add,
              style: context.textTheme.bodyLarge,
            ),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.directions_run,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
