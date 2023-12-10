import 'package:flutter/services.dart';


class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    String value = newText;

    if (value.contains(".") &&
        value.substring(value.indexOf(".") + 1).length > decimalRange) {
      newText = oldValue.text;
    }
  
    return newValue.copyWith(
      text: newText,
      selection: newValue.selection,
    );
  }
}