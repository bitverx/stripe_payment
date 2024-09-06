import 'dart:convert';
import 'package:get/get.dart';


extension NullableStringExtensions on String? {
  String? get nullIfEmpty => this?.isEmpty == true ? null : this;

  String get orEmpty => this == null ? '' : this!;
}

extension StringExtensions on String {
  static final RegExp _nonAlphaNumeric = RegExp('[^A-Za-z0-9]');
  static final RegExp _alpha = RegExp('[^A-Za-z]');

  String get getOnlyAlphaCharacters => replaceAll(_alpha, '');

  String get getNumericWithAlphaCharacters => replaceAll(_nonAlphaNumeric, '');

  String get phoneWithoutCountryCode => numericOnly().substring(2);

  String get onlyCountryCode => substring(0, 3);

  String get withoutUnderscore => replaceAll('_', ' ');

  String get removeWhiteSpaces => trimLeft().trimRight();

  String get removeTextInArrowBrackets =>
      replaceAll(RegExp('(?<=<)(.*?)(?=>)', unicode: true), '').replaceAll('<', '').replaceAll('>', '');

  int get bytesLength => utf8.encode(this).length;

  String maskString(String mask) {
    final splittedString = split(' ');

    final maskedString = splittedString.map(
          (word) {
        if (word.length > 2) {
          final repeatCharacter = word.length - 2;
          final newValue = word.replaceRange(2, word.length, mask * repeatCharacter);
          return newValue;
        } else {
          return word;
        }
      },
    ).join(' ');

    return maskedString;
  }

  String phoneNumberOnly(String countryCode) => numericOnly().substring(countryCode.length - 1);
}
