import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/modules/login/controllers/login_controller.dart';
import 'package:stripe_payment_flutter/app/modules/login/widget/body.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Body(),
        ),
      ),
    );
  }
}
