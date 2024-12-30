import 'package:flutter/material.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/core/context.dart';

class AddActivity extends HookWidget {
  const AddActivity({super.key, required this.onAdd});

  final ValueChanged<int> onAdd;

  void _onAdd(int amount) {
    FocusManager.instance.primaryFocus?.unfocus();
    onAdd(amount);
  }

  @override
  Widget build(BuildContext context) {
    final amountController = useTextEditingController(text: '0');

    void onSubmitted() {
      final amount = int.tryParse(amountController.text);
      if (amount != null && amount > 0) {
        amountController.text = '0';
        _onAdd(amount);
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          context.l10n.add_activity_add_pushups,
          style: context.textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.go,
                onSubmitted: (_) => onSubmitted(),
                style: context.textTheme.headlineLarge,
                controller: amountController,
                onTapOutside: (_) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                scrollPadding: const EdgeInsets.all(20) +
                    const EdgeInsets.only(bottom: 60),
                cursorColor: context.colors.primary,
                cursorHeight: 28,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: context.l10n.add_activity_amount,
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: context.colors.primary,
                      width: 4,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(400),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: context.colors.primary,
                      width: 4,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(400),
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: context.colors.error,
                      width: 4,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(400),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: context.colors.primary,
                      width: 4,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(400),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton.filled(
              iconSize: 48,
              onPressed: onSubmitted,
              color: context.colors.white,
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(context.colors.primary),
              ),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
