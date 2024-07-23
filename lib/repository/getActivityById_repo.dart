import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../modal/getActivityByIdModal.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class GetActivityByIdRepo {
  static List<GetActivityByIdModal> getActivityByIdList = [];

  static getActivityById(int activityId) async {
    var queryParams = {'ActivityId': '$activityId'};
    Uri url = Uri.http(kBaseUrl,
        '/GramSuvidhaActivity/Get_DashboardDataBy_ActivityId', queryParams);

    try {
      http.Response response = (await http.get(url));
      if (response.statusCode == 200) {
        getActivityByIdList.clear();
        final res = jsonDecode(response.body);
        final data = GetActivityByIdModal.fromJson(res['responseData']);
        getActivityByIdList.add(data);
        return getActivityByIdList;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      debugPrintStack();
    }
  }
}
