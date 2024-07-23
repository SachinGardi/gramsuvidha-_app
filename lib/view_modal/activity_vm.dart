import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/modal/activityModal.dart';
import 'package:gramsuvidha/repository/activity_repo.dart';
import 'package:gramsuvidha/repository/activity_update_repo.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import 'package:provider/provider.dart';

import '../blocs/application_bloc.dart';
import '../view/activityform.dart';

class ActivityVM extends GetxController {
  var isLoading = true.obs;

  ///Activity post api call
  activityInfo(ActivityModal activityModal, BuildContext context) async {
    var applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    await ActivityRepo.activityData(
        userIdValue.read('userId'),
        0,
        DateTime.now(),
        DateTime.now(),
        true,
        0,
        titleController.text,
        descriptionController.text,
        DateTime.now(),
        1,
        applicationBloc.address,
        applicationBloc.lat.toString(),
        applicationBloc.lang.toString(),
        DateTime.now(),
        gramPanchayatIdValue.read("gramPanId"),
        activityImages,
        context);
  }

  ///Activity Update api call
  activityUpdate(
      ActivityModal activityModal, BuildContext context, int activityId) async {
    var applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);

    await ActivityUpdateRepo.activityUpdateData(
        userIdValue.read('userId'),
        0,
        DateTime.now(),
        DateTime.now(),
        true,
        activityId,
        titleController.text,
        descriptionController.text,
        DateTime.now(),
        1,
        applicationBloc.address,
        applicationBloc.lat.toString(),
        applicationBloc.lang.toString(),
        DateTime.now(),
        gramPanchayatIdValue.read("gramPanId"),
        activityImages,
        context);
  }
}
