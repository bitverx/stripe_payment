import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stripe_payment_flutter/app/Widgets/inci_field_data.dart';
import 'package:stripe_payment_flutter/app/modules/home/controllers/home_controller.dart';
import 'package:stripe_payment_flutter/app/res/colors/app_color.dart';
import 'package:stripe_payment_flutter/app/res/string/app_string.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    controller.setStatusBarStyle();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: controller.donatKey,
            child: Column(
              children: [
                const Image(image: AssetImage("assets/donation.jpg"), height: 300, width: double.infinity, fit: BoxFit.cover),
                Obx(() => controller.hasDonated.value
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${AppString.thankYou} ${controller.amountFieldData.textInField} ${controller.selectedCurrency.value} ${AppString.donation}",
                              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),
                            const Text(AppString.appreciateYou, style: TextStyle(fontSize: 18)),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.lightPrimaryColor,
                                ),
                                child: const Text(AppString.donatAgain, style: TextStyle(color: AppColor.whiteColor, fontSize: 16)),
                                onPressed: () {
                                  controller.hasDonated.value = false;
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(AppString.homeHeading,
                                textAlign: TextAlign.center, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: XTextField(
                                        label: AppString.donationTitle,
                                        hintText: AppString.anyAmount,
                                        fieldData: controller.amountFieldData,
                                        textInputAction: TextInputAction.done)),
                                const SizedBox(width: 10),
                                Expanded(
                                    flex: 3,
                                    child: XTextField(
                                      label: '',
                                      hintText: '',
                                      fieldData: controller.selectFieldData,
                                      prefix: DropdownButtonFormField<String>(
                                        decoration: const InputDecoration(border: InputBorder.none),
                                        value: controller.currencyList.first,
                                        onChanged: (String? value) {
                                          controller.selectedCurrency.value = value!;
                                        },
                                        items: controller.currencyList.map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: const TextStyle(color: Colors.grey),
                                            ),
                                          );
                                        }).toList(),
                                      ).paddingSymmetric(horizontal: 10),
                                    )),
                              ],
                            ).paddingSymmetric(horizontal: 10),
                            const SizedBox(height: 10),
                            XTextField(
                                    label: AppString.name,
                                    hintText: AppString.exJohn,
                                    fieldData: controller.nameFieldData,
                                    textInputAction: TextInputAction.done)
                                .paddingSymmetric(horizontal: 10),
                            const SizedBox(height: 10),
                            XTextField(
                                    label: AppString.addressLine,
                                    hintText: AppString.mainSt,
                                    fieldData: controller.addressFieldData,
                                    textInputAction: TextInputAction.done)
                                .paddingSymmetric(horizontal: 10),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: XTextField(
                                        label: AppString.city,
                                        hintText: AppString.newPak,
                                        fieldData: controller.cityFieldData,
                                        textInputAction: TextInputAction.done)),
                                const SizedBox(width: 10),
                                Expanded(
                                    flex: 5,
                                    child: XTextField(
                                        label: AppString.state,
                                        hintText: AppString.dlDelhi,
                                        fieldData: controller.stateFieldData,
                                        textInputAction: TextInputAction.done)),
                              ],
                            ).paddingSymmetric(horizontal: 10),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                    flex: 5,
                                    child: XTextField(
                                        label: AppString.countryCode,
                                        hintText: AppString.pakistan,
                                        fieldData: controller.countryFieldData,
                                        textInputAction: TextInputAction.done)),
                                const SizedBox(width: 10),
                                Expanded(
                                    flex: 5,
                                    child: XTextField(
                                        label: AppString.pinCode,
                                        hintText: AppString.pinCodeEx,
                                        fieldData: controller.pinFieldData,
                                        textInputAction: TextInputAction.done)),
                              ],
                            ).paddingSymmetric(horizontal: 10),
                            const SizedBox(height: 12),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.lightPrimaryColor,
                                ),
                                child: const Text(AppString.proceedPay, style: TextStyle(color: AppColor.whiteColor, fontSize: 16)),
                                onPressed: () {
                                  controller.proceedToPay();
                                },
                              ),
                            ).paddingSymmetric(horizontal: 10),
                          ],
                        ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
