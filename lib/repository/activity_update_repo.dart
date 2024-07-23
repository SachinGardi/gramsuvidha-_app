import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/utility/utilityMethods.dart';
import 'package:http/http.dart' as http;
import '../modal/activityModal.dart';
import '../utility/constant.dart';
import '../view_modal/getActivityByIdVm.dart';
import '../view_modal/getDashboardActivityVm.dart';

class ActivityUpdateRepo {
  static final getDashboardActivityVm = Get.put(GetDashboardActivityVm());
  static final  getActivityByIdVm = Get.put(GetActivityByIdVm());
  static List<ActivityModal> activity = [];

  static var headers = {
    'Content-Type': 'application/json',
  };

  static activityUpdateData(
      int createdBy,
      int modifiedBy,
      DateTime createdDate,
      DateTime modifiedDate,
      bool isDeleted,
      int id,
      String title,
      String description,
      DateTime activityDate,
      int categoryId,
      String locationName,
      String latitude,
      String longitude,
      DateTime timestamp,
      int grampanchayatId,
      List<GramSuvidhaActivity> gramSuvidhaActivity,
      BuildContext context
      ) async {
    var headers = {'Content-Type': 'application/json'};

    try {
      var request = http.Request('PUT',
          Uri.parse('http://$kBaseUrl/GramSuvidhaActivity'));
      request.body = json.encode({
        "createdBy": createdBy,
        "modifiedBy": modifiedBy,
        "createdDate": createdDate.toIso8601String(),
        "modifiedDate": modifiedDate.toIso8601String(),
        "isDeleted": isDeleted,
        "id": id,
        "title": title,
        "description": description,
        "activityDate": activityDate.toIso8601String(),
        "categoryId": categoryId,
        "locationName": locationName,
        "latitude": latitude,
        "longitude": longitude,
        "timestamp": timestamp.toIso8601String(),
        "grampanchayatId": grampanchayatId,
        "gramSuvidhaActivities": gramSuvidhaActivity
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        titleController.clear();
        descriptionController.clear();
        gramSuvidhaActivity.clear();
        getActivityByIdVm.updatedActivityImageLinks.clear();
        UtilityMethods.snackBarMethod(context, 'postUpdateMsg'.tr);
        Get.offAndToNamed('/gramSuvidhaDashboardScreen');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      print(e);
      debugPrintStack();
    }
  }
}
