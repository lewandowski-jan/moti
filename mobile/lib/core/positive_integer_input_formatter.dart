import 'package:flutter/services.dart';

class PositiveIntegerInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    final regex = RegExp(r'^[1-9]\d*$');

    if (newText.isEmpty || regex.hasMatch(newText)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
