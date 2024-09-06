import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/res/colors/app_color.dart';

class Utils {
  static void fieldFocusChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.blackColor,
      textColor: AppColor.whiteColor,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
    );
  }

  static void toastMessageCenter(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.blackColor,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_LONG,
      textColor: AppColor.whiteColor,
    );
  }

  static void errorSnack(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColor.redColor,
      gravity: ToastGravity.TOP,
      toastLength: Toast.LENGTH_LONG,
      textColor: AppColor.whiteColor,
    );
  }

  static void successSnack(String title, String message) {
    Get.snackbar(
      backgroundColor: AppColor.linkColor,
      title,
      message,
    );
  }

  static void snackBar(String title, String message) {
    Get.snackbar(backgroundColor: AppColor.blueText, title, message, colorText: AppColor.whiteColor);
  }

  successMessage(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.greenColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
  errorMessage(String message) => Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColor.darkPrimaryColor,
        textColor: Colors.white,
        fontSize: 16.0,
      );
}
