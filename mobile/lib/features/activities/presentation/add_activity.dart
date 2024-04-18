import 'package:flutter/material.dart';
import 'package:leancode_hooks/leancode_hooks.dart';

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
        const Text('Add pushups', style: TextStyle(fontSize: 20)),
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
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: onSubmitted,
          child: const Text('Add'),
        ),
      ],
    );
  }
}
