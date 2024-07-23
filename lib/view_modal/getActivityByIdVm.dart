import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:intl/intl.dart';
import '../modal/getActivityByIdModal.dart';
import '../repository/getActivityById_repo.dart';

class GetActivityByIdVm extends GetxController {
  List<GetActivityByIdModal> activityInfoList = [];
  String dropdownValue = '';
  final List<String> updatedActivityImageLinks = [];

  getActivityInfoByActivityId(GetActivityByIdModal getActivityById,
      int activityId, BuildContext context) async {
    await GetActivityByIdRepo.getActivityById(activityId);
    activityInfoList = GetActivityByIdRepo.getActivityByIdList;
    activityInfoList.forEach((element) {
      if (element.id == activityId) {
        updatedActivityImageLinks.clear();
        datePicController.text =
            DateFormat('dd/MM/yyyy').format(element.activityDate!);
        titleController.text = element.title!;
        descriptionController.text = element.description!;
        locationController.text = element.locationName!;
        // dropdownValue = WorkHistoryState.getCategoryById(element.categoryId!)!;

        element.gramSuvidhaActivities?.forEach((element) {
          updatedActivityImageLinks.add(element.imagePath);
        });
      }
    });
  }
}
