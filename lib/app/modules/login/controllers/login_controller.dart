import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/Widgets/inci_field_data.dart';
import 'package:stripe_payment_flutter/app/mixins/loading_mixin.dart';
import 'package:stripe_payment_flutter/app/res/colors/app_color.dart';
import 'package:stripe_payment_flutter/app/routes/app_pages.dart';
import 'package:stripe_payment_flutter/app/utils/validator.dart';

class LoginController extends GetxController with LoadingMixin {
  final emailFieldData = TextFieldData(validator: Validator.emailValidator, keyboardType: TextInputType.emailAddress);
  final passwordFieldData = TextFieldData(validator: Validator.passwordValidator, isPassword: true);

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  GlobalKey<FormState> get loginKey => _loginKey;

  Future<void> loginForm() async {
    if (_loginKey.currentState!.validate()) {
      loading.value = true;
      Get.offAllNamed(Routes.HOME);
    }
  }

  void setStatusBarStyle() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.textColorUnFocus,
    ));
  }
}
