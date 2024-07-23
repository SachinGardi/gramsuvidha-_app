import 'dart:async';
import 'package:get/get.dart';
import 'package:gramsuvidha/modal/getallactivity_modal.dart';
import 'package:gramsuvidha/repository/getallactivity_repo.dart';

class GetActivityVm extends GetxController {
  var isLoading = true.obs;
  List<GetAllActivityModal> getActivityList = [];

  getActivityData(int pageNo) async {
    var activityData = await GetAllActivityRepo.getActivityData(pageNo);
    print('********$activityData');
    if (activityData != null) {
      getActivityList = activityData;
      isLoading.value = false;
    } else {
      Timer(const Duration(seconds: 2), () {
        isLoading.value = false;
      });
    }
  }
}
