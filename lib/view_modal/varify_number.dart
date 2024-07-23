import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modal/getOtpModal.dart';
import '../repository/get_otp.dart';

String? validateMob;

class OTPViewModal extends GetxController {
  List<OtpModal> otpList = [];

  var isLoading = true.obs;

  @override
  void onReady() {
    super.onReady();
    //   getOTPInformation(mobileNumberController.text!);
  }

  getOTPInformation(String mob, BuildContext context) async {
    var details = await OTPRepository.getOtpByMobile(mob, context);
    print("mob:$mob");

    if (details != null) {
      otpList = details;
      isLoading.value = false;
    }
  }
}
