import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:http/http.dart' as http;
import '../modal/appLoginModal.dart';
import '../utility/constant.dart';
import '../utility/utilityMethods.dart';

class PostOtpData {
  static List<AppLoginModal> loginDetails = [];
  static var isLoading = true.obs;

  static postOtp(
      String mobileNo, String otp, String fcmId, BuildContext context) async {
    Uri uri =
        Uri.http(kBaseUrl, '/LoginGramSuvidha/GetLoginWithOTPGramSuvidha');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };

    var data = jsonEncode({
      'mobileNo': mobileNo,
      'otp': otp,
      'versionNo': '',
      'deviceTypeId': 0,
      'fcmId': fcmId,
    });

    try {
      print(data);
      http.Response response = (await http.post(
        uri,
        body: data,
        headers: headers,
      ));
      if (response.statusCode == 200) {
        isLoading.value = false;
        final temp = jsonDecode(response.body);
        print(temp);
        final value = AppLoginModal.fromJson(temp["responseData"]);
        loginDetails.add(value);
        UtilityMethods.snackBarMethod(context, 'loginSnackBarMsg'.tr);
        Timer(const Duration(seconds: 3), () {
          Get.offAllNamed('/gramSuvidhaDashboardScreen');
        });

        return loginDetails;
      }
    } catch (e) {
      (otpController2.text.isEmpty)
          ? UtilityMethods.snackBarMethod(context, 'emptyOtpSnackBarMsg'.tr)
          : UtilityMethods.snackBarMethod(context, 'invalidOtpSnackBarMsg'.tr);
      print(e);
    }
  }
}
