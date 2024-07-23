import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gramsuvidha/modal/getallactivity_modal.dart';
import 'package:http/http.dart' as http;
import '../modal/page_count_modal.dart';
import '../utility/constant.dart';
import '../view_modal/post_otp_vm.dart';

class GetAllActivityRepo {
  static List<GetAllActivityModal> getAllActivity = [];
  static PageCountModal pageCountInfo = PageCountModal();
  static bool hasMoreData = true;

  static getActivityData(int pageNo) async {
    var queryParameters = {
      "UserId": '${userIdValue.read('userId')}',
      "pageno": '$pageNo',
      "pagesize": '${20}',
      /* "FromDate": '',
      "ToDate": ''*/
    };

    Uri uri =
        Uri.http(kBaseUrl, "/GramSuvidhaActivity/GetAll", queryParameters);

    try {
      print(uri);
      http.Response response = (await http.get(uri));
      if (response.statusCode == 200) {
        Map temp = jsonDecode(response.body);
        if (temp.length < 10) {
          hasMoreData = false;
        }
        print(temp);
        temp['responseData']['responseData1'].forEach((data) {
          getAllActivity.add(GetAllActivityModal(
              id: data['id'],
              title: data['title'],
              description: data['description'],
              activityDate: data['activityDate'],
              categoryId: data['categoryId'],
              locationName: data['locationName'],
              latitude: data['latitude'],
              longitude: data['longitude'],
              timestamp: data['timestamp'],
              grampanchayatId: data['grampanchayatId'],
              gramSuvidhaActivities: data['gramSuvidhaActivities'],
              key: data['key'],
              createdBy: data['createdBy'],
              modifiedBy: data['modifiedBy'],
              createdDate: data['createdDate'],
              modifiedDate: data['modifiedDate'],
              isDeleted: data['isDeleted']));
        });
        var value =
            PageCountModal.fromJson(temp['responseData']['responseData2']);
        pageCountInfo = value;
        print(value.totalPages);
        print(getAllActivity.length);
        return getAllActivity;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception in Data $e');
      }
      debugPrintStack();
    }
  }
}
