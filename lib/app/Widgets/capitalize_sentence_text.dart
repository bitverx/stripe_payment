import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CapitalizeSentenceCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return TextEditingValue(
      text: toBeginningOfSentenceCase(newValue.text, 'en') ?? newValue.text,
      selection: newValue.selection,
    );
  }
}
