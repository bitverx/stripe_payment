import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/res/string/app_string.dart';
import 'package:stripe_payment_flutter/app/utils/utils.dart';

class Validator {
  static const _urlPattern =
      r"^((((H|h)(T|t)|(F|f))(T|t)(P|p)((S|s)?))\://)?(www.|[a-zA-Z0-9])[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,6}(\:[0-9]{1,5})*(/($|[a-zA-Z0-9\.\,\;\?\'\\\+&amp;%\$#\=~_\-]+))*$";

  /// phone Pattern '^\+[1-9]\d{10,14}$'
  static const _phoneNumberPattern = r'^\+[1-9]\d{1,14}$';

  static const _alphanumericPattern = r'^[a-zA-Z0-9 &\-]+$';

  static const _alphabetPattern = '[a-zA-Z]';

  static const _numericPattern = '[0-9]';

  static const _referralCodePattern = r'^[A-Za-z0-9]{1,32}$';

  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.label_email_field_required;
    }

    return _emailFormatValidator(value);
  }

  static String? emailOptionalValidator(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    return _emailFormatValidator(value);
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.label_password_field_required;
    }

    final hasDigits = value.contains(RegExp(_numericPattern));
    final hasCharacters = value.contains(RegExp(_alphabetPattern));
    final hasMinLength = value.length >= 8;

    // if (!hasDigits) {
    // return XString.label_password_must_contains_minimum_one_number;
    // }
    //
    // if (!hasCharacters) {
    //   return XString.label_password_must_contains_minimum_one_letter;
    // }

    if (!hasMinLength) {
      return AppString.label_passowrd_length_error;
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return AppString.label_field_can_not_empty;
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? notEmptyValidator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return AppString.label_field_can_not_empty;
    }

    return null;
  }

  static String? notEmptyCountry(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return AppString.select_country;
    }

    return null;
  }

  static String? phoneValidator(String? value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      Utils.errorSnack(AppString.label_field_can_not_empty);
    }
    return null;
  }

  static String? productPriceValidator(String? value, String? message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? amountValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'The field can\'t be empty';
    }

    if (!value.replaceAll('.', '').isNumericOnly) {
      return 'Filed can take numeric values only';
    }

    return null;
  }

  static String? phoneNumberFormatValidator(String? value) {
    final phone = value?.removeAllWhitespace;
    if (!GetUtils.hasMatch(phone, _phoneNumberPattern)) return AppString.label_enter_valid_phone_number;

    return null;
  }

  static String? customNotEmptyValidator(String? value, String? message) {
    if (value == null || value.isEmpty) {
      return message;
    }
    return null;
  }

  static String? _emailFormatValidator(String value) {
    if (!GetUtils.isEmail(value)) {
      return AppString.label_input_right_email_format;
    }

    return null;
  }

  static String? confirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppString.label_password_field_required;
    }
    if (value != _storedPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? validateResetPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Enter Password';
    }
    if (value.length < 8) {
      return 'password greater then 8 characters';
    }
    _storedPassword = value;
    return null;
  }

  static String? _storedPassword;
}
