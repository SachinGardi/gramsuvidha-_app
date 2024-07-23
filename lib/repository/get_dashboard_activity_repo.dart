import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import '../modal/getDashboardActivityModal.dart';
import 'package:http/http.dart' as http;
import '../utility/constant.dart';

class GetDashBoardActivityRepo {
  static List<GetDashboardActivity> getDashboardActivityList = [];
  static List<DashboardActivityPageDetails> dashboardActivityPageDetails = [];

  static getDashboardActivityData(int page) async {
    var queryParams = {
      'UserId': '${userIdValue.read('userId')}',
      'pageno': '$page',
      'pagesize': '${10}'
    };
    Uri uri = Uri.http(
        kBaseUrl, '/GramSuvidhaActivity/Get_Dashboard_Activity', queryParams);
    try {
      http.Response response = (await http.get(uri));
      if (response.statusCode == 200) {
        print(response.body);
        Map res = jsonDecode(response.body);

        final value = DashboardActivityPageDetails.fromJson(
            res['responseData1']['responseData2']);
        dashboardActivityPageDetails.add(value);

        List<dynamic> data = res['responseData1']['responseData1'];

        for (var data in data) {
          getDashboardActivityList.add(
            GetDashboardActivity(
                id: data['id'],
                userName: data['userName'],
                adminName: data['adminName'],
                mobileNo: data['mobileNo'],
                title: data['title'],
                description: data['description'],
                locationName: data['locationName'],
                categoryId: data['categoryId'],
                activityDate: data['activityDate'],
                activityTime: data['activityTime'],
                createdDate: data['createdDate'],
                createdTime: data['createdTime'],
                likeConut: data['like_Conut'],
                profilePhoto: data['profilePhoto'],
                commentCount: data['comment_count'],
                shareCount: data['share_Count'],
                viewCount: data['view_Count'],
                grampanchayatId: data['grampanchayatId'],
                likeDislike: data['likeDislike'],
                dashboardActivityImages: data['dashboardActivity_Images'],
                dashboardActivityPageDetailsList: dashboardActivityPageDetails),
          );
        }
        return getDashboardActivityList;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception in Data $e");
      }
      debugPrintStack();
    }
  }
}
