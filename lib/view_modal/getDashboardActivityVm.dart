import 'dart:async';
import 'package:get/get.dart';
import 'package:gramsuvidha/repository/get_dashboard_activity_repo.dart';
import '../modal/getDashboardActivityModal.dart';
import '../view/gramsuvidha_dashboard_screen.dart';

int? dashboardTotalPages;

class GetDashboardActivityVm extends GetxController {
  var isLoading = true.obs;
  List<GetDashboardActivity> getDashboardActivityData = [];
  List<DashboardActivityImage> getActivityImageList = [];
  List<DashboardActivityPageDetails> dashboardActivityPageDetails = [];

  List<dynamic> getImagePath = [];

  getDashboardActivity(int pageNo) async {
    var dashBoardActivityData =
        await GetDashBoardActivityRepo.getDashboardActivityData(page);
    if (dashBoardActivityData != null) {
      getDashboardActivityData = dashBoardActivityData;
      isLoading.value = false;
    } else {
      Timer(const Duration(seconds: 2), () {
        isLoading.value = false;
      });
    }

    for (var data in getDashboardActivityData) {
      for (var pageDetail in data.dashboardActivityPageDetailsList) {
        dashboardTotalPages = pageDetail.totalPages;
      }
    }

    print('#####$dashboardTotalPages#####');
  }

/*    for(int i = 0;i< 3;i++){
      if(getDashboardActivityData[i].dashboardActivityImages.isNotEmpty){
        print(getDashboardActivityData[i].dashboardActivityImages[i]);
        getImagePath.add(getDashboardActivityData[i].dashboardActivityImages[i]);
      }
    }*/
}
