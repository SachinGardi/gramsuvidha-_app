import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gramsuvidha/modal/userProfileModal.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import 'package:http/http.dart' as http;

import '../utility/constant.dart';

class GetUserProfileRepo {
  static List<GetUserProfile> getProfileData = [];

  static getProfileInfo() async {
    var queryParams = {'UserId': '${userIdValue.read('userId')}'};

    Uri uri =
        Uri.http(kBaseUrl, "/UserRegistration/GetUserProfile", queryParams);

    try {
      http.Response response = (await http.get(uri));

      if (response.statusCode == 200) {
        getProfileData.clear();
        Map temp = json.decode(utf8.decode(response.bodyBytes));
        print(temp);
        final value = GetUserProfile.fromJson(temp["responseData"]);
        getProfileData.add(value);

        return getProfileData;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception in Data $e');
      }
      debugPrintStack();
    }
  }
}
