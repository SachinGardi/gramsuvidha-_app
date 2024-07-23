import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class ActivityLikeRepo {
  static var headers = {
    'Content-Type': 'application/json',
  };

  static getActivityLikeCount(
    int createdBy,
    int modifiedBy,
    DateTime createdDate,
    DateTime modifiedDate,
    bool isDeleted,
    // int id,
    int activityId,
    int likeTypeId,
    String imageName,
    DateTime timestamp,
  ) async {
    Uri url = Uri.http(kBaseUrl, '/gram-activity-like');
    var data = jsonEncode({
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      'createdDate': createdDate.toIso8601String(),
      'modifiedDate': modifiedDate.toIso8601String(),
      'isDeleted': isDeleted,
      // 'id':id,
      'activityId': activityId,
      'likeTypeId': likeTypeId,
      'imageName': imageName,
      'timestamp': timestamp.toIso8601String()
    });
    try {
      http.Response response =
          (await http.post(url, headers: headers, body: data));
      if (response.statusCode == 200) {
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
