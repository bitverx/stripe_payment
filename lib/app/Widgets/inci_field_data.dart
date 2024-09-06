import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/extensions/string_extensions.dart';
import 'package:stripe_payment_flutter/app/res/colors/app_color.dart';

import 'capitalize_sentence_text.dart';

class TextFieldData {
  TextFieldData({
    this.isPassword = false,
    this.isClear = false,
    this.onChanged,
    this.onFieldSubmit,
    this.validator,
    this.keyboardType = TextInputType.text,
    // this.textInputAction = TextInputAction.next,
    String? initValue,
    this.maxLength,
    List<TextInputFormatter> formatters = const [],
    this.textCapitalization = TextCapitalization.sentences,
    this.optionPosition = const [0],
  })  : controller = TextEditingController(text: initValue),
        _formatters = isPassword || textCapitalization != TextCapitalization.sentences || keyboardType != TextInputType.text
            ? formatters
            : [...formatters, CapitalizeSentenceCaseTextFormatter()] {
    if (initValue != null) _counterText.value = initValue.length;
  }

  final bool isPassword;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  // final TextInputAction textInputAction;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final List<TextInputFormatter> _formatters;
  final bool isClear;
  final TextEditingController controller;
  final errorText = ''.obs;
  final passwordVisible = false.obs;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmit;
  List<int> optionPosition;

  final _counterText = 0.obs;

  String? get error => errorText.value.nullIfEmpty;

  bool get obscureText => isPassword && !passwordVisible.value;

  String get textInField => controller.text;

  List<TextInputFormatter> get formatters => _formatters;

  int get counterText => _counterText.value;

  set counterText(int newLength) => _counterText.value = newLength;

  set textInField(String newText) {
    controller
      ..text = newText
      ..selection = TextSelection.collapsed(offset: newText.length);
  }

  void togglePasswordVisible() {
    passwordVisible.value = !passwordVisible.value;
  }
}

class XTextField extends StatelessWidget {
  const XTextField({
    super.key,
    this.hintText,
    required this.fieldData,
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    this.label,
    this.isEnabled = true,
    this.filledColor = Colors.white,
    this.showCounterText = true,
    this.onTapAction,
    this.errorHeight = 1,
    this.enableInteractiveSelection = true,
    this.focusNode,
    this.infoLabel,
    this.textAlign = TextAlign.left,
    this.textStyle,
    this.textInputAction = TextInputAction.next,
    this.cursorColor,
  });

  final String? hintText;
  final TextFieldData fieldData;
  final int? maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final bool isEnabled;
  final Color? filledColor;
  final bool showCounterText;
  final String? label;
  final VoidCallback? onTapAction;
  final double errorHeight;
  final bool enableInteractiveSelection;
  final FocusNode? focusNode;
  final String? infoLabel;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final TextInputAction textInputAction;
  final Color? cursorColor;

  OutlineInputBorder get _focusedBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColor.blueText), // Use blueText color for focused border
      );
  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: isEnabled ? AppColor.borderSelected : AppColor.borderColorUnSelected),
      );

  OutlineInputBorder get _borderUnSelected => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColor.borderColorUnSelected),
      );

  Color get _filledColor {
    return isEnabled ? filledColor ?? Colors.white : Colors.white;
  }

  TextStyle? get _textStyle {
    if (!isEnabled) {
      return Get.textTheme.bodySmall?.copyWith(
        color: AppColor.textColorUnFocus,
        fontWeight: FontWeight.w400,
      );
    }

    if (textStyle != null) return textStyle;

    return Get.textTheme.bodyMedium?.copyWith(
      color: isEnabled ? AppColor.textColor : AppColor.textColorUnFocus,
      fontWeight: FontWeight.w400,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(buildTextFormField);
  }

  @protected
  Widget buildTextFormField() {
    return TextFormField(
      textAlign: textAlign,
      textCapitalization: fieldData.textCapitalization,
      controller: fieldData.controller,
      validator: fieldData.validator,
      obscureText: fieldData.obscureText,
      keyboardType: fieldData.keyboardType,
      maxLines: maxLines,
      maxLength: fieldData.maxLength,
      inputFormatters: fieldData.formatters,
      readOnly: !isEnabled,
      onTap: onTapAction,
      onFieldSubmitted: (text) {
        if (textInputAction == TextInputAction.next) {
          focusNode?.nextFocus();
        } else if (textInputAction == TextInputAction.done) {
          focusNode?.unfocus();
        }
        if (fieldData.onFieldSubmit != null) fieldData.onFieldSubmit!(text);
      },
      onChanged: (text) {
        fieldData.counterText = text.length;
        if (fieldData.onChanged != null) fieldData.onChanged!(text);
      },
      enableInteractiveSelection: enableInteractiveSelection,
      focusNode: focusNode,
      style: _textStyle,
      decoration: InputDecoration(
        errorStyle: TextStyle(height: errorHeight),
        labelText: label,
        hintText: hintText,
        labelStyle: Get.textTheme.bodyMedium?.copyWith(
          color: AppColor.textColorUnFocus,
          fontWeight: FontWeight.w400,
        ),
        hintStyle: Get.textTheme.bodySmall?.copyWith(
          color: AppColor.textColorUnFocus,
          fontWeight: FontWeight.w400,
        ),
        floatingLabelStyle: const TextStyle(color: AppColor.textColorUnFocus),
        fillColor: _filledColor,
        filled: true,
        errorText: fieldData.error,
        errorMaxLines: 2,
        prefixIcon: prefix,
        prefixIconConstraints: const BoxConstraints(),
        suffix: suffix != null ? null : const SizedBox(width: 15),
        suffixIcon: fieldData.isPassword
            ? IconButton(
                icon: Icon(
                  fieldData.passwordVisible.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: AppColor.textColorUnFocus,
                  size: 20,
                ),
                onPressed: fieldData.togglePasswordVisible,
              )
            : fieldData.isClear
                ? IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 20,
                      color: AppColor.textColorUnFocus,
                    ),
                    onPressed: () {
                      fieldData.controller.clear();
                      if (fieldData.onChanged != null) {
                        fieldData.onChanged!('');
                      }
                    },
                  )
                : suffix,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        focusedBorder: _focusedBorder,
        enabledBorder: _borderUnSelected,
        counterText: showCounterText ? null : '',
      ),
      textInputAction: textInputAction, // Pass the textInputAction here
    );
  }
}
