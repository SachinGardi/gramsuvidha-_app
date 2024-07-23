import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utility/constant.dart';
import '../utility/textcontroller.dart';
import '../utility/utilityMethods.dart';
import '../modal/getOtpModal.dart';

class OTPRepository {
  static List<OtpModal> otpList = [];

  static var isLoading = true.obs;

  static getOtpByMobile(String mobile, BuildContext context) async {
    final queryParameters = {
      'MobileNo': mobile,
    };

    Uri otpUri = Uri.http(
        kBaseUrl, '/LoginGramSuvidha/GetLoginOTPGramSuvidha', queryParameters);

    try {
      http.Response response = (await http.get(otpUri));

      if (response.statusCode == 200) {
        isLoading.value = false;
        final temp = jsonDecode(response.body);
        print(temp);

        final value = OtpModal.fromJson(temp["responseData"]);
        otpList.add(value);

        Get.offAllNamed('/verificationScreen');
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setBool('Register', true);
        return otpList;
      } else if (mobileController.text == '') {
        UtilityMethods.snackBarMethod(context, 'emptyMobileSnackBarMsg'.tr);
      }
    } catch (e) {
      UtilityMethods.snackBarMethod(context, 'invalidMobileSnackBarMsg'.tr);
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
