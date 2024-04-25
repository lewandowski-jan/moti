import 'package:flutter/material.dart';
import 'package:leancode_hooks/leancode_hooks.dart';
import 'package:moti/l10n/l10n.dart';

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
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: 200,
          child: TextField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => onSubmitted(),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            controller: amountController,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            scrollPadding:
                const EdgeInsets.all(20) + const EdgeInsets.only(bottom: 60),
            decoration: InputDecoration(
              labelText: context.l10n.add_activity_amount,
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onSubmitted,
          child: Text(context.l10n.add_activity_add),
        ),
      ],
    );
  }
}
