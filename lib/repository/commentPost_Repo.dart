import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/utility/utility_strings.dart';
import '../modal/commentPostModal.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class CommentPostRepo {
  static List<CommentPostModal> commentPostList = [];
  static int commentId = 0;
  static var headers = {
    'Content-Type': 'application/json',
  };

  static addComment(
      int createdBy,
      int modifiedBy,
      DateTime createdDate,
      DateTime modifiedDate,
      bool isDeleted,
      int id,
      int activityId,
      String comments,
      DateTime timestamp,
      BuildContext context) async {
    Uri uri = Uri.http(kBaseUrl, '/gram-activity-comment');

    var data = jsonEncode({
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'createdDate': createdDate.toIso8601String(),
      'modifiedDate': modifiedDate.toIso8601String(),
      'isDeleted': isDeleted,
      'id': id,
      'activityId': activityId,
      'comments': comments,
      'timestamp': timestamp.toIso8601String()
    });

    try {
      http.Response response =
          (await http.post(uri, headers: headers, body: data));
      if (response.statusCode == 200) {
        commentController.clear();
        Map res = jsonDecode(response.body);
        commentId = res['responseData'];
        Get.snackbar('cmtStatus'.tr, 'cmtAddedMsg'.tr,
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
