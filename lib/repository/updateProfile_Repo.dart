import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utilityMethods.dart';
import '../modal/updateProfileModal.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class UpdateProfileData {
  List<UpdateProfile> updateProfileList = [];

  static var headers = {
    'Content-Type': 'application/json',
  };

  static updateProfileData(
    int userId,
    String fullName,
    String mobileNo,
    String email,
    String address,
    String imageUrl,
    BuildContext context,
  ) async {
    Uri uri = Uri.http(kBaseUrl, '/UserRegistration/UpdateUserProfile');

    var data = jsonEncode({
      'userId': userId,
      'fullName': fullName,
      'mobileNo': mobileNo,
      'emailId': email,
      'address': address,
      'profilePhoto': imageUrl
    });
    try {
      http.Response response =
          (await http.put(uri, body: data, headers: headers));
      print(response.statusCode);
      if (response.statusCode == 200) {
        UtilityMethods.snackBarMethod(context, 'profileUpdateMsg'.tr);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      debugPrintStack();
    }
  }
}
