import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/Widgets/inci_field_data.dart';
import 'package:stripe_payment_flutter/app/data/payment/payment.dart';
import 'package:stripe_payment_flutter/app/res/colors/app_color.dart';
import 'package:stripe_payment_flutter/app/utils/validator.dart';

class HomeController extends GetxController {
  final amountFieldData = TextFieldData(validator: Validator.notEmptyValidator, keyboardType: TextInputType.number);
  final nameFieldData = TextFieldData(validator: Validator.notEmptyValidator, keyboardType: TextInputType.text);
  final addressFieldData = TextFieldData(validator: Validator.notEmptyValidator, keyboardType: TextInputType.text);
  final cityFieldData = TextFieldData(validator: Validator.notEmptyValidator, keyboardType: TextInputType.text);
  final stateFieldData = TextFieldData(validator: Validator.notEmptyValidator, keyboardType: TextInputType.text);
  final countryFieldData = TextFieldData(validator: Validator.notEmptyValidator, keyboardType: TextInputType.text);
  final pinFieldData = TextFieldData(validator: Validator.notEmptyValidator, keyboardType: TextInputType.number);
  final selectFieldData = TextFieldData();

  final GlobalKey<FormState> _donatKey = GlobalKey<FormState>();
  GlobalKey<FormState> get donatKey => _donatKey;

  List<String> currencyList = <String>['USD', 'INR', 'EUR', 'JPY', 'GBP', 'AED'];
  var selectedCurrency = 'USD'.obs;

  var hasDonated = false.obs;

  Future<void> initPaymentSheet() async {
    try {
      final data = await createPaymentIntent(
        amount: (int.parse(amountFieldData.textInField) * 100).toString(),
        currency: selectedCurrency.value,
        name: nameFieldData.textInField,
        address: addressFieldData.textInField,
        pin: pinFieldData.textInField,
        city: cityFieldData.textInField,
        state: stateFieldData.textInField,
        country: countryFieldData.textInField,
      );

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Test Merchant',
          paymentIntentClientSecret: data['client_secret'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['id'],
          style: ThemeMode.dark,
        ),
      );
    } catch (e) {
      Get.snackbar('Error', 'Payment initialization failed: $e');
      rethrow;
    }
  }

  Future<void> proceedToPay() async {
    if (donatKey.currentState!.validate()) {
      await initPaymentSheet();
      try {
        await Stripe.instance.presentPaymentSheet();
        Get.snackbar('Success', 'Payment Done', backgroundColor: AppColor.greenColor);
        hasDonated.value = true;
        clearForm();
      } catch (e) {
        Get.snackbar('Error', 'Payment Failed', backgroundColor: AppColor.warningColor);
      }
    }
  }

  void setStatusBarStyle() => SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: AppColor.textColorUnFocus));

  // Clear form fields
  void clearForm() {
    amountFieldData.controller.clear();
    nameFieldData.controller.clear();
    addressFieldData.controller.clear();
    cityFieldData.controller.clear();
    stateFieldData.controller.clear();
    countryFieldData.controller.clear();
    pinFieldData.controller.clear();
  }
}
