import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../modal/updateCommentModal.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class UpdateCommentRepo {
  static List<UpdateCommentModal> updateCommentList = [];
  static bool isCommentUpdated = false;
  static var headers = {
    'Content-Type': 'application/json',
  };

  static updateComment(
      int createdBy,
      int modifiedBy,
      DateTime createdDate,
      DateTime modifiedDate,
      bool isDeleted,
      int id,
      int activityId,
      String comments,
      DateTime timestamp) async {
    Uri url = Uri.http(kBaseUrl, '/gram-activity-comment');
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
          (await http.put(url, body: data, headers: headers));
      if (response.statusCode == 200) {
        isCommentUpdated = true;
        print(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }

      debugPrintStack();
    }
  }
}
