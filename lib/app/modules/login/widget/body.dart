import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/Widgets/inci_field_data.dart';
import 'package:stripe_payment_flutter/app/Widgets/round_button.dart';
import 'package:stripe_payment_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:stripe_payment_flutter/app/res/colors/app_color.dart';
import 'package:stripe_payment_flutter/app/res/constants/app_sizes.dart';
import 'package:stripe_payment_flutter/app/res/string/app_string.dart';

class Body extends GetView<LoginController> {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: controller.loginKey,
          child: Column(
            children: [
              Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(AppString.strip_account, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColor.blackColor)),
                      gapW4,
                      Text(AppString.account, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500, color: AppColor.blackColor)),
                    ],
                  ).paddingOnly(top: 70),
                  const Text(AppString.action_login_now, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColor.blackColor))
                      .paddingOnly(top: 30),
                ],
              ),
              const SizedBox(height: 32),
              XTextField(
                  cursorColor: AppColor.signupTextColor,
                  label: '${AppString.label_email} *',
                  hintText: AppString.label_email,
                  fieldData: controller.emailFieldData,
                  suffix: FittedBox(fit: BoxFit.scaleDown, child: Image.asset('assets/email.png', width: 20, height: 20))),
              const SizedBox(height: 24),
              XTextField(
                  label: '${AppString.label_password} *',
                  hintText: AppString.label_password,
                  fieldData: controller.passwordFieldData,
                  textInputAction: TextInputAction.done),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      AppString.label_forgot_password,
                      style: Get.textTheme.bodySmall
                          ?.copyWith(color: AppColor.blueText, decoration: TextDecoration.underline, decorationColor: AppColor.linkColor),
                    ),
                  ).paddingOnly(right: 8),
                ],
              ),
            ],
          ),
        ).paddingSymmetric(horizontal: 24),
        const SizedBox(height: 40),
        Obx(() => RoundButton(
            width: 300,
            height: 48,
            textColor: AppColor.whiteColor,
            buttonColor: AppColor.blueText,
            title: AppString.action_login_now,
            loading: controller.loading.value,
            onPress: controller.loginForm)),
        gapH32,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppString.login__label_dont_have_account_descrption, style: Get.textTheme.bodySmall?.copyWith(color: AppColor.DontColor)),
            gapW6,
            InkWell(
                onTap: () {}, child: Text(AppString.login__action_register_now, style: Get.textTheme.bodySmall?.copyWith(color: AppColor.blueText)))
          ],
        ),
      ],
    );
  }
}
