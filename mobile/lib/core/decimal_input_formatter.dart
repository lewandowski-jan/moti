import 'package:flutter/services.dart';

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final newText = newValue.text;

    final regex = RegExp(r'^\d*[\.,]?\d?$');

    if (regex.hasMatch(newText)) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
