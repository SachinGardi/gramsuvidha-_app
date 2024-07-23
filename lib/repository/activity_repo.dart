import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/utility/utilityMethods.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../blocs/application_bloc.dart';
import '../modal/activityModal.dart';
import '../utility/constant.dart';
import '../view/activityform.dart';
import '../view_modal/getDashboardActivityVm.dart';

class ActivityRepo {
  static final getDashboardActivityVm = Get.put(GetDashboardActivityVm());

  static List<ActivityModal> activity = [];

  static var headers = {
    'Content-Type': 'application/json',
  };

  static activityData(
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
      BuildContext context) async {
    var headers = {'Content-Type': 'application/json'};
    var applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);

    try {
      var request = http.Request(
          'POST', Uri.parse('http://$kBaseUrl/GramSuvidhaActivity'));
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
        applicationBloc.showUpdateButton(false, 0);
        ActivityFormsState.imageSelected!.clear();
        titleController.clear();
        descriptionController.clear();
        gramSuvidhaActivity.clear();
        UtilityMethods.snackBarMethod(context, 'postSaveMsg'.tr);
        Get.offAndToNamed('/gramSuvidhaDashboardScreen');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      print(e);
      debugPrintStack();
    }
  }
}
