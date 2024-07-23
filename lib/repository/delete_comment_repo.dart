import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class DeleteCommentRepo {
  static var headers = {
    'Content-Type': 'application/json',
  };

  static deleteComment(BuildContext context, int id, int userId, int deletedBy,
      DateTime modifiedDate, bool isDeleted) async {
    Uri url = Uri.http(kBaseUrl, '/gram-activity-comment');
    var data = jsonEncode({
      'id': id,
      'userId': userId,
      'deletedBy': deletedBy,
      'modifiedDate': modifiedDate.toIso8601String(),
      'isDeleted': isDeleted,
    });
    try {
      http.Response response =
          (await http.delete(url, body: data, headers: headers));
      if (response.statusCode == 200) {
        Get.back();
        Get.back();
        Get.snackbar('cmtStatus'.tr, 'cmtDeleteMsg'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.black87,
            colorText: Colors.white,
            duration: const Duration(seconds: 1),
            margin: EdgeInsets.only(
                bottom: context.mediaQueryWidth / 10,
                left: context.mediaQueryWidth / 20,
                right: context.mediaQueryWidth / 20));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      debugPrintStack();
    }
  }
}
