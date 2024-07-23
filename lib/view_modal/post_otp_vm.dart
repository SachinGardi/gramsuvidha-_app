import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gramsuvidha/main.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import '../repository/post_otp.dart';

String? userName;
int? userId;
int? userTypeId;
String? yojanaName;
int? grampanchayatId;
final userIdValue = GetStorage();
final userType = GetStorage();
final gramPanchayatIdValue = GetStorage();

class PostOtpViewModal extends GetxController {
  var isLoading = true.obs;

  postAllInformation(BuildContext context) async {
    await PostOtpData.postOtp(
        mobileController.text, otpController2.text, tokenId!, context);

    PostOtpData.loginDetails.forEach((element) {
      userName = element.fullName;
      userId = element.userId;
      userTypeId = element.userTypeId;
      grampanchayatId = element.grampanchayatId;
      print(element.userTypeName);
      print(element.userTypeId);
      print(element.grampanchayatId);
    });

    userIdValue.write('userId', userId);
    userType.write('userTypeId', userTypeId);
    gramPanchayatIdValue.write('gramPanId', grampanchayatId);
  }

  void restart() {
    countDownController.restart();
  }
}
