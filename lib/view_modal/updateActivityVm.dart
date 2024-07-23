import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gramsuvidha/modal/updateActivityModal.dart';
import 'package:gramsuvidha/repository/updateActivity_Repo.dart';
import 'package:gramsuvidha/utility/textcontroller.dart';
import 'package:gramsuvidha/view_modal/post_otp_vm.dart';
import 'package:provider/provider.dart';
import '../blocs/application_bloc.dart';
import '../view/activityform.dart';

class UpdateActivityVm extends GetxController {
  updateActivity(
      UpdateActivityModal updateActivity, BuildContext context) async {
    var applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);

    await UpdateActivityRepo.updateActivity(
        userIdValue.read('userId'),
        userIdValue.read('userId'),
        // createdDate,
        DateTime.now(),
        true,
        // id,
        titleController.text,
        descriptionController.text,
        // activityDate,
        ActivityFormsState.categoryId,
        applicationBloc.newAddressValue,
        applicationBloc.lat.toString(),
        applicationBloc.lang.toString(),
        // timestamp,
        0,
        // activityImages,
        context);
  }
}
