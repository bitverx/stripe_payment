import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/res/colors/app_color.dart';
import 'package:stripe_payment_flutter/app/res/constants/app_sizes.dart';
import 'package:stripe_payment_flutter/app/res/theme/theme.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    this.buttonColor,
    this.textColor,
    required this.title,
    required this.onPress,
    this.width = 60,
    this.height = 50,
    this.loading = false,
    this.icon,
  });

  final bool loading;
  final String title;
  final Icon? icon;
  final double height;
  final double width;

  final VoidCallback onPress;

  final Color? textColor;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor ?? AppColor.blueText,
          borderRadius: BorderRadius.circular(10),
        ),
        child: loading
            ? const Center(
                child: CircularProgressIndicator(
                color: AppColor.blueText,
              ))
            : Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title, style: Get.textTheme.bodyTextSemiBold?.copyWith(color: textColor ?? AppColor.whiteColor)),
                    if (icon != null) ...[
                      gapW8,
                      Icon(icon!.icon, color: textColor ?? AppColor.whiteColor, size: 18),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}
