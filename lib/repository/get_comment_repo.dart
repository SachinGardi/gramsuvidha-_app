import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import '../modal/getCommentModal.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class GetCommentRepo {
  static List<GetCommentModal> getCommentList = [];

  static getComment(int activityId) async {
    var queryParams = {
      'UserId': '${userIdValue.read('userId')}',
      'ActivityId': '$activityId'
    };

    Uri url =
        Uri.http(kBaseUrl, '/gram-activity-comment/GetComment', queryParams);

    try {
      http.Response response = (await http.get(url));
      if (response.statusCode == 200) {
        getCommentList.clear();
        print(response.body);
        Map res = jsonDecode(response.body);
        if (res['responseData'] != null) {
          res['responseData'].forEach((comment) {
            getCommentList.add(GetCommentModal(
              comments: comment['comments'],
              fullName: comment['fullName'],
              activityId: comment['activityId'],
              id: comment['id'],
              isDeleted: comment['isDeleted'],
              createdDate: DateTime.parse(comment['createdDate']),
              timestamp: DateTime.parse(comment['timestamp']),
              modifiedBy: comment['modifiedBy'],
              modifiedDate: DateTime.parse(comment['modifiedDate']),
              createdBy: comment['createdBy'],
              key: comment['key'],
            ));
          });
          return getCommentList;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      debugPrintStack();
    }
  }
}
