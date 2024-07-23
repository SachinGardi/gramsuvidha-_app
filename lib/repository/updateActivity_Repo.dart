import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class UpdateActivityRepo {
  static var headers = {
    'Content-Type': 'application/json',
  };

  static updateActivity(
      int createdBy,
      int modifiedBy,
      // DateTime createdDate,
      DateTime modifiedDate,
      bool isDeleted,
      // int id,
      String title,
      String description,
      // DateTime activityDate,
      int categoryId,
      String locationName,
      String latitude,
      String longitude,
      // DateTime timestamp,
      int grampanchayatId,
      // List<GramSuvidhaActivity> gramSuvidhaActivities,
      BuildContext context) async {
    Uri url = Uri.http(kBaseUrl, '/GramSuvidhaActivity');
    var data = jsonEncode({
      'createdBy': createdBy,
      'modifiedBy': modifiedBy,
      // 'createdDate':createdDate,
      'modifiedDate': modifiedDate,
      'isDeleted': isDeleted,
      // 'id':id,
      'title': title,
      'description': description,
      // 'activityDate':activityDate,
      'categoryId': categoryId,
      'locationName': locationName,
      'latitude': latitude,
      'longitude': longitude,
      // 'timestamp':timestamp,
      'grampanchayatId': grampanchayatId,
      // 'gramSuvidhaActivities':gramSuvidhaActivities
    });

    try {
      http.Response response =
          (await http.put(url, headers: headers, body: data));
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
